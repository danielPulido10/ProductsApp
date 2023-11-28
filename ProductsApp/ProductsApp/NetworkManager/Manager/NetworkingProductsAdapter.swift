//
//  NetworkingProductsAdapter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import Alamofire

final class NetworkingProductsAdapter: NetworkingProductsProtocol {
    var service: NetworkingServiceProtocol = NetworkingService()
    
    func getProducts(product: String,
                  completion: @escaping (Result<ProductsModel, ErrorType>) -> Void) {
        service.requestProducts(product: product) { (data) in
            switch data {
            case .success(let users):
                if users.results.isEmpty {
                    completion(.failure(ErrorType.emptyInfo))
                    return
                }
                completion(.success(users))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
