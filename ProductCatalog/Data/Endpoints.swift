//
//  Endpoints.swift
//  ProductCatalog
//
//  Created by Indra Permana on 04/07/23.
//

import Foundation

protocol Endpoint {
    
    var urlString: String { get }
    var httpMethod: String { get }
    var headers: [String: String]? { get }
}

enum Endpoints: Endpoint {
    case products
    
    var urlString: String {
        switch self {
        case .products:
            return "\(APIConfig.baseURL)/products"
        }
    }
    var httpMethod: String {
        return ""
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
}

extension Endpoints {
    func makeURL(fromURLString urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        return url
    }
}


enum APIError: Swift.Error {
    case invalidURL
    case httpCode(Int)
    case unexpectedResponse
    case imageDeserialization
}
