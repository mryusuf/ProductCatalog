//
//  HomeProductModel.swift
//  ProductCatalog
//
//  Created by Indra Permana on 07/07/23.
//

import Foundation

struct HomeProductModel: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Double
    var isFavorite: Bool = false
}
