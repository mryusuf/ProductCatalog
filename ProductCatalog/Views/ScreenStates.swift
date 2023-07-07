//
//  ScreenStates.swift
//  ProductCatalog
//
//  Created by Indra Permana on 05/07/23.
//

import Foundation

enum ScreenStates {
    case idle
    case loading
    case failed(Error)
    case loaded
}
