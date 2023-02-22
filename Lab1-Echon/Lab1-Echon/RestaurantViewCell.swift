//
//  RestaurantViewCell.swift
//  Lab1-Echon
//
//  Created by Carlo Echon on 2/22/23.
//

import UIKit

class RestaurantViewCell: UITableViewCell {
    let restaurantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let restaurantView: UIImageView = {
        let imageView = UIImageView()
        //hard setting the height and width of the UIImageView
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        setupUIV1()
    }

    func setupUIV1() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(restaurantView)
        stackView.addArrangedSubview(restaurantLabel)
        //to center the image and label in the cell
        stackView.alignment = .center

        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: Exhibiting lazy variables.
    lazy var string: String = {
        print("Creating string...")
        return "Test"
    }()

    func onTap() {
        print(string)
    }
}

