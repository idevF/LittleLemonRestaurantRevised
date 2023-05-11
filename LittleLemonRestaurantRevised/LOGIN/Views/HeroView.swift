//
//  HeroView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct HeroView: View {
    let isLoggedIn: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Little Lemon")
                .font(.system(.title, design: .serif, weight: .bold))
                .foregroundColor(Color("primaryTwo"))
            Text("Chicago")
                .font(.system(.title3, design: .serif, weight: .bold))
                .foregroundColor(Color("highlightOne"))
            HStack(alignment: .center) {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(Color("highlightOne"))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Image("heroImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            
            if isLoggedIn {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
        }
        .cardViewStyle()
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeroView(isLoggedIn: false)
            HeroView(isLoggedIn: true)
        }
    }
}
