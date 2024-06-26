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
        setupSearchBar()
        configureCancellables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewIsReady()
    }
    
    func setupTable() {
        sourceDelegate = PokemonListTableViewSourceDelegate()
        sourceDelegate.getDataAndReloadTable = {
            if self.viewModel.pokemonListFiltered.count == 0 {
                self.viewModel.retrieveData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.pokemonListTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        pokemonListTableView.registerNibWithClassType(type: PokemonListTableViewCell.self)
        pokemonListTableView.delegate = sourceDelegate
        pokemonListTableView.dataSource = sourceDelegate
        
    }
    
    private func setupSearchBar() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self.searchBar.searchTextField)
        
        publisher
            .compactMap { ($0.object as? UISearchTextField)?.text }
            .sink { [weak self] string in
                self?.viewModel.searchData(query: string)
            }
            .store(in: &cancellable)
    }
    
    func configureCancellables() {
        viewModel.$pokemonList.sink { [weak self] value in
            DispatchQueue.main.async {
                self?.sourceDelegate.items = value
                self?.pokemonListTableView.reloadData()
            }
        }
        .store(in: &cancellable)
        viewModel.$pokemonListFiltered.sink { [weak self] value in
                    if value.count != 0 {
                DispatchQueue.main.async {
                    self?.sourceDelegate.items = value
                    self?.pokemonListTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self?.sourceDelegate.items = self?.viewModel.pokemonList ?? []
                    self?.pokemonListTableView.reloadData()
                }
            }
        }
        .store(in: &cancellable)
    }
}

