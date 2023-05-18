//
//  MenuAPIService.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 11.05.2023.
//

import Foundation

struct MenuAPIService {
    let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    func getJSONMenu() async throws -> [JSONMenu.MenuItem] {
        guard let url = URL(string: menuAddress) else { throw APIError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            
            do {
                let decodedMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
                return decodedMenu.menu
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
            
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    enum APIError: Error, LocalizedError {
        case invalidURL
        case invalidResponseStatus
        case dataTaskError(String)
        case decodingError(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return NSLocalizedString("The menu address URL is invalid!", comment: "")
            case .invalidResponseStatus:
                return NSLocalizedString("The menu APIO failed to issue a valid response!", comment: "")
            case .dataTaskError(let string):
                return string
            case .decodingError(let string):
                return string
            }
        }
    }
}
