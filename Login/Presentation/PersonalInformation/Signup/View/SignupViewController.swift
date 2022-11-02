//
//  SignupViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import RxCocoa
import RxSwift

class SignupViewController: BaseViewController {
    
    let mainView = SignupView()
    let viewModel = SignupViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configure() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .black
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    func bind() {
        let input = SignupViewModel.Input(userNameText: mainView.userNameTextField.rx.text, idText: mainView.idTextField.rx.text, pwText: mainView.pwTextField.rx.text, tap: mainView.signupButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.userNameText
            .drive(mainView.userNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.userNameText
            .drive(onNext: { userName in
                self.viewModel.userName.accept(userName)
            })
            .disposed(by: disposeBag)
        
        output.idText
            .drive(mainView.userNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.idText
            .drive(onNext: { id in
                self.viewModel.id.accept(id)
            })
            .disposed(by: disposeBag)
        
        output.pwText
            .drive(mainView.userNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.pwText
            .drive(onNext: { password in
                self.viewModel.password.accept(password)
            })
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requestAPI()
            }
            .disposed(by: disposeBag)
        
        output.validation
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.signupButton.rx.isEnabled)
            .disposed(by: disposeBag)

        output.validation
            .map { $0 == true ?  UIColor.systemRed : UIColor.clear}
            .asDriver(onErrorJustReturn: .clear)
            .drive(mainView.signupButton.rx.backgroundColor)
            .disposed(by: disposeBag)
    
        viewModel.statusSuccess
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { (vc, value) in
                if value {
                    let viewController = MainViewController()
                    vc.transition(viewController, trasionStyle: .presentFullScreen)
                }
            } onError: { error in
                print("\(error)")
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
    }
}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == mainView.pwTextField {
            keyboardSetNotificationCenter()
        }
        
        return true
    }
    
}
