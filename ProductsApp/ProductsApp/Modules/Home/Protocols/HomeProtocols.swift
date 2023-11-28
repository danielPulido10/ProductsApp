//
//  HomeProtocols.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    func presentSearchProductScreen()
}

protocol HomePresenterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func goToSearchProductScreen()
}
