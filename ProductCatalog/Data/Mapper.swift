//
//  Mapper.swift
//  ProductCatalog
//
//  Created by Indra Permana on 07/07/23.
//

import Foundation

struct Mapper {
    static func map(from models: [RemoteProductModel]) -> [HomeProductModel] {
        return models.map { remoteModel in
            HomeProductModel(
                id: remoteModel.id ?? 0,
                title: remoteModel.title ?? "",
                price: remoteModel.price ?? 0,
                description: remoteModel.description ?? "",
                category: remoteModel.category ?? "",
                image: remoteModel.image ?? "",
                rating: remoteModel.rating?.rate ?? 0)
        }
    }

}
