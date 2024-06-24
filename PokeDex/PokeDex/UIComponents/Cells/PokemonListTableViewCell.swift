//
//  PokemonListTableViewCell.swift
//  PokeDex
//
//  Created by Salvatore Raso on 24/06/24.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(pokemon: PokemonListResponse){
        pokemonNameLabel.text = pokemon.name
//        let url = pokemon.url {
//            profileImage.kf.setImage(with: URL(string: url))
//        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
