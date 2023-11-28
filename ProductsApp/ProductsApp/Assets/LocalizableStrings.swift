//
//  LocalizableStrings.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation

extension String {
    var localizable: String {
        NSLocalizedString(self, comment: "ProductsApp Text")
    }
}

struct Strings {
    struct home {
        static var title: String { "home.title".localizable }
        static var description: String { "home.description".localizable }
        static var searchProducts: String { "home.searchProducts".localizable }
    }
    
    struct products {
        static var description: String { "products.description".localizable }
        static var withoutPrice: String { "products.withoutPrice".localizable }
        static var price: String { "products.price".localizable }
        static var errorMessage: String { "products.errorMessage".localizable }
        static var searchPlaceholder: String { "products.searchPlaceholder".localizable }
    }
    
    struct productDetail {
        static var country: String { "productDetail.country".localizable }
        static var city: String { "productDetail.city".localizable }
        static var nickname: String { "productDetail.nickname".localizable }
    }
    
    struct error {
        static var general: String { "error.general".localizable }
        static var empty: String { "error.empty".localizable }
    }
}
