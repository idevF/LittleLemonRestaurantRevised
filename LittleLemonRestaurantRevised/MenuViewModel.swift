//
//  MenuViewModel.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

import Foundation

final class MenuViewModel: ObservableObject {
    @Published var menu: [JSONMenu.MenuItem] = [JSONMenu.MenuItem.example]
    
}

