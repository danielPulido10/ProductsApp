//
//  NetworkingProtocols.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import Alamofire

protocol NetworkingServiceProtocol: AnyObject {
    func requestProducts(product: String, completion: @escaping (Result<ProductsModel, ErrorType>) -> Void)
}

protocol NetworkingProductsProtocol: AnyObject {
    var service: NetworkingServiceProtocol { get set }
    
    func getProducts(product: String, completion: @escaping (Result<ProductsModel, ErrorType>) -> Void)
}
