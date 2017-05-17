//
//  Extensions.swift
//  tracking
//
//  Created by Jonatha Lima on 15/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    func dismissKeyboard() {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(selfDismiss))
        self.view.addGestureRecognizer(tapAction)
    }
    
    @objc private func selfDismiss() {
        self.view.endEditing(true)
    }
    
    func showLoadingInView() {
        self.removeLoadingInView()
        let uiView = self.view!
        var container: UIView = UIView()
        var loadingView: UIView = UIView()
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        
        container = UIView()
        container.frame = uiView.frame
        container.center = CGPoint(x:uiView.frame.size.width / 2,
                                   y:  uiView.frame.size.height  / 2 - 30 );
        container.backgroundColor = UIColor.clear
        
        loadingView = UIView()
        loadingView.frame = CGRect(x:0,y: 0,width: 80,height: 80)
        loadingView.center = CGPoint(x:uiView.frame.size.width / 2,
                                     y:   uiView.frame.size.height  / 2 - 30);
        
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0,y: 0.0,width: 40.0, height: 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint( x:loadingView.frame.size.width / 2,
                                 y:loadingView.frame.size.height / 2);
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        container.tag = 123456789
        uiView.addSubview(container)
        
        actInd.startAnimating()
        
    }
    
    func removeLoadingInView(){
        if let viewWithTag = self.view.viewWithTag(123456789) {
            viewWithTag.removeFromSuperview()
        }
    }
    
}

// MARK: - UITabBarItem
extension UITabBarItem {
    
    func originalImageColor() {
        
        let image = self.image
        
        self.image = image?.withRenderingMode(.alwaysOriginal)
        
    }
    
}

// MARK: - UIColor
extension UIColor {
    
    var tabBarColor: UIColor {
        get {
            return UIColorFromRGB(colorCode: "194d71", alpha: 1)
        }
    }
    
    private func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        
        let scanner = Scanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)  / 255.0)
        let g = CGFloat(Float(Int(color >> 8)  & mask)  / 255.0)
        let b = CGFloat(Float(Int(color )      & mask)  / 255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
}

// MARK: - UIAlertController
extension UIAlertController {
    
    static func simpleAlert(title :String, message :String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if let topVC = UIApplication.topViewController(){
            topVC.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - UIApplication
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

// MARK: - UIImage
extension UIImage {
    
    func tabBarImageWithCustomTint() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
}
