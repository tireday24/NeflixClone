//
//  Error.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation

enum NetworkError: Error {
    //300..<400 리다이렉션 완료
    case requestError //400..<500
    case serverError // 500..<600
    case notNetworking
}
