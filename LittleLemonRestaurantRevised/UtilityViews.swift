//
//  UtilityViews.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import Foundation
import SwiftUI

struct BrandFormFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color("secondaryTwo"))
            .padding(10)
            .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("secondaryTwo"), lineWidth: 1))
    }
}

extension View {
    func brandFormFieldStyle() -> some View {
        modifier(BrandFormFieldModifier())
    }
}

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("highlightOne"))
            .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func cardViewStyle() -> some View {
        modifier(CardViewModifier())
    }
}
