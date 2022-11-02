//
//  SeSACLoginView.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import SnapKit

class SeSACLoginView: BaseView {
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.textColor = .white
        textField.backgroundColor = .systemGray
        return textField
    }()
    
    let pwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.textColor = .white
        textField.backgroundColor = .systemGray
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let pwResetButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [idTextField, pwTextField, loginButton, signupButton, pwResetButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        idTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 16)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(idTextField.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 16)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(pwTextField.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 22)
        }
        
        signupButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 22)
        }
        
        pwResetButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(signupButton.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 22)
        }
    }
    
}
