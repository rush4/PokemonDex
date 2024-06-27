//
//  MainCoordinator.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation
import UIKit

public class MainCoordinator: NSObject {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // This method set the delegate of navigation controller and configure the Coordinator first view
    func start() {
        navigationController?.delegate = self
        configureFirstController()
    }
    
    private func configureFirstController() {
        
        let viewController = PokemonListVc(nibName: "PokemonListVc", bundle: Bundle.main)
        let viewModel = PokemonListVm()
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// Delegate methods for UINavigationControllerDelegate
extension MainCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool){
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}



