//
//  HomeController.swift
//  ProductCatalog
//
//  Created by Indra Permana on 05/07/23.
//

import Foundation

protocol HomeController: ObservableObject {
    var state: ScreenStates { get }
    var searchText: String { get set }
    var filteredProducts: [HomeProductModel] { get set }
    func fetchProducts() async
    func searchProducts()
}
    
final class HomeControllerDefault: HomeController {
    @Published var state: ScreenStates = .idle
    
    @Published var filteredProducts: [HomeProductModel] = []
    private var products: [HomeProductModel] = []
    @Published var searchText = ""
    
    func searchProducts() {
        guard !searchText.isEmpty else {
            filteredProducts = products
            return
        }
        
        filteredProducts = products.filter { ($0.title).contains(searchText) }
    }
    
    @MainActor func fetchProducts() async {
        state = .loading
        
        guard let url = URL(string: Endpoints.products.urlString) else {
            state = .failed(APIError.invalidURL)
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 201
            
            guard statusCode == 200 else {
                state = .failed(APIError.httpCode(statusCode))
                return
            }
            
            let remoteProducts = try JSONDecoder().decode([RemoteProductModel].self, from: data)
            
            self.products = Mapper.map(from: remoteProducts)
            self.filteredProducts = products
            state = .loaded
            
        } catch (let e) {
            state = .failed(e)
        }

    }
    
}
