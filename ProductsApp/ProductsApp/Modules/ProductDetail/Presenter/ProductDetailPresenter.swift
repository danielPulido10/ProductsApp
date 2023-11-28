//
//  ProductDetailPresenter.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    // MARK: - Private properties -
    
    private let model: ProductEntity
    
    init(model: ProductEntity) {
        self.model = model
    }
    
    // MARK: - Public methods -
    
    func getModel() -> ProductEntity {
        return model
    }
    
    func getAttributesCount() -> Int {
        return model.attributes.count
    }
    
    func getAttributeInfo(for indexPath: IndexPath) -> ProductAttribute? {
        guard let attribute = model.attributes.at(indexPath.row) else { return nil }
        return attribute
    }
    
}
