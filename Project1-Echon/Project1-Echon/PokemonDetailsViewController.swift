//
//  PokemonDetailsViewController.swift
//  Project1-Echon
//
//  Created by Carlo Echon on 4/26/23.
//

import UIKit
import PokemonAPI

class PokemonDetailsViewController: UIViewController{
    var pokemonDetails: PokemonStruct?
    
    
    
    
    @IBOutlet weak var PokemonType2: UILabel!
    @IBOutlet weak var PokemonType1: UILabel!
    @IBOutlet weak var PokemonImage: UIImageView!
    @IBOutlet weak var PokemonName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Set the Pokemon name label
        PokemonName?.text = pokemonDetails?.name ?? "No Pokemon Name"
    
        title = pokemonDetails?.name
        
         //Set the Pokemon types labels
        if let types = pokemonDetails?.types {
            PokemonType1.text = types.count >= 1 ? types[0] : ""
            PokemonType2.text = types.count >= 2 ? types[1] : ""
        }
        
        // Load the Pokemon image
        //if let pokemonName = pokemonDetails?.name {
          //  PokemonAPI().pokemonService.fetchPokemon(pokemonName) { result in
            //    switch result {
              //  case .success(let pokemon):
                //    self.getImage(for: pokemon)
                //case .failure(let error):
                  //  print("Failed to fetch Pokemon image:", error.localizedDescription)
                //}
            //}
        //}
   // }
    
    //private func getImage(for pokemon: PKMPokemon) {
      //  guard let imageURLString = pokemon.sprites?.frontDefault, let imageURL = URL(string: imageURLString)
        //else {
          //  print("Failed to get image URL for Pokemon")
            //return
        //}
        
        //URLSession.shared.dataTask(with: imageURL) { data, _, error in
          //  if let error = error {
            //    print("Failed to load Pokemon image:", error.localizedDescription)
              //  return
            //}
            
            //guard let data = data, let image = UIImage(data: data)
            //else {
              //  print("Failed to parse Pokemon image data")
                //return
            //}
            
            //DispatchQueue.main.async {
              //  self.PokemonImage.image = image
            //}
        //}.resume()
    }
}
