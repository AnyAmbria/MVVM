//
//  LoginStep.swift
//  RickMoya
//
//  Created by any.pinheiro on 05/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow

enum LoginStep: Step{
    case login
    case loginComplete
    case error(message: String)
    case forgotPassword
    case sendForgotPassword
    case forgotPasswordComplete
}
