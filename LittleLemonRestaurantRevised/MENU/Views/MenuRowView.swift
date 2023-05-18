//
//  MenuRowView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 12.05.2023.
//

import SwiftUI

struct MenuRowView: View {
    let item: JSONMenu.MenuItem
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(.headline, design: .serif, weight: .bold))
                    .foregroundColor(Color.primary)
                Text(item.description)
                Text("\(Double(item.price) ?? 0, format: .currency(code: "USD"))")
            }
            .font(.system(.subheadline, design: .serif, weight: .semibold))
            .foregroundColor(Color.secondary)
            .lineLimit(2)
            
            Spacer()
            
            AsyncImageView(item: item)
                .frame(width: 75, height: 75)
        }
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(item: JSONMenu.MenuItem.example)
            .padding()
    }
}
