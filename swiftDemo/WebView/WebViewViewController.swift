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
    private var progressView : UIProgressView? = nil
    private var observation: NSKeyValueObservation? = nil
    
//    lazy private var progressView: UIProgressView = {
//            let progress = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: UIScreen.main.bounds.width, height: 2))
//            progress.tintColor = UIColor.green
//            progress.trackTintColor = UIColor.white
//            return progress
//        }()
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration();
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self;
        view = webView;
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: kStatusBarHeight + CGFloat(kNavBarHeight), width: UIScreen.main.bounds.width, height: 30))
        progressView?.progress = 0.05  // 默认值
        progressView?.trackTintColor = UIColor.white  // background color
        progressView?.progressTintColor = kAssistOrangeColor
        self.view.addSubview(progressView!)

        observation = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
                self.progressView!.progress = Float(self.webView.estimatedProgress)
                }
        
        loadWebView(url: webUrl)
    }
    
   public func loadWebView(url:String?) -> Void {
        let myURL = URL(string:url!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    deinit {
        observation = nil
    }
    //添加观察者方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //重设标题
            if keyPath == "title" {
                self.title = self.webView.title
            }
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
