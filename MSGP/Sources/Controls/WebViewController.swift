//
//  WebViewController.swift
//  MSGP
//
//  Created by Vadim Bulavin on 7/14/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import OAuthSwift
import UIKit

class WebViewController: OAuthWebViewController {

    var targetURL: URL?
    
    var urlScheme: String?
    
    fileprivate lazy var webView: UIWebView = { [unowned self] in
        let webView = UIWebView()
        webView.frame = UIScreen.main.bounds
        webView.scalesPageToFit = true
        webView.delegate = self
        self.view.addSubview(webView)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressURL()
    }

    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        loadAddressURL()
    }

    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let req = URLRequest(url: url)
        self.webView.loadRequest(req)
    }
}

extension WebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            print(url.scheme)
            self.dismissWebViewController()
        }
        return true
    }
}