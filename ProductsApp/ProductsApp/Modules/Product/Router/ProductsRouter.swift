//
//  ProductsRouter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation

class ProductsRouter: ProductsRouterProtocol {
    var viewController: BaseViewController?
    
    func presentProductDetail(model: ProductEntity) {
        let productDetailViewController = ProductDetailModule.create(model: model)
        viewController?.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
