//
//  Endpoint.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation
import Alamofire

enum ServiceAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension ServiceAPI {
    
    static let baseURL = "http://api.memolease.com/api/v1/users/"
    
    var url: URL {
        switch self {
        case .signup:
            return URL(string: ServiceAPI.baseURL + "signup")!
        case .login:
            return URL(string: ServiceAPI.baseURL + "login")!
        case .profile:
            return URL(string: ServiceAPI.baseURL + "me")!
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let username, let email, let password):
            return  [
                "userName": username,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["" : ""]
        }
        
    }
}
