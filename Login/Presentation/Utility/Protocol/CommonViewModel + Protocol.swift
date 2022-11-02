//
//  CommonViewModel + Protocol.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
