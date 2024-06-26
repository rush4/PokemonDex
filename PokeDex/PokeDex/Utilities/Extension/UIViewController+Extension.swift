//
//  UIViewController+Extension.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import UIKit

extension UIViewController {
    
    func loadView() {
        let nibName = String(describing: Self.self)
        let customView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
        view.backgroundColor = .white
        view = customView
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
