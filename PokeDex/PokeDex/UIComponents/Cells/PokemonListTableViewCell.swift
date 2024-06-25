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
        pokemonNameLabel.text = pokemon.name.capitalized
        let frontDefaultURL = pokemon.image
        pokemonImageView.kf.setImage(with: URL(string: frontDefaultURL))
        pokemonDescriptionLabel.text = pokemon.description
        
        categoriesStackView.removeAllArrangedSubviews()
        
        pokemon.types.map { item in
            let view = createCustomView(withText: item.type.name)
            categoriesStackView.addArrangedSubview(view)
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.categoriesStackView.removeArrangedSubview(<#T##view: UIView##UIView#>)
//    }
    
    func createCustomView(withText text: String) -> UIView {
            // Create the gray view
            let grayView = UIView()
            grayView.backgroundColor = .lightGray
            grayView.layer.cornerRadius = 10
            grayView.layer.shadowColor = UIColor.black.cgColor
            grayView.layer.shadowOpacity = 0.3
            grayView.layer.shadowOffset = CGSize(width: 2, height: 2)
            grayView.layer.shadowRadius = 4

            // Create the label
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            // Add the label to the gray view
            grayView.addSubview(label)

            // Set constraints for the label
        NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 8),
                    label.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -8),
                    label.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 8),
                    label.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -8)
                ])

            // Set constraints for the gray view (if needed)
            grayView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                grayView.heightAnchor.constraint(equalToConstant: 100) // Adjust height as needed
            ])

            return grayView
        }
    
}
