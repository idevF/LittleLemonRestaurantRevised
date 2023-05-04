//
//  UtilityViews.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import Foundation
import SwiftUI

struct BrandFormFieldModifier: ViewModifier {
    let fieldColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(fieldColor)
            .padding(10)
            .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(fieldColor, lineWidth: 1))
    }
}

extension View {
    func brandFormFieldStyle(fieldColor: Color) -> some View {
        modifier(BrandFormFieldModifier(fieldColor: fieldColor))
    }
}

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("highlightOne"))
            .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

extension View {
    func cardViewStyle() -> some View {
        modifier(CardViewModifier())
    }
}

struct BrandButtonModifier: ViewModifier {
    let foreground: Color
    let background: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foreground)
            .padding()
            .frame(maxWidth: .infinity)
            .background(background, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.secondary, lineWidth: 2))
    }
}

extension View {
    func brandButtonStyle(foreground: Color, background: Color) -> some View {
        modifier(BrandButtonModifier(foreground: foreground, background: background))
    }
}
