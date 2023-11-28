//
//  ProductDetailModule.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation

final class ProductDetailModule {
    
    static func create(model: ProductEntity) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        
        let presenter: ProductDetailPresenterProtocol = ProductDetailPresenter(model: model)
        
        view.presenter = presenter
        return view
    }
}
