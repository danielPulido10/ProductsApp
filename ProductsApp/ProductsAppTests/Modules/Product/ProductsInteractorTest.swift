//
//  ProductsInteractorTest.swift
//  ProductsAppTests
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import XCTest
import Alamofire
@testable import ProductsApp

class ProductsInteractorTest: XCTestCase {
    private var mockedPresenter: MockProductsPresenter!
    private var sut: ProductsInteractor!
    
    override func setUpWithError() throws {
        mockedPresenter = MockProductsPresenter()
        sut = ProductsInteractor()
        sut.presenter = mockedPresenter
    }
    
    override func tearDownWithError() throws {
        mockedPresenter = nil
        super.tearDown()
    }
    
    func testGetProductsSuccess() {
        // Given
        mockedPresenter.expectationSuccess = expectation(description: #function)
        sut.networkingProductsAdapter = NetworkingProductsAdapter()
        
        // When
        sut.getProducts(product: "Moto")
        
        //Then
        wait(for: [mockedPresenter.expectationSuccess], timeout:  4)
        XCTAssertEqual(mockedPresenter.invocations, [.getProductsSuccess])
    }
    
    func testGetProductsFailure() {
        // Given
        mockedPresenter.expectationFailure = expectation(description: #function)
        sut.networkingProductsAdapter = NetworkingProductsAdapter()
        
        // When
        sut.getProducts(product: String())
        
        //Then
        wait(for: [mockedPresenter.expectationFailure], timeout:  4)
        XCTAssertEqual(mockedPresenter.invocations, [.getProductsFailed])
    }
}

extension ProductsInteractorTest {
    class MockProductsPresenter: ProductsInteractorOutputProtocol {
        var expectationSuccess: XCTestExpectation!
        var expectationFailure: XCTestExpectation!
        var view: ProductsApp.ProductViewProtocol?
        var router: ProductsApp.ProductsRouterProtocol?
        var interactor: ProductsApp.ProductsInteractorProtocol?
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case getProductsSuccess
            case getProductsFailed
        }
        
        func getProductsSuccess(products: ProductsApp.ProductsModel) {
            invocations.append(.getProductsSuccess)
            expectationSuccess?.fulfill()
        }
        
        func getProductsFailed(error: AFError) {
            invocations.append(.getProductsFailed)
            expectationFailure?.fulfill()
        }
    }
}
