//
//  AppPreferences.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import Foundation

class AppPreferences: NSObject {
    
    var userDefaults = UserDefaults.standard
    static let shared = AppPreferences()

    private let userTrackNumber = "trackNumber"
    
    var trackNumber: String? {
        get {
            return userDefaults.object(forKey: userTrackNumber) as? String
        }
        set {
            userDefaults.set(newValue, forKey: userTrackNumber)
            userDefaults.synchronize()
        }
    }
    
    func clearUserData() {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
    
}
