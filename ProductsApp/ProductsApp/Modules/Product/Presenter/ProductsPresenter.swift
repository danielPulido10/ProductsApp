//
//  ProductsPresenter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import Alamofire

class ProductsPresenter: ProductsPresenterProtocol {
    
    // MARK: - Public properties -
    
    weak var view: ProductViewProtocol?
    var router: ProductsRouterProtocol?
    var interactor: ProductsInteractorProtocol?
    
    
    private var listProducts: ProductsModel? = nil
    
    // MARK: - Public methods -
    
    func searchProduct(text: String) {
        guard let interactor else { return }
        interactor.getProducts(product: text)
    }
    
    func getProductsCount() -> Int {
        return listProducts?.results.count ?? .zero
    }
    
    func getProductInfo(for indexPath: IndexPath) -> ProductEntity? {
        guard let currentModel = listProducts?.results.at(indexPath.row) else { return nil }
        return ProductEntity(model: currentModel)
    }
    
    func goToProductDetail(model: ProductEntity) {
        guard let router else { return }
        router.presentProductDetail(model: model)
    }
}

extension ProductsPresenter: ProductsInteractorOutputProtocol {
    func getProductsSuccess(products: ProductsModel) {
        self.listProducts = products
        view?.loadProductTable()
    }
    
    func getProductsFailed(error: ErrorType) {
        view?.showErrorView(message: error.errorDescription)
    }
}
