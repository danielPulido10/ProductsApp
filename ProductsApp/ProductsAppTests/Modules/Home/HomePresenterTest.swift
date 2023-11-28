//
//  HomePresenterTest.swift
//  ProductsAppTests
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import XCTest
@testable import ProductsApp

class HomePresenterTest: XCTestCase {
    private var mockedRouter: MockRouter!
    private var sut: HomePresenter!
    
    override func setUpWithError() throws {
        mockedRouter = MockRouter()
        sut = HomePresenter()
        sut.router = mockedRouter
    }
    
    override func tearDownWithError() throws {
        mockedRouter = nil
        super.tearDown()
    }
    
    func testPresentSearchProductScreen() {
        // When
        sut.goToSearchProductScreen()
        
        // Then
        XCTAssertEqual(mockedRouter.invocations, [.presentSearchProductScreen])
    }
}

extension HomePresenterTest {
    final class MockRouter: HomeRouterProtocol {
        var viewController: ProductsApp.BaseViewController?
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case presentSearchProductScreen
        }
        
        func presentSearchProductScreen() {
            invocations.append(.presentSearchProductScreen)
        }
    }
}
