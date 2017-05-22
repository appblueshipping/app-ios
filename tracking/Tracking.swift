//
//  Tracking.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import Foundation
import UIKit

enum TrackingError: Error {
    case Empty
}

class Tracking {
    
    var blawb: String?
    var type: String?
    var company: String?
    var origin: String?
    var finaldestination: String?
    var exporter: String?
    var datainicio: String?
    
    var status: [TrackingStatus]?
    
    init() {}
    
    init(dict: Dictionary<String, AnyObject>?) throws {
        
        
        if dict != nil {
            self.blawb            = dict!["blawb"] as? String
            self.type             = dict!["type"] as? String
            self.company          = dict!["company"] as? String
            self.origin           = dict!["origin"] as? String
            self.finaldestination = dict!["finaldestination"] as? String
            self.exporter         = dict!["exporter"] as? String
            self.datainicio       = dict!["datainicio"] as? String
            
            let statusGeral = dict!["statusgeral"] as! [TrackingStatus]
            
            for status in statusGeral {
                self.status?.append(status)
            }
            
        } else {
            throw TrackingError.Empty
        }
        
    }
    
    // Services Call
    func tracking(trackNumber: String, completion:@escaping (_ success:Bool,_ result:AnyObject?,_ trackResult:[Tracking]?)->()) {
        
        do {
            try TrackingService().track(trackNumber: trackNumber) { (success, result, trackResult) in
            
                if success {
                    completion(true, result, trackResult)
                } else {
                    print(result!)
                    completion(false, result, [Tracking]())
                }
            }
            
        } catch BaseServiceError.NetworkError {
            UIAlertController.simpleAlert(title: SWUtils.networErrorTitle, message: SWUtils.networErrorMessage)
        } catch {
            NSLog("Unknow error in: %@", TrackingService.identifier + "requestDealsService")
        }
        
    }
    
}
