//
//  OnboardingView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        Group {
            if loginVM.isLoggedIn {
                HomeView(loginVM: loginVM)
            } else {
                LoginView(loginVM: loginVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
