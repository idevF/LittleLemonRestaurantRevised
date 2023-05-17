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
                Button {
                    dismiss()
                } label: {
                    Label("Quit", systemImage: "xmark.app.fill")
                        .foregroundColor(Color("primaryOne"))
                        .font(.subheadline)
                }
            }
            .padding()
    }
    
    private var gridViewSection: some View {
        Grid {
            GridRow {
                Text("Title")
                Text("Quantity")
                Text("Price")
                Text("Total Price")
            }
            .font(.system(.headline, design: .rounded, weight: .semibold))
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            
            ForEach(menuViewModel.ordersList) { order in
                GridRow {
                    Text(order.title)
                        .gridColumnAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("\(order.quantity)")
                    
                    Text("\(Double(order.price) ?? 0, format: .currency(code: "USD"))")
                        .gridColumnAlignment(.leading)
                    
                    Text("\(order.total, format: .currency(code: "USD"))")
                        .gridColumnAlignment(.trailing)
                }
                .font(.system(.body, design: .rounded, weight: .regular))
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
            }
            
            GridRow {
                Text("Grand Total :")
                    .gridCellColumns(3)
                    .gridCellAnchor(.trailing)
                
                Text("\(menuViewModel.grandTotal, format: .currency(code: "USD"))")
                    .gridColumnAlignment(.trailing)
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
    }
}




