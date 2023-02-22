//
//  RestaurantViewController.swift
//  Lab1-Echon
//
//  Created by Carlo Echon on 2/22/23.
//

import UIKit

struct Restaurant {
    var imageName: String?
    var name: String
    var isTextHidden: Bool = false
    var isRestaurantHorizontal: Bool = false
}

class RestaurantViewController: UITableViewController {
    private static let restaurantCellReuseIdentifier = "plsLetThisWork"
    
    var restaurants = [
        Restaurant(imageName: "jollibeeImage", name: "Jolibee"),
        Restaurant(imageName: "mcdoPic", name: "McDonald's"),
        Restaurant(imageName: "Wendys", name: "Wendy's"),
        Restaurant(imageName: "tacoBelll", name: "Taco Bell"),
        Restaurant(imageName: "kFc", name: "KFC"),
        Restaurant(imageName: "burgerKing", name: "Burger King"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            RestaurantViewCell.self,
            forCellReuseIdentifier: RestaurantViewController.restaurantCellReuseIdentifier
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantViewController.restaurantCellReuseIdentifier,
            for: indexPath
        ) as? RestaurantViewCell
        else { return UITableViewCell() }

        let restaurant = restaurants[indexPath.row]
        cell.stackView.axis = restaurant.isRestaurantHorizontal ? .horizontal : .vertical
        cell.restaurantLabel.isHidden = restaurant.isTextHidden
        cell.restaurantLabel.text = restaurant.name
        //since the imageName is a string we needed to find a way to output an image while still receiving a String
        if let imageName = restaurant.imageName{
            cell.restaurantView.image = UIImage(named: imageName)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let restaurant = restaurants[indexPath.row]
        goToDetailsViewController(restaurant: restaurant)
    }
    
    func goToDetailsViewController(restaurant: Restaurant) {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "detailsVCID") as? DetailsViewController else { return }

        detailsViewController.restaurant = restaurant

        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
}
