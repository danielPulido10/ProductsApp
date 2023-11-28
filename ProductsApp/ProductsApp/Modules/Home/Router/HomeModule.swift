//
//  HomeModule.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 25/11/23.
//

import Foundation

final class HomeModule {
    
    static func create() -> HomeViewController {
        let view = HomeViewController()
        
        var presenter: HomePresenterProtocol = HomePresenter()
        
        let router = HomeRouter()
        router.viewController = view
        
        presenter.router = router
        presenter.viewController = view
        
        view.presenter = presenter
        return view
    }
}
