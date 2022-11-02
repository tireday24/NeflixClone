//
//  MainViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/03.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class MainViewModel {
    
    var mainImage = BehaviorRelay<Main>(value: Main(user: User(photo: "", email: "", username: "")))
    
    var photo = PublishRelay<String>()
    var email = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    
    func requstAPI() {
        let api = ServiceAPI.profile
        
        AF.request(api.url, method: .get, headers: api.header)
            .responseDecodable(of: Main.self) { response in
                switch response.result {
                    
                case .success(let data):
                    self.photo.accept(data.user.photo)
                    self.email.accept(data.user.email)
                    self.username.accept(data.user.username)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
