//
//  PokemonListVc.swift
//  PokeDex
//
//  Created by Salvatore Raso on 21/06/24.
//

import UIKit
import Combine

class PokemonListVc: UIViewController {
    
    
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
        
//        sourceDelegate.itemSelected = { item in
//            self.viewModel.deleteUser(int: item)
//        }
    }
    
    func configureCancellables() {
        viewModel.$pokemonList.sink { [weak self] value in
            self?.pokemonListTableView.reloadData()
        }
        .store(in: &cancellable)
    }
}

