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
        NavigationStack {
            HeaderView(isLoggedIn: true)
            HeroView(isLoggedIn: true)
            
            if menuViewModel.isLoading {
                ProgressView("Loading....")
                    .progressViewStyle(.circular)
                    .tint(Color("secondaryOne"))
                    .foregroundColor(Color("secondaryOne"))
            }

            
            List {
                ForEach(menuViewModel.menu) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)

                            Text(item.description)
         
                            Text(item.price)
                    
                        }

                    }
                }
            }
            .listStyle(.plain)
            .task {
                await menuViewModel.fetchJSONMenu()
            }
            .alert("Menu Loading Error!", isPresented: $menuViewModel.showErrorAlert) {
                Button("OK") { }
            } message: {
                if let errorMessage = menuViewModel.errorMessage {
                    Text(errorMessage)
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
