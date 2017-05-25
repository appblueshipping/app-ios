//
//  ContactViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController {

    @IBOutlet var logoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.registerGoogleAnalytics(classForCoder: self.classForCoder)
    }
    
    func initSubViews() {
        self.navigationItem.titleView = logoView
        self.navigationItem.titleView = logoView
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings_white"), style: .plain, target: self, action: #selector(goToSettings))
        self.dismissKeyboard()
    }

    @IBAction func sendEmailAction(_ sender: Any) {
        
        self.sendEmail()
        
    }
    
}

// Custom methods
private extension ContactViewController {
    
    @objc func goToSettings() {
        let preferencesVC = storyboard?.instantiateViewController(withIdentifier: "preferencesViewController") as! PreferencesViewController
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(preferencesVC, animated: true)
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate
extension ContactViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["app@blueshipping.com.br"])
            
            self.present(mail, animated: true, completion: nil)
        } else {
            UIAlertController.simpleAlert(title: "Something went wrong", message: "Try again later!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .sent {
            self.dismiss(animated: true, completion: {
                UIAlertController.simpleAlert(title: "Email successfully sent", message: "")
            })
                
        } else if result == .failed {
            
            self.dismiss(animated: true, completion: { 
                UIAlertController.simpleAlert(title: "Something went wrong", message: "Try again later!")
            })

        } else {
            
            self.dismiss(animated: true, completion: nil)
            
        }

    }
    
}
