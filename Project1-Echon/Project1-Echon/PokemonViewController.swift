//
//  PokemonViewController.swift
//  Project1-Echon
//
//  Created by Carlo Echon on 4/21/23.
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
        let formattedPokemonName = pokemon.name
        cell.pokemonNameLabel.text = formattedPokemonName


        return cell
    }


    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)

           var pokemon = pokemons[indexPath.row]
           let nameComponents = pokemon.nameKey.components(separatedBy: "-")
           let pokemonName = nameComponents.last ?? pokemon.nameKey
        guard let pokemonDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "detailsVCID") as? DetailsViewController else {return}
        pokemonDetailsViewController.pokemonDetails = pokemon
           navigationController?.pushViewController(pokemonDetailsViewController, animated: true)

        PokemonAPI().pokemonService.fetchPokemon(pokemonName) { [self] result in
               switch result {
               case .success(let pokemonRetrieve):
                   print("It worked")
                   print(pokemon.nameKey)
                   print(pokemon.name)
                   print(pokemonRetrieve.name)
                   print(pokemonRetrieve.types)
                   print(pokemonRetrieve.sprites?.frontDefault)
                   if let types = pokemonRetrieve.types?.map({ $0.type?.name ?? "" }).joined(separator: ", ") {
                       pokemon.types = types.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
                   }
                   if let pokemonURLString = pokemonRetrieve.sprites?.frontDefault {
                        pokemon.pokemonURL = pokemonURLString
                   }
                   print(pokemon.types)
                   print(pokemon.pokemonURL)
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

