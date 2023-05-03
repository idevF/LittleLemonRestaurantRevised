//
//  LoginViewModel.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var error: LoginAPIService.LoginAPIError?
    @Published var user: User = User(firstName: "sample", lastName: "sample", emailAddress: "tdoe@example.com", password: "pass", avatar: Image("sample"),
                                     subscriptions: User.Subscription(orderStatus: false, passwordChanges: false, specialOffers: false, newsletter: false))

    func checkCredentialsAndLogIn() {
        LoginAPIService.shared.returnLoginStatus(email: user.emailAddress, password: user.password) { [weak self] (result: Result<Bool, LoginAPIService.LoginAPIError>) in
            switch result {
            case .success(let success):
                self?.isLoggedIn = success
                self?.getLoggedInUserInfo()
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    private func getLoggedInUserInfo() { 
        guard isLoggedIn else { return }
        
        LoginAPIService.shared.returnLoggedInUserInfo { [weak self] (loggedInuser) in
            self?.user = loggedInuser
        }
    }
    
    func logOut() {
        guard isLoggedIn else { return }
        
        isLoggedIn = false
        user = User(firstName: "sample", lastName: "sample", emailAddress: "sample", password: "sample", avatar: Image("sample"),
                         subscriptions: User.Subscription(orderStatus: false, passwordChanges: false, specialOffers: false, newsletter: false))
    }

}
