//
//  PreferencesViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 16/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = logoView
        
    }

}
