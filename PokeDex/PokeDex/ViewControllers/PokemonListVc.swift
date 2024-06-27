//
//  PokemonListVc.swift
//  PokeDex
//
//  Created by Salvatore Raso on 21/06/24.
//

import UIKit
import Combine

class PokemonListVc: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonListTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    var sourceDelegate: PokemonListTableViewSourceDelegate?
    var viewModel : PokemonListVm?
    
    var spinner : SpinnerViewController?
    
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        setupTable()
        setupSearchBar()
        configureCancellables()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewIsReady()
    }
    
    func setupTable() {
        sourceDelegate = PokemonListTableViewSourceDelegate()
        sourceDelegate?.getDataAndReloadTable = {
            if self.viewModel?.pokemonListFiltered.count == 0 {
                self.viewModel?.retrieveData()
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
                self?.viewModel?.searchData(query: string)
            }
            .store(in: &cancellable)
    }
    
    func configureCancellables() {
        viewModel?.$pokemonListToShow
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.sourceDelegate?.items = value
                self?.pokemonListTableView.reloadData()
            }
            .store(in: &cancellable)
        viewModel?.$pokemonListFiltered
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if let query = self?.viewModel?.queryToSearch, !query.isEmpty {
                    self?.sourceDelegate?.items = value
                    self?.pokemonListTableView.reloadData()
                } else {
                    self?.sourceDelegate?.items = self?.viewModel?.pokemonListToShow ?? []
                    self?.pokemonListTableView.reloadData()
                }
            }
            .store(in: &cancellable)
        viewModel?.$serviceInError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.errorView.isHidden = !value
                self?.pokemonListTableView.isHidden = value
            }
            .store(in: &cancellable)
        viewModel?.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                
                isLoading ? (self?.showSpinnerView()) : (self?.hideSpinnerView())
            }
            .store(in: &cancellable)
    }
    
    
    @IBAction func retryActionButton(_ sender: Any) {
        viewModel?.viewIsReady()
    }
}

extension PokemonListVc {
    
    func showSpinnerView() {
        let child = SpinnerViewController()
        self.spinner = child

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    func hideSpinnerView() {
        
        // wait two seconds to simulate some work happening
        // then remove the spinner view controller
        self.spinner?.willMove(toParent: nil)
        self.spinner?.view.removeFromSuperview()
        self.spinner?.removeFromParent()
    }
}

