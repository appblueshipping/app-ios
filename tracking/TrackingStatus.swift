//
//  TrackingStatus.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import Foundation

class TrackingStatus {
    
    var data: String?
    var status: String?
    var document: String?
    
    init() {}
    
    init(data: String, status: String?, document: String?) {
        self.data = data
        self.status = status
        self.document = document
    }
    
}
