//
//  WebViewController.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import WebKit
import CocoaLumberjack

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let url: URL
    let titleText: String
    
    // MARK: - Initialization
    
    init(url: URL, title: String) {
        
        self.url = url
        self.titleText = title
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setUpWebView()
        setUpNavigationBar()
    }
    
    // MARK: - Setup
    
    func setUpNavigationBar() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = titleText
    }
    
    func setUpWebView() {
        
        if UIApplication.shared.canOpenURL(url) {
            
            webView.load(URLRequest(url: url))
        }
        else {
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                
                self.navigationController?.popViewController(animated: true)
            }
            
            let alert = Alert.invalidURL(actions: [okAction]).alertController
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UIWebViewDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        DDLogError("WebView navigation failed with error: \(error.localizedDescription)")
    }
}

