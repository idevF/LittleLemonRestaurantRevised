//
//  MenuItemEntity+Extension.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 23.05.2023.
//

import Foundation
import CoreData

extension MenuItemEntity {
    
    var entityTitle: String {
        title ?? ""
    }
    
    var entityExplanation: String {
        explanation ?? ""
    }
    
    var entityMenuCategory: String {
        menuCategory ?? ""
    }
    
    var entityPrice: String {
        price ?? ""
    }
    
    var entityImage: String {
        image ?? ""
    }
}
