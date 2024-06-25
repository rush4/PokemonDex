//
//  CellDequeuer.swift
//  PokeDex
//
//  Created by Salvatore Raso on 24/06/24.
//

import Foundation
import UIKit

protocol CellDequeuer {
    func dequeueCell<T: UITableViewCell> (tableView: UITableView, indexPath: IndexPath) -> T
}

extension CellDequeuer {
    
    func dequeueCell<T: UITableViewCell> (tableView: UITableView, indexPath: IndexPath) -> T {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: className, for: indexPath) as? T
            else {
                fatalError("\(className) must have the right identifer")
        }
        
        return cell
    }
}

