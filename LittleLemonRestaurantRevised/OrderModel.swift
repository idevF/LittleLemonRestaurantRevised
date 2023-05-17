//
//  OrderModel.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 17.05.2023.
//

import Foundation

struct Order: Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let quantity: Int
    let total: Double
}
