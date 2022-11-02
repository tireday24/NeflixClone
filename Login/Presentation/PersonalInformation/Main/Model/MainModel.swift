//
//  MainModel.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation

struct Main: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}
