//
//  SecurityService.swift
//  RickMoya
//
//  Created by any.pinheiro on 05/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import Foundation

class SecurityService: SecurityServiceContract {
    static let shared = SecurityService()
    
    private var _isAuthenticated: Bool = false
    
    var isAuthenticated: Bool {
        return _isAuthenticated
    }
    
    func login(username: String, password: String) {
        if username == "123" && password == "123"{
            self._isAuthenticated = true
            return
        }
        
        self._isAuthenticated = false
    }
    
}
