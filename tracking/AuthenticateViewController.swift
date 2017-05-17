//
//  AuthenticateViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class AuthenticateViewController: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSubViews() {
        self.dismissKeyboard()
        
        let textAttributes : [String: Any] = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14),
            NSForegroundColorAttributeName : UIColor.white,
            NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
        
        btnRegister.setAttributedTitle(NSMutableAttributedString(string: btnRegister.titleLabel!.text!, attributes: textAttributes), for: .normal)
        
    }

    @IBAction func newUserAction(_ sender: Any) {
        
        let newUserVC = self.storyboard?.instantiateViewController(withIdentifier: "newUserViewController") as! NewUserViewController
        self.present(newUserVC, animated: true, completion: nil)
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let myTabBarController = storyboard?.instantiateViewController(withIdentifier: "myTabBarController") as! MyTabBarController
        
        self.present(myTabBarController, animated: true, completion: nil)
        
    }
}
