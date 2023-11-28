//
//  NetworkingService.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import Alamofire

final class NetworkingService: BaseNetworking, NetworkingServiceProtocol {
    func requestProducts(product: String,
                         completion: @escaping (Result<ProductsModel, ErrorType>) -> Void) {
        guard let url = URL(string: "\(baseUrl)search?q=\(product)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                AF.request(url, method: .get).validate(statusCode: self.statusOk).responseDecodable(of: ProductsModel.self){
                    response in
                    switch response.result {
                    case .success(let product):
                        completion(.success(product))
                        print(product)
                    case .failure(let error):
                        completion(.failure(ErrorType.general))
                        print(error)
                    }
                }
            }
        }.resume()
    }
}
