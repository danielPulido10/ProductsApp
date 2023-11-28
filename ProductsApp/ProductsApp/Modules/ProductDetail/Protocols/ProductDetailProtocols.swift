//
//  ProductDetailProtocols.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    func getModel() -> ProductEntity
    func getAttributesCount() -> Int
    func getAttributeInfo(for indexPath: IndexPath) -> ProductAttribute?
}
