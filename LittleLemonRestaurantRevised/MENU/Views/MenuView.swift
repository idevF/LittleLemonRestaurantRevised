//
//  MenuView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

import SwiftUI

struct MenuView: View {
    // MARK: PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var menuViewModel = MenuViewModel()
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            HeaderView(isLoggedIn: true)
            heroViewSection
            MenuBreakdownView(menuViewModel: menuViewModel)
            Divider()
            menuListSection
        }
    }
}

// MARK: PREVIEW
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

// MARK: COMPONENTS
extension MenuView {
    private var heroViewSection: some View {
        HeroView(isLoggedIn: true, searchText: $menuViewModel.searchText)
            .padding(.horizontal)
            .overlay(alignment: .bottom, content: { progressViewSection })
            .onChange(of: menuViewModel.searchText) { _ in
                menuViewModel.searchMenuTitle(viewContext)
            }
    }
    
    private var progressViewSection: some View {
        Group {
            if menuViewModel.isLoading {
                ProgressView("Loading....")
                    .progressViewStyle(.circular)
                    .tint(Color("secondaryOne"))
                    .foregroundColor(Color("secondaryOne"))
            }
        }
    }
    
    private var menuListSection: some View {
        List {
            ForEach(menuViewModel.savedMenu) { item in
                NavigationLink(value: item) {
                    MenuRowView(item: item)
                }
            }
        }
        .listStyle(.plain)
        .task {
            await menuViewModel.fetchJSONMenuAndPopulateCoreData(viewContext)
        }
        .alert("Menu Error", isPresented: $menuViewModel.showErrorAlert) {
            Button("OK") { }
        } message: {
            if let errorMessage = menuViewModel.errorMessage {
                Text(errorMessage)
            }
        }
        .navigationDestination(for: MenuItemEntity.self) { item in
            MenuRowDetailView(item: item, menuViewModel: menuViewModel)
        }
        .scrollIndicators(.hidden)
        .onDisappear {
            menuViewModel.isButtonPressed = false
            menuViewModel.searchText = ""
        }
    }
}
