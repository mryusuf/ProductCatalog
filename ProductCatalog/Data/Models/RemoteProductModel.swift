//
//  RemoteProductModel.swift
//  ProductCatalog
//
//  Created by Indra Permana on 04/07/23.
//

import Foundation

struct RemoteProductModel: Codable, Identifiable {
    let id: Int?
    let title: String?
    let price: Double?
    let description, category: String?
    let image: String?
    let rating: Rating?
}

struct Rating: Codable {
    let rate: Double?
    let count: Int?
}
