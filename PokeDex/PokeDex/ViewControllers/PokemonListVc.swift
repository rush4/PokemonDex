//
//  PokemonListVc.swift
//  PokeDex
//
//  Created by Salvatore Raso on 21/06/24.
//

import UIKit
import Combine

class PokemonListVc: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonListTableView: UITableView!
    
    var sourceDelegate: PokemonListTableViewSourceDelegate!
    
    var viewModel : PokemonListVm!
    
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        setupTable()
        configureCancellables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewIsReady()
    }
    
    func setupTable() {
        sourceDelegate = PokemonListTableViewSourceDelegate()
        pokemonListTableView.registerNibWithClassType(type: PokemonListTableViewCell.self)
        pokemonListTableView.delegate = sourceDelegate
        pokemonListTableView.dataSource = sourceDelegate
    }
    
    func setupSearchBar(){
        
        self.searchBar.delegate = self
    }
    
    func configureCancellables() {
        viewModel.$pokemonList.sink { [weak self] value in
            DispatchQueue.main.async {
                self?.sourceDelegate.items = value
                self?.pokemonListTableView.reloadData()
            }
        }
        .store(in: &cancellable)
    }
}

