//
//  ResetPasswordViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import WebKit

class ResetPasswordViewController: BaseViewController {
    
    private var webView: WKWebView!
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchLink(query: APIURL.resetPassword)
    }
    
    override func configure() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
        
    }
    
    func fetchLink(query: String) {
        guard let url = URL(string: query) else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
