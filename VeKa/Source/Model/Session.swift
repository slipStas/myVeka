//
//  Session.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 19.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class Session {
    
    static let shared = Session()
    private init () {}
    
    var token = String()
    var userId = String()
    
    var login = ""
    var password = ""
    
}
