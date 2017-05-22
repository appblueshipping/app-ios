//
//  TrackViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class TrackViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var logoView: UIView!
    @IBOutlet var customPopUp: UIView!
    @IBOutlet weak var backgroundColor: UIView!
    @IBOutlet weak var txtTrackNumber: UITextField!
    
    var track: [Tracking]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSubViews() {
        self.navigationItem.titleView = logoView
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.keyboardObserversDelegate = self
        self.dismissKeyboard()
        
        customPopUp.layer.cornerRadius = 5.0
        customPopUp.layer.masksToBounds = true
        
        if AppPreferences.shared.trackNumber != nil {
            txtTrackNumber.text = AppPreferences.shared.trackNumber
        }
        
    }
    
    @IBAction func searchPackageAction(_ sender: Any) {
    
        trackingAction()
        
    }
    
    // TODO: REMOVE
    func showPopUp() {
        
        self.view.addSubview(customPopUp)
        self.customPopUp.center = view.center
        self.customPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.customPopUp.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor.alpha = 0.5
            self.customPopUp.alpha = 1
            self.customPopUp.transform = CGAffineTransform.identity
        }
        
    }
    @IBAction func closePopUp(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.customPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.customPopUp.alpha = 0
            self.backgroundColor.alpha = 0
        }) { (success) in
            self.customPopUp.removeFromSuperview()
        }
        
    }
    
    func trackingAction() {
        
        if !txtTrackNumber.text!.isEmpty {
            
            AppPreferences.shared.trackNumber = txtTrackNumber.text
            trackPackage(trackNumber: txtTrackNumber.text!)
            
        } else {
            UIAlertController.simpleAlert(title: "The field track number is empty", message: "")
        }
    }
    
    func goToResultViewController() {
        let resultViewController = storyboard?.instantiateViewController(withIdentifier: "trackResultViewController") as! TrackResultViewController
        
        if track != nil {
            resultViewController.trackResult = track
            navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension TrackViewController: KeyboardObserversProtocol, UITextFieldDelegate {
    
    func observerKeyboardWillChangeStatus(show: Bool, notification: NSNotification) {
        self.adjustingHeight(show: show, notification: notification, scrollableView: scrollView, heightInset: 30, completionHandler: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        trackingAction()
        
        return true
    }
    
}

// Service Calls
extension TrackViewController {
    
    func trackPackage(trackNumber: String) {
        
        self.showLoadingInView()
        Tracking().tracking(trackNumber: trackNumber) { (success, result, trackingResult) in
            self.removeLoadingInView()
            
            DispatchQueue.main.async {
                if success {
                    
                    if trackingResult?.count == 0 {
                        self.showPopUp()
                        return
                    }
                    
                    self.track = trackingResult
                    self.goToResultViewController()
                }
            }
            
        }
        
    }
    
}
