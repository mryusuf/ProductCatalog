//
//  ProductCatalogTests.swift
//  ProductCatalogTests
//
//  Created by Indra Permana on 04/07/23.
//

import XCTest
@testable import ProductCatalog

final class ProductCatalogTests: XCTestCase {
    var sut: HomeControllerMock!
    
    override func setUpWithError() throws {
        sut = HomeControllerMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchProducts() async throws {
        // Given: There is some data from mock waiting to be fetched
        let productMockData = HomeProductModelMock.getProducts()
        // When: HomeControllerMock is fetching the mock product
        await sut.fetchProducts()
        // Then: The mock data that are from HomeControllerMock should be the same amount as productMockData
        XCTAssertEqual(productMockData.count, sut.filteredProducts.count)
    }

    func testSearchProducts() async throws {
        // Given: After HomeControllerMock is fetching the mock product, we set searchText query to `a`
        await sut.fetchProducts()
        sut.searchText = "a"
        // When: HomeControllerMock is search the products for the query title
        sut.searchProducts()
        // Then: The filteredProducts count should be 1 (only 1 mock product that contains `a` in it's title)
        XCTAssertEqual(sut.filteredProducts.count, 1)
    }

}

final class HomeControllerMock: HomeController {
    var state: ScreenStates = .idle
    var filteredProducts: [HomeProductModel] = []
    var searchText: String = ""
    private var products: [HomeProductModel] = []
    
    func fetchProducts() async {
        await withCheckedContinuation { continuation in
            products = HomeProductModelMock.getProducts()
            filteredProducts = products
            
            continuation.resume()
        }
    }
    
    func searchProducts() {
        guard !searchText.isEmpty else {
            filteredProducts = products
            return
        }
        
        filteredProducts = products.filter { ($0.title).contains(searchText) }
    }
}

struct HomeProductModelMock {
    static func getProducts() -> [HomeProductModel] {
        [
            HomeProductModel(id: 0, title: "a", price: 12, description: "", category: "", image: "", rating: 4.8),
            HomeProductModel(id: 0, title: "b", price: 12, description: "", category: "", image: "", rating: 4.2),
            HomeProductModel(id: 0, title: "c", price: 12, description: "", category: "", image: "", rating: 3.2)
        ]
    }
}
