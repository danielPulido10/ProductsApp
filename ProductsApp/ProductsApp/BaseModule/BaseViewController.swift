//
//  BaseViewController.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    private struct Constants {
        static let nameLogo: String = "Logo"
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.white.color
        navigationController?.navigationBar.backgroundColor = AppColors.purple.color
        navigationController?.navigationBar.tintColor = AppColors.white.color
        navigationItem.titleView = createLogo()
    }
            
    // MARK: - Private methods -
    
    private func createLogo() -> UIImageView {
        let logo = UIImageView()
        logo.image = UIImage(named: Constants.nameLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }
}
