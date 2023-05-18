//
//  MenuRowDetailView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 12.05.2023.
//

import SwiftUI

struct MenuRowDetailView: View {
    let item: JSONMenu.MenuItem
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var menuViewModel: MenuViewModel
    
    @State private var quantity: Int = 1
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(isLoggedIn: true)
            
            AsyncImageView(item: item)
                .padding(.vertical)
            
            
            VStack(alignment: .leading) {
                Text(item.description)
                    .padding(.vertical, 5)
                HStack {
                    Label("Delivery time: 30 minutes", systemImage: "box.truck.badge.clock")
                    Spacer()
                    Label("Show Order Summary", systemImage: "cart")
                        .foregroundColor(Color("secondaryOne"))
                        .onTapGesture {
                            showSheet.toggle()
                        }
                }
                .padding(.horizontal)
            }
            .font(.system(.subheadline, design: .serif, weight: .semibold))
            .foregroundColor(Color.secondary)
            
            
            VStack {
                Stepper("order \(quantity)", value: $quantity, in: 1...20)
                    .labelsHidden()
                
                Text("\(quantity)")
                    .font(.system(.headline, design: .monospaced, weight: .bold))
                    .padding(10)
                
                Button {
                    menuViewModel.addOrder(title: item.title, price: item.price, quantity: quantity)
                    showAlert.toggle()
                } label: {
                    Text("Add to cart for \(itemTotal, format: .currency(code: "USD"))")
                        .frame(height: 10)
                        .foregroundColor(Color("primaryOne"))
                        .brandButtonStyle(foreground: Color.clear, background: Color("primaryTwo"))
                }
                .alert("ORDER INFO", isPresented: $showAlert) {
                    Button("Back to Menu") { dismiss() }
                    Button("Show Order Summary") { showSheet.toggle() }
                } message: {
                    Text("Your order has been added to the cart!")
                }
                .sheet(isPresented: $showSheet) {
                    CartView(menuViewModel: menuViewModel)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding(.vertical)
            .shadow(color: Color.secondary, radius: 10)
        }
        .navigationTitle(item.title)
        .padding()
    }
    
    private var itemTotal: Double {
        return (Double(item.price) ?? 0) * Double(quantity)
    }
    
}

struct MenuRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowDetailView(item: JSONMenu.MenuItem.example, menuViewModel: MenuViewModel())
    }
}
