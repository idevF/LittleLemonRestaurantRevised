//
//  MenuBreakdownView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 16.05.2023.
//

import SwiftUI

struct MenuBreakdownView: View {
    @ObservedObject var menuViewModel: MenuViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("ORDER FOR DELIVERY!")
                .font(.system(.headline, design: .rounded, weight: .heavy))
                .foregroundColor(Color.primary)
            
            HStack {
                ForEach(MenuCategory.allCases, id: \.rawValue) { item in
                    Button {
                        // filter
                        menuViewModel.isButtonPressed.toggle()
                        menuViewModel.filtered(item: item.rawValue, viewContext)
                    } label: {
                        Text(item.rawValue.capitalized)
                            .font(.system(.subheadline, design: .rounded, weight: .bold))
                            .frame(height: 1)
                            .fixedSize(horizontal: true, vertical: false)
                            .foregroundColor(Color("primaryOne"))
                            .brandButtonStyle(foreground: Color.clear,
                                              background:
                                                (menuViewModel.isButtonPressed &&
                                                 menuViewModel.savedMenu.contains(where: { $0.entityMenuCategory.lowercased() == item.rawValue }))
                                              ? Color("primaryTwo") : Color("highlightOne"))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MenuBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakdownView(menuViewModel: MenuViewModel())
    }
}
