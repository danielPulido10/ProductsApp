//
//  ProductsInteractor.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation

class ProductsInteractor: ProductsInteractorProtocol {
    var presenter: ProductsInteractorOutputProtocol?
    var networkingProductsAdapter: NetworkingProductsProtocol
    
    init(networkingProductsAdapter: NetworkingProductsProtocol = NetworkingProductsAdapter()) {
        self.networkingProductsAdapter = networkingProductsAdapter
    }
    
    func getProducts(product: String) {
        networkingProductsAdapter.getProducts(product: product) { [weak self] (response) in
            guard let self else { return }
            switch response {
            case .success(let products):
                self.presenter?.getProductsSuccess(products: products)
            case .failure(let error):
                self.presenter?.getProductsFailed(error: error)
            }
        }
    }
}
