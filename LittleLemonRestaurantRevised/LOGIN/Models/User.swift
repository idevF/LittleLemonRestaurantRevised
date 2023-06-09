//
//  User.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import Foundation
import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
    var emailAddress: String
    var password: String
    let avatar: String
    var subscriptions: [Subscription]

    struct Subscription: Identifiable, Codable {
        let name: SubscribeItems
        var isSelected: Bool
        
        var id: String {
            self.name.rawValue.lowercased()
        }
    }
    
    enum SubscribeItems: String, Codable {
        case order = "Order status"
        case password = "Password changes"
        case special  = "Special offers"
        case news = "Newsletter"
    }
    
    static let example = User(firstName: "Tilly", lastName: "Doe", emailAddress: "tdoe@example.com", password: "pass2Bbb", avatar: "avatar",
                              subscriptions: [Subscription(name: .order, isSelected: true), Subscription(name: .password, isSelected: false), Subscription(name: .special, isSelected: true), Subscription(name: .news, isSelected: false)])
}

