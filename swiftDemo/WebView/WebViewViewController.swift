//
//  WebViewViewController.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/7/30.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate {
    var webView:WKWebView!
    var webUrl:String!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration();
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self;
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView(url: webUrl)
    }
    
   public func loadWebView(url:String?) -> Void {
        let myURL = URL(string:url!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
