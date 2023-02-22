//
//  DetailsViewController.swift
//  Lab1-Echon
//
//  Created by Carlo Echon on 2/22/23.
//

import UIKit

class DetailsViewController: UIViewController{
    var restaurant: Restaurant?
   
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            textLabel?.text = restaurant?.name ?? "No Restaurant Name"
            if let imageName = restaurant?.imageName {
                   let image = UIImage(named: imageName)
                   imageRestaurant.image = image
                   
                   // Resize the image
                   imageRestaurant.translatesAutoresizingMaskIntoConstraints = false
                   imageRestaurant.widthAnchor.constraint(equalToConstant: 100).isActive = true
                   imageRestaurant.heightAnchor.constraint(equalToConstant: 100).isActive = true
                                    
               }
            
        }
}
