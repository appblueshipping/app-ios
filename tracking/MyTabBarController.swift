//
//  MyTabBarController.swift
//  tracking
//
//  Created by Jonatha Lima on 16/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        
        for item in tabBar.items! {
            item.originalImageColor()
        }
        
    }

}
