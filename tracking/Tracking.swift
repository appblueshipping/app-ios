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
    var initialDate: String?
    
    var status: [TrackingStatus]?
    
    init() {}
    
    init(dict: Dictionary<String, AnyObject>?) throws {
        
        
        if dict != nil {
            
            self.status = [TrackingStatus]()
            let acf = dict!["acf"] as? [String:Any]

            self.blawb            = acf!["blawb"] as? String
            self.type             = acf!["type"] as? String
            self.company          = acf!["company"] as? String
            self.origin           = acf!["origin"] as? String
            self.finaldestination = acf!["finaldestination"] as? String
            self.exporter         = acf!["exporter"] as? String
            self.initialDate       = acf!["datainicio"] as? String
            
            let statusGeral = acf!["statusgeral"] as! [[String: AnyObject]]
            
            for status in statusGeral {
                
                let trackingStatus = TrackingStatus()
                trackingStatus.data = status["data"] as? String
                trackingStatus.document = status["documento"] as? String
                trackingStatus.status = status["status"] as? String
                
                self.status?.append(trackingStatus)
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
