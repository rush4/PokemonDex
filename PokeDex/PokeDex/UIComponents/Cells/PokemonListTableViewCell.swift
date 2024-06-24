//
//  PokemonListTableViewCell.swift
//  PokeDex
//
//  Created by Salvatore Raso on 24/06/24.
//

import UIKit
import Kingfisher

class PokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(pokemon: Pokemon){
        pokemonNameLabel.text = pokemon.name
        let frontDefaultURL = pokemon.sprites.other.officialArtwork.frontDefault
        pokemonImageView.kf.setImage(with: URL(string: frontDefaultURL))
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
