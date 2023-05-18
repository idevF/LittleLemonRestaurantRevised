//
//  CartView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 17.05.2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var menuViewModel: MenuViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var editMode: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack {
            headerSection
            
            gridViewSection
            
            checkOutButton
            
            Spacer()
        }
        .background(.ultraThinMaterial)
    }
    
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(menuViewModel: MenuViewModel())
    }
}

extension CartView {
    private var headerSection: some View {
        HeaderView(isLoggedIn: false)
            .overlay(alignment: .topLeading) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Label("Quit", systemImage: "xmark.app.fill")
                            .foregroundColor(Color("primaryOne"))
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        isOrderPlaced ? editMode.toggle() : (editMode = false)
                    } label: {
                        Label(editMode ? "Done" : "Edit", systemImage: "pencil")
                            .labelStyle(.titleOnly)
                            .foregroundColor(Color("primaryOne"))
                            .font(.subheadline)
                    }
                }
            }
            .padding()
    }
    
    private var gridViewSection: some View {
        Grid {
            GridRow {
                Text("Title")
                Text(editMode ? "Qty" : "Quantity")
                if editMode {
                    Text("Change")
                }
                Text("Price")
                Text("Total Price")
            }
            .font(.system(.headline, design: .rounded, weight: .semibold))
            .fixedSize(horizontal: false, vertical: true)
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            
            ForEach($menuViewModel.ordersList) { $order in
                GridRow {
                    Text(order.title)
                        .gridColumnAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("\(order.quantity)")
                    
                    if editMode {
                        Stepper("order \(order.quantity)", value: $order.quantity, in: 1...20)
                            .labelsHidden()
                            .scaleEffect(0.8)
                    }
                    
                    Text("\(Double(order.price) ?? 0, format: .currency(code: "USD"))")
                        .gridColumnAlignment(.leading)
                    
                    Text("\(order.total, format: .currency(code: "USD"))")
                        .gridColumnAlignment(.trailing)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    if editMode {
                        Label("Delete", systemImage: "trash")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                showDeleteAlert.toggle()
                            }
                            .padding()
                            .alert("DELETE", isPresented: $showDeleteAlert) {
                                Button("Cancel", role: .cancel) { }
                                Button("Delete") { menuViewModel.removeOrder(order: order) }
                            } message: {
                                Text("Would you like to delete your order?")
                            }
                    }
                }
                .font(.system(.body, design: .rounded, weight: .regular))
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
            }
            
            GridRow {
                Text("Grand Total :")
                    .gridCellColumns(editMode ? 4 : 3)
                    .gridCellAnchor(.trailing)
                
                Text("\(menuViewModel.grandTotal, format: .currency(code: "USD"))")
                    .gridColumnAlignment(.trailing)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .font(.system(.headline, design: .rounded, weight: .semibold))
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
        }
    }
    
    private var checkOutButton: some View {
        Button {
            // checkout
            dismiss()
        } label: {
            Text("Check Out")
                .frame(height: 10)
                .foregroundColor(Color("primaryTwo"))
                .brandButtonStyle(foreground: Color.clear, background: Color("primaryOne"))
        }
        .padding()
        .disabled(!isOrderPlaced)
        .opacity(isOrderPlaced ? 1 : 0.5)
    }
    
    private var isOrderPlaced: Bool {
        if menuViewModel.ordersList.count > 0 {
            return true
        } else {
            return false
        }
    }
}




