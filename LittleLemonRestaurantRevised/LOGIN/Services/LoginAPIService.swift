//
//  LoginAPIService.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import Foundation

// This class simulates a server login service for the app. Firebase etc. could be used as an alternative remote.
final class LoginAPIService {
    
    static let shared = LoginAPIService() // Singleton
    private init() { }
    
    private var user: User?
    
    func returnLoginStatus(email: String, password: String, completionHandler: @escaping (Result<Bool, LoginAPIError>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if email == "tdoe@example.com" && password == "pass2Bbb" {
                self.user = User.example
                completionHandler(.success(true))
            } else {
                self.user = nil
                completionHandler(.failure(.invalidCredentials))
            }
        }
    }
    
    func returnLoggedInUserInfo(completionHandler: @escaping (User) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let user = self.user {
                completionHandler(user)
            }
        }
    }

    enum LoginAPIError: Error, LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Access denied!\n Email Address or Password is not valid!", comment: "")
            }
        }
    }
}
