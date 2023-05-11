//
//  MenuModel.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

/*
 menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
 {
   "menu": [
     {
       "id": 1,
       "title": "Greek Salad",
       "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
       "price": "10",
       "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
       "category": "starters"
     },
     {
       "id": 2,
       "title": "Lemon Desert",
       "description": "Traditional homemade Italian Lemon Ricotta Cake.",
       "price": "10",
       "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true",
       "category": "desserts"
     },
 */

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
    
    struct MenuItem: Codable, Identifiable {
        let id: Int
        let title: String
        let description: String
        let price: String
        let image: String
        let menuCategory: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case description
            case price
            case image
            case menuCategory = "category"
        }
        
        #if DEBUG
        static let example = MenuItem(id: 2, title: "Lemon Desert", description: "Traditional homemade Italian Lemon Ricotta Cake.", price: "10", image: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", menuCategory: "desserts")
        #endif
    }
}
