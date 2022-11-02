//
//  MainViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        viewModel.requstAPI()
        
        viewModel.username
            .asDriver()
            .drive(mainView.userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.email
            .asDriver()
            .drive(mainView.userEmailLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.photo
            .asDriver(onErrorJustReturn: "")
            .drive { url in
                let url = URL(string: url)!
                
                DispatchQueue.global().async {
                    
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.mainView.mainImageView.image = image
                            }
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
}
