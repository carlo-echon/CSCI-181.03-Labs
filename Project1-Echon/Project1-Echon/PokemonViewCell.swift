//
//  PokemonViewCell.swift
//  Project1-Echon
//
//  Created by Katrina Echon on 4/21/23.
//

import UIKit

class PokemonViewCell: UITableViewCell {
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokemonNameLabel)
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



