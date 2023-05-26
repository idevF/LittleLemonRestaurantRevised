//
//  MenuRowView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 12.05.2023.
//

import SwiftUI

struct MenuRowView: View {
    let item: MenuItemEntity
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.entityTitle)
                    .font(.system(.headline, design: .serif, weight: .bold))
                    .foregroundColor(Color.primary)
                
                Text(item.entityExplanation)
                
                Text("\(Double(item.entityPrice) ?? 0, format: .currency(code: "USD"))")
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
    static let context = PersistenceController.shared.container.viewContext
    
    static var previews: some View {
        MenuRowView(item: MenuItemEntity.example(context))
            .padding()
    }
}
