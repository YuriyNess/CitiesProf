//
//  ViewController.swift
//  testCSSTextView
//
//  Created by YuriyFpc on 11/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, Storyboarded {
    
    var webView: WKWebView!
    var image: UIImage!
    var imageTitle: String = ""
    var url: String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        if let writePath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("\(imageTitle).jpg") {
            do {
                try image.jpegData(compressionQuality: 1.0)?.write(to: writePath)
                //let imUrl = Bundle.main.url(forResource: "\(imageTitle)", withExtension: "jpg")!
                webView.loadHTML(fromString: imageTitle, imageUrl:writePath.absoluteString, redirectUrl: url) //imUrl.absoluteString)
            } catch {
                print(error)
            }
            
        }
    }
    
    @objc
    private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, let host = url.host, !host.hasPrefix("file") {
            UIApplication.shared.open(url)
            print(url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }

}


extension WKWebView {
    
    func loadHTML(fromString: String, colorHEX: String = "ff0000", imageUrl: String, redirectUrl: String) {
        let htmlString =
        """
        <link rel="stylesheet" type="text/css" href="myCSSFile.css">
        <div class="container">
            <div class="centered"><img src='\(imageUrl)' alt="Snow"></div>
            <div class="top-centered">
               <div><span style="font-family: 'Gotham-Medium'; color: \(colorHEX)">\(fromString)
                </span></div>
                <div><span style="font-family: 'Gotham-Book'; color: \(colorHEX)"><a href="\(redirectUrl)">\(redirectUrl)</a></span></div>
            </div>
        </div>
        """
        
        self.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
}
