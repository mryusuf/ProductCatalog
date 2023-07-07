//
//  APIConfig.swift
//  ProductCatalog
//
//  Created by Indra Permana on 04/07/23.
//

import Foundation

public struct APIConfig {
    enum Keys {
        static let baseURL = "BASE_URL"
    }
    
    static let baseURL: String = {
        guard let baseURLProperty = Bundle.main.object(forInfoDictionaryKey: Keys.baseURL) as? String else {
            return ""
        }
        return baseURLProperty
    }()
}
