//
//  HeroView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct HeroView: View {
    let isLoggedIn: Bool
    
    @State private var showTextField: Bool = false
    @Binding var searchText: String
    
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
                HStack(alignment: .center) {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showTextField.toggle()
                                searchText = ""
                            }
                        }
                        
                    if showTextField {
                        TextField("Search for", text: $searchText)
                            .frame(height: 10)
                            .textContentType(.name)
                            .submitLabel(.search)
                            .brandFormFieldStyle(fieldColor: Color("secondaryTwo"))
                            .overlay(alignment: .trailingLastTextBaseline) {
                                if !searchText.isEmpty {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 15)
                                        .padding(.trailing, 10)
                                        .onTapGesture {
                                            searchText = ""
                                        }
                                }
                            }
                        
                        Text("Cancel")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showTextField.toggle()
                                    searchText = ""
                                }
                            }
                    }
                }
                .padding(.top, showTextField ? 10 : 0)
            }
        }
        .cardViewStyle()
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeroView(isLoggedIn: false, searchText: .constant(""))
            HeroView(isLoggedIn: true, searchText: .constant(""))
        }
    }
}
