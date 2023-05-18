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
    var quantity: Int
    
    var total: Double {
        return (Double(price) ?? 0) * Double(quantity)
    }
}
