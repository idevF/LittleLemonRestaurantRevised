//
//  HeaderView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 4.05.2023.
//

import SwiftUI

struct HeaderView: View {
    let isLoggedIn: Bool
    
    var body: some View {
        Group {
            Image("brandLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 45)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(alignment: .trailing) {
                    if isLoggedIn {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .padding()
                            .onTapGesture {
                                print("Hello")
                        }
                    }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderView(isLoggedIn: false)
            HeaderView(isLoggedIn: true)
        }
    }
}
