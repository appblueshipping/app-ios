//
//  NewUserViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 15/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var tabBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.setBackgroundImage(UIImage(), for: .default)
        self.tabBar.shadowImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.registerGoogleAnalytics(classForCoder: self.classForCoder)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
