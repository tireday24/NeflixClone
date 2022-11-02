//
//  SignupViewModel.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class SignupViewModel: CommonViewModel {
    
    var userName = BehaviorRelay<String>(value: "")
    var id = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var statusSuccess = BehaviorSubject<Bool>(value: false)
    
    struct Input {
        let userNameText: ControlProperty<String?>
        let idText: ControlProperty<String?>
        let pwText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let userNameText: Driver<String>
        let idText: Driver<String>
        let pwText: Driver<String>
        
    }
    
    func transform(input: Input) -> Output {
        var validation: Observable<Bool> {
            return Observable.combineLatest(id, password)
                .map { id, password in
                    return userName.count > 0 && id.count > 0 && id.contains("@") && id.contains(".") && password.count > 8
                }
        }
        
        let userNameText = userName.asDriver()
        let idText = id.asDriver()
        let pwText = password.asDriver()
        
        return Output(validation: validation,tap: input.tap, userNameText: userNameText, idText: idText, pwText: pwText)
    }
    
    func requestAPI() {
        let api = ServiceAPI.signup(userName: userName.value, email: id.value, password: password.value)
        
        AF.request(api.url, method: .post, headers: api.header).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            switch response.result {
                
            case .success(_):
                switch statusCode {
                case 200..<300:
                    self.statusSuccess.onNext(true)
                case 400..<500:
                    self.statusSuccess.onError(NetworkError.requestError)
                case 500..<600:
                    self.statusSuccess.onError(NetworkError.serverError)
                default:
                    self.statusSuccess.onError(NetworkError.notNetworking)
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    
}
