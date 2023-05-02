//
//  User.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import Foundation
import SwiftUI

struct User {
    let firstName: String
    let lastName: String
    var emailAddress: String
    var password: String
    let avatar: Image?
    let subscriptions: Subscription

    struct Subscription {
        let orderStatus: Bool
        let passwordChanges: Bool
        let specialOffers: Bool
        let newsletter: Bool
    }
    
    static let example = User(firstName: "Tilly", lastName: "Doe", emailAddress: "tdoe@example.com", password: "pass", avatar: Image("avatar"),
                              subscriptions: Subscription(orderStatus: true, passwordChanges: false, specialOffers: true, newsletter: true))
}
