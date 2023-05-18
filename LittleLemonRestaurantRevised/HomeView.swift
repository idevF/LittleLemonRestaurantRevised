//
//  HomeView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 18.05.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var loginVM: LoginViewModel
    @State var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(0)
            
            UserProfileView(loginVM: loginVM)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
                .tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(loginVM: LoginViewModel())
    }
}
