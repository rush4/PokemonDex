//
//  PokemonListTableViewSourceDelegate.swift
//  PokeDex
//
//  Created by Salvatore Raso on 24/06/24.
//

import UIKit

class PokemonListTableViewSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, CellDequeuer {
        
    var items: [Pokemon] = [] {
        didSet {
            reloadTable?()
        }
    }
    
    var reloadTable: (() -> Void)?
    var itemSelected: ((_ index: Int) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonListTableViewCell = dequeueCell(tableView: tableView, indexPath: indexPath)
        
        cell.setup(pokemon: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        items[indexPath.row].isSelected = true
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        items[indexPath.row].isSelected = false
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            itemSelected?(indexPath.row)
        }
    }
}

extension UITableView {
    func registerNibWithClassType<T: AnyObject>(type _: T.Type) {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
}

