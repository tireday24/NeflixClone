//
//  SystemAPI.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation
import Alamofire

class APIService {
    
    func signup() {
        let api = ServiceAPI.signup(userName: "testDaniel", email: "testDainel@testDainel.com", password: "12345678")
      
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { response in
            
            print(response)
            print(response.response?.statusCode)
            
        }
        
    }
    
    func login() {
        let api = ServiceAPI.login(email: "testDainel@testDainel.com", password: "12345678")
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            
            switch response.result {
                
            case .success(let data):
                print(data.token) //로그인 쪽에다가 디코딩을 했기 때문에
                UserDefaults.standard.set(data.token, forKey: "token")//토큰 값을 저장하는 이유 -> 프로필에서 토큰 값을 넣어주어야 하기 때문에
                
            case .failure(_):
                print(response.response?.statusCode)
            }
            
        }
        
        
    }
    
    
    func profile() {
        let api = ServiceAPI.profile
        
        AF.request(api.url, method: .get, headers: api.header).responseDecodable(of: Main.self) { response in
            
            switch response.result {
                
            case .success(let data):
                print(data)
                
            case .failure(_):
                print(response.response?.statusCode)
            }
            
        }
    }
    
}

struct APIURL {
    static let resetPassword = "https://www.netflix.com/kr/loginhelp?fromApp=true"
    
}
