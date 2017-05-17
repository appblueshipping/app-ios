//
//  BrowserViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: url))
    }

    @IBAction func closeBrowser(_ send: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension BrowserViewController: UIWebViewDelegate {

    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIAlertController.simpleAlert(title: "Something went wrong", message: "Try again later!")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
}
