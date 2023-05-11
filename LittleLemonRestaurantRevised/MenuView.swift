//
//  MenuView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject var menuViewModel = MenuViewModel()
    
    var body: some View {
        VStack {
            HeaderView(isLoggedIn: true)
            HeroView(isLoggedIn: true)
            
            NavigationStack {
                ForEach(menuViewModel.menu) { item in
                    VStack {
                        Text(item.title)
                        Text(item.description)
                    }
                }
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
