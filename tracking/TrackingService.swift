//
//  TrackingService.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import Foundation

class TrackingService: BaseService {

    let ACTION_FUNCTION_NAME = "rastreamento"
    
    class var identifier: String { return String.className(aClass: self) }
    
    override init () {
        super.init()
        self.ACTION_FUNCTION_NAME_TAG = ACTION_FUNCTION_NAME
    }
    
    func track(trackNumber: String, completion:@escaping (_ success:Bool,_ result:AnyObject?, _ tracking:[Tracking]?)->()) throws {
        
        if !SWUtils.checkNetworkConnection(){
            throw BaseServiceError.NetworkError
            
        } else {
         
            self.createGETDefaultSWConnection(url: BaseService.BASE_URL + ACTION_FUNCTION_NAME, variables: ["search":trackNumber]).sendAndLoadGETWithCompletion(completion: { (success, result) in
                if success {
                    
                    let requestResult = result as! SWResult
                    var trackResult = [Tracking]()
                    
                    if let resultDataObject = requestResult.dataObject as? [Dictionary<String, AnyObject>] {
                    
                        if resultDataObject.count > 0{
                            for i in 0..<resultDataObject.count{
                                do {
                                    try trackResult.append(Tracking(dict:resultDataObject[i]))
                                } catch let err {
                                    print(err.localizedDescription)
                                }
                            }
                        }
                        
                    }
                    
                    completion(true, result, trackResult)
                    
                } else {
                    if let error = result as? NSError {
                        print("Error TrackService - track(): \(error.code)")
                        completion(false, error, [Tracking]())
                    }
                }
            })
            
        }
        
    }

}
