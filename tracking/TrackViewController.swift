//
//  TrackViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet var logoView: UIView!
    @IBOutlet var customPopUp: UIView!
    @IBOutlet weak var backgroundColor: UIView!
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.dismissKeyboard()
        
        customPopUp.layer.cornerRadius = 5.0
        customPopUp.layer.masksToBounds = true
        
    }
    // TODO: REMOVE
    @IBAction func showPopUp(_ sender: UIButton) {
        
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
    @IBAction func closePopUp(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.customPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.customPopUp.alpha = 0
            self.backgroundColor.alpha = 0
        }) { (success) in
            self.customPopUp.removeFromSuperview()
        }
        
    }
}
