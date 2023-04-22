//
//  PokemonViewController.swift
//  Project1-Echon
//
//  Created by Katrina Echon on 4/21/23.
//

import UIKit
import PokemonAPI

struct PokemonStruct {
    let nameKey: String
    var name: String {
        return NSLocalizedString(nameKey, comment: "")
    }
    var types: [String]?
    var pokemonURL: String?
}


class MainViewController: UITableViewController {
    private static let mainCellReuseIdentifier = "pls let this work"
    
    var pokemons = (1...151).map {
        PokemonStruct(nameKey: "pokemon-name-\($0)")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            PokemonViewCell.self, // changed from PokemonViewCell.self
            forCellReuseIdentifier: MainViewController.mainCellReuseIdentifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        
        let formatTitle = NSLocalizedString("app-title", comment: "")
        let formattedTitle = String(format: formatTitle)
        
        title = formattedTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainViewController.mainCellReuseIdentifier,
            for: indexPath
        ) as? PokemonViewCell else {
            return UITableViewCell()
        }

        let pokemon = pokemons[indexPath.row]
        let formattedPokemonName = String(format: NSLocalizedString(pokemon.nameKey, comment: ""), pokemon.name)
        cell.pokemonNameLabel.text = formattedPokemonName


        return cell
    }


    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)

           let pokemon = pokemons[indexPath.row]
           let nameComponents = pokemon.nameKey.components(separatedBy: "-")
           let pokemonName = nameComponents.last ?? pokemon.nameKey

           PokemonAPI().pokemonService.fetchPokemon(pokemonName) { result in
               switch result {
               case .success(let pokemon):
                   print("It worked")
                   
                   print(pokemon.name)
                   if let types = pokemon.types?.map({($0.type?.name)!}).joined(separator: ", ") {
                           print("Types: \(types)")
                           if let index = self.pokemons.firstIndex(where: { $0.nameKey == pokemonName }) {
                               self.pokemons[index].types = pokemon.types?.map { $0.type?.name ?? "" }
                               self.pokemons[index].pokemonURL = pokemon.sprites?.frontDefault ?? ""
                            }
                       }
                   if let imageUrl = pokemon.sprites?.frontDefault {
                                   print("Image URL: \(imageUrl)")
                               }
               case .failure(let error):
                   print("It failed")
                   print(error.localizedDescription)
               }
           }
       }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

}

