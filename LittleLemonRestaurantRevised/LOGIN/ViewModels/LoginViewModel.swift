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
    @Published var isConnecting: Bool = false
    @Published var isSaved: Bool = false
    @Published var isSignUp: Bool = false
    @Published var isForgotPassword: Bool = false
    @Published var isError: Bool = false

    @Published var error: LoginAPIService.LoginAPIError?
    @Published var user: User = LoginViewModel.noUser

//    User(firstName: "sample", lastName: "sample", emailAddress: "tdoe@example.com", password: "pass2Bbb", avatar: "sample",
//                                     subscriptions: [User.Subscription(name: .order, isSelected: true), User.Subscription(name: .password, isSelected: false), User.Subscription(name: .special, isSelected: true), User.Subscription(name: .news, isSelected: false)])

    func checkCredentialsAndLogIn() {
        guard areFieldsValid else { return }
        isConnecting = true
        LoginAPIService.shared.returnLoginStatus(email: user.emailAddress, password: user.password) { [weak self] (result: Result<Bool, LoginAPIService.LoginAPIError>) in
            switch result {
            case .success(let success):
                self?.isLoggedIn = success
                self?.isConnecting = false
                self?.getLoggedInUserInfo()
            case .failure(let error):
                self?.error = error
                self?.isConnecting = false
                self?.isError = true
            }
        }
    }
    
    func getLoggedInUserInfo() {
        guard isLoggedIn else { return }
        
        LoginAPIService.shared.returnLoggedInUserInfo { [weak self] (returnedUser) in
            self?.user = returnedUser
        }
    }
    
    func logOut() {
        guard isLoggedIn else { return }
        
        isLoggedIn = false
        user = LoginViewModel.noUser
    }
    
    func saveChanges() -> Data? {
        guard areFieldsValid else { return nil }
//        isSaved = true
        let savedUser = user
        do {
            let jsonUser = try JSONEncoder().encode(savedUser)
            isSaved = false
            return jsonUser
        } catch let error {
            print("Error saving user info. \(error)")
        }
        return nil
    }
    
    func discardChanges() {
        getLoggedInUserInfo()
        isSaved = false
    }
    
    var areFieldsValid: Bool {
        if isValid(email: user.emailAddress) && isValid(password: user.password) && !isSignUp{
            return true
        } else if isValid(name: user.lastName) && isValid(email: user.emailAddress) && isForgotPassword {
            return true
        } else if isValid(name: user.firstName) && isValid(name: user.lastName) && isValid(email: user.emailAddress) && isValid(password: user.password) && isSignUp || isLoggedIn {
            return true
        } else {
            return false
        }
    }
    
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    func isValid(password: String) -> Bool {
        guard !password.isEmpty else { return false }
        let passwordValidationRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        return passwordValidationPredicate.evaluate(with: password)
    }
    
    static let noUser = User(firstName: "", lastName: "", emailAddress: "", password: "", avatar: "",
                        subscriptions: [User.Subscription(name: .order, isSelected: true), User.Subscription(name: .password, isSelected: false), User.Subscription(name: .special, isSelected: true), User.Subscription(name: .news, isSelected: false)])
}
