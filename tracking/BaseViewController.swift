//
//  BaseViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

protocol KeyboardObserversProtocol {
    func observerKeyboardWillChangeStatus(show:Bool, notification:NSNotification)
}

class BaseViewController: UIViewController {

    //Keyboard
    var keyboardObserversDelegate:KeyboardObserversProtocol?{
        willSet{
            registerKeyboardObservers()
            dismissKeyboard()
        }
    }
    
    func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        keyboardObserversDelegate?.observerKeyboardWillChangeStatus(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        keyboardObserversDelegate?.observerKeyboardWillChangeStatus(show: false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification, scrollableView : UIScrollView, heightInset:CGFloat, completionHandler: (()-> Void)?) {
        
        if show{
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                var contentInset = scrollableView.contentInset as UIEdgeInsets
                contentInset.bottom = keyboardSize.height + heightInset
                scrollableView.contentInset = contentInset
                
            }
        }else{
            scrollableView.contentInset = UIEdgeInsets.zero
        }
        
        completionHandler?()
    }
    
}
