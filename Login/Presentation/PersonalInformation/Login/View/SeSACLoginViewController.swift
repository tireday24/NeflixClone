//
//  SeSACLoginViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

class SeSACLoginViewController: BaseViewController {
    
    let mainView = SeSACLoginView()
    let viewModel = SeSACLoginViewModel()
    
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
        navigationItem.title = "Netflix"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .black
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        mainView.pwResetButton.addTarget(self, action: #selector(resetPasswordClicked), for: .touchUpInside)
    }
    
    @objc func backButtonClicked() {
        
    }
    
    @objc func resetPasswordClicked() {
        let vc = ResetPasswordViewController()
        transition(vc, trasionStyle: .presentFullScreen)
    }
    
    @objc func signupButtonClicked() {
        let vc = SignupViewController()
        transition(vc, trasionStyle: .presentFullScreen)
    }
    
    func bind() {
        
        let input = SeSACLoginViewModel.Input(idText: mainView.idTextField.rx.text, pwText: mainView.pwTextField.rx.text, tap: mainView.loginButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.idText
            .drive(onNext: { id in
                self.viewModel.id.accept(id)
            })
            .disposed(by: disposeBag)
        
        output.pwText
            .drive(onNext: { password in
                self.viewModel.password.accept(password)
            })
            .disposed(by: disposeBag)

        output.validation
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        output.validation
            .map { $0 == true ?  UIColor.systemGray : UIColor.clear}
            .asDriver(onErrorJustReturn: .clear)
            .drive(mainView.loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (sc, _) in
                
                if self.mainView.loginButton.backgroundColor == .clear {
                    
                }else {
                    let vc = MainViewController()
                    sc.transition(vc, trasionStyle: .presentFullScreen)
                }
                
            }
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
