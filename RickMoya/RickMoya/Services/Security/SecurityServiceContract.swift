//
//  SecurityServiceContract.swift
//  RickMoya
//
//  Created by any.pinheiro on 06/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import Foundation

protocol SecurityServiceContract {
    var isAuthenticated: Bool {get}
    func login(username: String, password: String)
}
