//
//  SWResult.swift
//  studio
//
//  Created by Adson Nascimento on 15/03/17.
//  Copyright © 2017 Anaiv Tecnologia. All rights reserved.
//


import Foundation

class SWResult : NSObject {
    
    var isTrue:Bool!
    var isEncrypted:Bool?
    var title:String?
    var message:String?
    var resultMessage:String?
    var resultCode:Int?
    var value:String?
    var dataObject:AnyObject?
    var lastRequestDate:String?
    
    override init() {
        super.init()
    }
    
    init(data: NSDictionary) {
        
        self.isTrue         = data["isTrue"]        as? Bool       ?? false
        self.isEncrypted    = data["isEncrypted"]   as? Bool       ?? false
        self.message        = data["message"]       as? String     ?? ""
        self.title          = data["title"]         as? String     ?? ""
        self.resultMessage  = data["resultMessage"] as? String     ?? ""
        self.lastRequestDate = data["lastRequestDate"] as? String  ?? ""
        self.resultCode     = data["resultCode"]    as? Int
        self.dataObject     = data["dataObject"]    as AnyObject?
    }
    
}
