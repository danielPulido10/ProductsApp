//
//  HomeRouter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation

final class HomeRouter: HomeRouterProtocol {
    weak var viewController: BaseViewController?
    
    func presentSearchProductScreen() {
        let productsViewController = ProductsModule.create()
        viewController?.navigationController?.pushViewController(productsViewController, animated: true)
    }
}
