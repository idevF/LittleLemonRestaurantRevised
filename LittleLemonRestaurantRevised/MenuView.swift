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
            HeroView(isLoggedIn: true, searchText: $menuViewModel.searchText)
                .padding(.horizontal)
                .overlay(alignment: .bottom, content: { progressView })
                .onChange(of: menuViewModel.searchText) { _ in
                    menuViewModel.searchMenuTitle()
                }
            MenuBreakdownView(menuViewModel: menuViewModel)
            
            Divider()
            
            List {
                ForEach(menuViewModel.menu) { item in
                    NavigationLink(value: item) {
                        MenuRowView(item: item)
                        
                    }
                }
            }
            .listStyle(.plain)
            .task {
                await menuViewModel.fetchJSONMenu()
            }
            .alert("Menu Error", isPresented: $menuViewModel.showErrorAlert) {
                Button("OK") { }
            } message: {
                if let errorMessage = menuViewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .navigationDestination(for: JSONMenu.MenuItem.self) { item in
                MenuRowDetailView(item: item)
            }
            .scrollIndicators(.hidden)
            .onDisappear {
                menuViewModel.isButtonPressed = false
                menuViewModel.searchText = ""
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

extension MenuView {
    private var progressView: some View {
        Group {
            if menuViewModel.isLoading {
                ProgressView("Loading....")
                    .progressViewStyle(.circular)
                    .tint(Color("secondaryOne"))
                    .foregroundColor(Color("secondaryOne"))
            }
        }
    }
}