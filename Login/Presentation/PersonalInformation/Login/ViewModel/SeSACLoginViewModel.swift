//
//  SeSACLoginViewModel.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class SeSACLoginViewModel: CommonViewModel {
    
    var id = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
//    func validation() -> Observable<Bool> {
//        return Observable.combineLatest(id, password)
//            .map { id, password in
//                return id.count > 0 && id.contains("@") && id.contains(".") && password.count > 8
//            }
//    }
    
    var statusSuccess = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let idText: ControlProperty<String?>
        let pwText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let idText: Driver<String>
        let pwText: Driver<String>
        let statusSuccess: BehaviorRelay<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        var validation: Observable<Bool> {
            return Observable.combineLatest(id, password)
                .map { id, password in
                    return id.count > 0 && id.contains("@") && id.contains(".") && password.count > 8
                }
        }
        
        let idText = id.asDriver()
        let pwText = password.asDriver()
        
        return Output(validation: validation,tap: input.tap, idText: idText, pwText: pwText, statusSuccess: statusSuccess)
    }
    
    func requestAPI() {
        let api = ServiceAPI.login(email: id.value, password: password.value)
        
        AF.request(api.url, method: .post, headers: api.header).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            
            print(self.id.value, "aaa")
            
            guard let statusCode = response.response?.statusCode else { return }
            
            switch response.result {
                
            case .success(let data):
                switch statusCode {
                case 200..<300:
                    UserDefaults.standard.set(data.token, forKey: "token")
                    self.statusSuccess.accept(true)
                default:
                    self.statusSuccess.accept(false)
                }
            case .failure(_):
                print("\(statusCode)")
            }
            
        }
    }
    
    
}
