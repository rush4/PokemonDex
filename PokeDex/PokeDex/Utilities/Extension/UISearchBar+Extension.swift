//
//  UISearchBar+Extension.swift
//  PokeDex
//
//  Created by Salvatore Raso on 26/06/24.
//

import UIKit
import Combine

public extension UISearchBar {
    var textDidChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UISearchBar)?.text }
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}

