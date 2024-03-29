//
//  DetailsViewController.swift
//  Project1-Echon
//
//  Created by Carloarlo Echon on 4/21/23.
//

import UIKit
import PokemonAPI

class DetailsViewController: UIViewController{
    var pokemonDetails: PokemonStruct?
    
    @IBOutlet weak var pokemonNameEntry: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            title = pokemonDetails?.name
        
            // Set the Pokemon name label
            pokemonNameEntry?.text = pokemonDetails?.name ?? "No Pokemon Name"
        
            // Set the Pokemon types labels
            if let types = pokemonDetails?.types {
                type1?.text = types.count >= 1 ? types[0] : ""
                type2?.text = types.count >= 2 ? types[1] : ""
            }
            
            // Load the Pokemon image
            if let pokemonName = pokemonDetails?.name {
                PokemonAPI().pokemonService.fetchPokemon(pokemonName) { result in
                    switch result {
                    case .success(let pokemon):
                        self.getImage(for: pokemon)
                    case .failure(let error):
                        print("Failed to fetch Pokemon image:", error.localizedDescription)
                    }
                }
            }
        }
        
        private func getImage(for pokemon: PKMPokemon) {
            guard let imageURLString = pokemon.sprites?.frontDefault, let imageURL = URL(string: imageURLString)
            else {
                print("Failed to get image URL for Pokemon")
                return
            }
            
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Failed to load Pokemon image:", error.localizedDescription)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data)
                else {
                    print("Failed to parse Pokemon image data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }.resume()
        }
            
}

