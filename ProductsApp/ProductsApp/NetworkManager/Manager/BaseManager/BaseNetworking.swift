//
//  BaseNetworking.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation

internal class BaseNetworking {
    internal let baseUrl = "https://api.mercadolibre.com/sites/MLA/"
    internal let statusOk = 200...299
}

enum Result<T, U> {
    case success(T)
    case failure(U)
}

enum ErrorType: Error, LocalizedError {
    case general
    case emptyInfo
    
    public var errorDescription: String {
        switch self {
        case .general:
            return Strings.error.general
        case .emptyInfo:
            return Strings.error.empty
        }
    }
}


