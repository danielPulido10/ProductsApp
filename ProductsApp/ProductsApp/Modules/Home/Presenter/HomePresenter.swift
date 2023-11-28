//
//  HomePresenter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    var viewController: BaseViewController?
    var router: HomeRouterProtocol?
    
    func goToSearchProductScreen() {
        guard let router else { return }
        router.presentSearchProductScreen()
    }
}
