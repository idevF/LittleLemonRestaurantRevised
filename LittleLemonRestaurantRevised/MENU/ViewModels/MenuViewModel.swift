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
    
    @Published var searchText: String = ""
    
    @Published var ordersList: [Order] = [] // [Order(title: "Fish", price: "10", quantity: 2), Order(title: "Grilled Fish", price: "10", quantity: 2), Order(title: "Lemon Dessert", price: "10", quantity: 3)]
    
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
    
    func searchMenuTitle() {
        if searchText.isEmpty {
            Task(priority: .background) {
                await fetchJSONMenu()
            }
            isButtonPressed = false
        } else {
            self.menu = menu.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func addOrder(title: String, price: String, quantity: Int) {
        let order = Order(title: title, price: price, quantity: quantity)
        ordersList.append(order)
    }
    
    func removeOrder(order: Order) {
        if let index = ordersList.firstIndex(where: { $0.id == order.id } ) {
            ordersList.remove(at: index)
        }
    }
    
    var grandTotal: Double {
        if ordersList.count > 0 {
            return ordersList.reduce(0) { $0 + $1.total }
        } else {
            return 0
        }
    }
}

