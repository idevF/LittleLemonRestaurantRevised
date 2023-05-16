//
//  MenuViewModel.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

import Foundation
@MainActor
final class MenuViewModel: ObservableObject {
    @Published var menu: [JSONMenu.MenuItem] = []
    @Published var isLoading: Bool = false
    
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String?
    
    @Published var isButtonPressed: Bool = false
    
    
    func fetchJSONMenu() async {
        let apiService = MenuAPIService()
        isLoading.toggle()
        
        do {
            defer {
                isLoading.toggle()
            }
            
            menu = try await apiService.getJSONMenu()
        } catch {
            showErrorAlert.toggle()
            errorMessage = error.localizedDescription + "\n Please inform the developer with the screen shot of the error message."
        }
    }
    
    func filtered(item: String) {
        
        if isButtonPressed {
            self.menu = menu.map({$0}).filter({ $0.menuCategory.lowercased() == item.lowercased() })
        } else {
            Task(priority: .background) {
                await fetchJSONMenu()
            }
        }
    }
    
    
}

