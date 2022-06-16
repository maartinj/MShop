//
//  Product.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

// Product Model
struct Product: Identifiable {
    var id = UUID()
    var type: ProductType
    var name: String
    var description: String
    var image: String
    var price: Double
    var size: String
    var isLiked: Bool = false
    var quantity: Int = 1
}

// Product Types
enum ProductType: String, CaseIterable {
    case Male = "Male clothing"
    case Female = "Female clothing"
}
