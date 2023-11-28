//
//  Products.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation

struct ProductsModel: Codable {
    let results: [Product]
    
    struct Product: Codable {
        var id: String?
        var title: String?
        var thumbnail: String?
        var price: Double?
        var condition: String?
        var seller: Seller?
        var sellerAddress: SellerAddress?
        var attributes: [Attributes]?
        
        enum CodingKeys: String, CodingKey {
            case id,
                 title,
                 thumbnail,
                 price,
                 condition,
                 seller,
                 attributes
            case sellerAddress = "seller_address"
        }
    }
    
    struct Seller: Codable {
        let nickname: String?
    }
    
    struct SellerAddress: Codable {
        let country: Country?
        let city: City?
    }
    
    struct Country: Codable {
        let name: String?
    }
    
    struct City: Codable {
        let name: String?
    }
    
    struct Attributes: Codable {
        var name: String?
        var value: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case value = "value_name"
        }
    }
}

class ProductEntity {
    var id: String? = nil
    var title: String? = nil
    var image: String? = nil
    var price: String? = nil
    var isNew: Bool = false
    var attributes: [ProductAttribute] = []
    
   init(model: ProductsModel.Product) {
       self.id = model.id
       self.title = model.title
       self.image = model.thumbnail
       self.price = addCurrencyFormat(price: model.price)
       self.isNew = validateIfIsNew(condition: model.condition)
       addPrincipalAttributes(model: model)
    }
    
    private func addCurrencyFormat(price: Double?) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let price,
              let formattedPrice = formatter.string(from: price as NSNumber) else { return Strings.products.withoutPrice }
        return formattedPrice
    }
    
    private func validateIfIsNew(condition: String?) -> Bool {
        if let condition {
            return condition == "new"
        }
        return false
    }
    
    private func addPrincipalAttributes(model: ProductsModel.Product) {
        validateAndAddAttributes(name: Strings.productDetail.nickname, value: model.seller?.nickname)
        validateAndAddAttributes(name: Strings.productDetail.country, value: model.sellerAddress?.country?.name)
        validateAndAddAttributes(name: Strings.productDetail.city, value: model.sellerAddress?.city?.name)
        addOtherAttributes(attributes: model.attributes)
    }
    
    private func validateAndAddAttributes(name: String, value: String?) {
        if let value {
            attributes.append(ProductAttribute(title: name, description: value))
        }
    }
    
    private func addOtherAttributes(attributes: [ProductsModel.Attributes]?) {
        guard let attributes else { return }
        attributes.forEach({ attribute in
            guard let name = attribute.name,
                  let value = attribute.value else { return }
            self.attributes.append(ProductAttribute(title: name, description: value))
        })
    }
}

struct ProductAttribute {
    var title: String
    var description: String
}

