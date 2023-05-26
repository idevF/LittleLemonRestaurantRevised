//
//  OnboardingView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        if loginVM.isLoggedIn {
            HomeView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(LoginViewModel())
    }
}
