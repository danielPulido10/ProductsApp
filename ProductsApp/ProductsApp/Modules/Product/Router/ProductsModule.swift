//
//  ProductsModule.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation

final class ProductsModule {
    
    static func create() -> ProductsViewController {
        let view = ProductsViewController()
        
        let presenter: ProductsPresenterProtocol & ProductsInteractorOutputProtocol = ProductsPresenter()
        
        let router = ProductsRouter()
        router.viewController = view
        
        let interactor = ProductsInteractor()
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        view.presenter = presenter
        return view
    }
}
