//
//  ProductPresenterTest.swift
//  ProductsAppTests
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import XCTest
import Alamofire
@testable import ProductsApp

class ProductsPresenterTest: XCTestCase {
    private var mockedInteractor: MockProductsInteractor!
    private var mockedView: MockProductsView!
    private var mockedRouter: MockProductsRouter!
    private var sut: ProductsPresenter!
    
    override func setUpWithError() throws {
        mockedInteractor = MockProductsInteractor()
        mockedView = MockProductsView()
        mockedRouter = MockProductsRouter()
        sut = ProductsPresenter()
        sut.interactor = mockedInteractor
        sut.view = mockedView
        sut.router = mockedRouter
    }
    
    override func tearDownWithError() throws {
        mockedView = nil
        mockedRouter = nil
        mockedInteractor = nil
    }
    
    func testSearchProduct() {
        // When
        sut.searchProduct(text: "Prueba")
        
        // Then
        XCTAssertEqual(mockedInteractor.invocations, [.getProducts])
    }
    
    func testPresentProductDetail() {
        // When
        sut.goToProductDetail(model: DummyData.model)
        
        // Then
        XCTAssertEqual(mockedRouter.invocations, [.presentProductDetail])
    }
    
    func testLoadProductTable() {
        // When
        sut.getProductsSuccess(products: DummyData.productModel)
        
        // Then
        XCTAssertEqual(mockedView.invocations, [.loadProductTable])
    }
    
    func testShowErrorView() {
        // When
        sut.getProductsFailed(error: AFError.explicitlyCancelled)
        
        // Then
        XCTAssertEqual(mockedView.invocations, [.showErrorView])
    }
}

extension ProductsPresenterTest {
    class MockProductsInteractor: ProductsInteractorProtocol {
        var presenter: ProductsInteractorOutputProtocol?
        
        var invocations: [Invocation] = []
        
        enum Invocation: Comparable {
            case getProducts
        }
        
        func getProducts(product: String) {
            invocations.append(.getProducts)
        }
    }
    
    class MockProductsView: ProductViewProtocol {
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case loadProductTable
            case showErrorView
        }
        
        func loadProductTable() {
            invocations.append(.loadProductTable)
        }
        
        func showErrorView() {
            invocations.append(.showErrorView)
        }
    }
    
    class MockProductsRouter: ProductsRouterProtocol {
        var viewController: ProductsApp.BaseViewController?
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case presentProductDetail
        }
        
        func presentProductDetail(model: ProductsApp.ProductEntity) {
            invocations.append(.presentProductDetail)
        }
    }
    
    struct DummyData {
        static let model = ProductEntity(model: ProductsModel.Product())
        static let productModel = ProductsModel(results: [ProductsModel.Product()])
    }
}
