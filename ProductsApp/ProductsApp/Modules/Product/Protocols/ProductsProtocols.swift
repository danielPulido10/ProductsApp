//
//  ProductsProtocols.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import Alamofire

protocol ProductsRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    func presentProductDetail(model: ProductEntity)
}

protocol ProductsPresenterProtocol: AnyObject {
    var view: ProductViewProtocol? { get set }
    var router: ProductsRouterProtocol? { get set }
    var interactor: ProductsInteractorProtocol? { get set }
    
    func searchProduct(text: String)
    func getProductsCount() -> Int
    func getProductInfo(for indexPath: IndexPath) -> ProductEntity?
    func goToProductDetail(model: ProductEntity)
}

protocol ProductsInteractorProtocol: AnyObject {
    var presenter: ProductsInteractorOutputProtocol? { get set }
    
    func getProducts(product: String)
}

protocol ProductsInteractorOutputProtocol: AnyObject {
    func getProductsSuccess(products: ProductsModel)
    func getProductsFailed(error: ErrorType)
}

protocol ProductViewProtocol: AnyObject {
    func loadProductTable()
    func showErrorView(message: String)
}
