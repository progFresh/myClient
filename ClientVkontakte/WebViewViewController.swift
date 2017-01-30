//
//  WebViewViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 29.01.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        let authUrl = URL(string: "https://oauth.vk.com/authorize?client_id=5832945&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,offline&response_type=token&v=5.62")
        
        webView.loadRequest(URLRequest(url: authUrl!))
    }
    
    // WebViewDelegate :
    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.stopAnimating()
        let currentUrl = webView.request?.url?.absoluteString
        if currentUrl?.range(of: "access_token=") != nil {
            let arrayOfUrlcomponents = currentUrl?.components(separatedBy: "&")
            
            var token = arrayOfUrlcomponents![0]
            var userId = arrayOfUrlcomponents![2]
            print(userId)
            
            let deleteRangeToken = token.range(of: "https://oauth.vk.com/blank.html#access_token=")
            let deleteRangeUserId = userId.range(of: "user_id=")
            
            token.removeSubrange(deleteRangeToken!)
            userId.removeSubrange(deleteRangeUserId!)
            
        } else {
            print("ne vse norm")
        }
    }
    
    // Bar Button Items
    @IBAction func refreshButtonTapped(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        let theTransition = storyboard?.instantiateViewController(withIdentifier: "SplashViewControllerID")
        present(theTransition!, animated: true, completion: nil)
    }
    
}
