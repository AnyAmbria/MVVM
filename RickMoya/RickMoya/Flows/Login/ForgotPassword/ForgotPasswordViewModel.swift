//
//  ForgotPasswordModel.swift
//  RickMoya
//
//  Created by any.pinheiro on 06/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow

protocol ForgotPasswordViewModelContract {
    var email: String { get set}
    func sendForgotPassword(for email: String)
    func returnToLogin()
}

class ForgotPasswordViewModel: ForgotPasswordViewModelContract, Stepper {
    var email: String = ""
    
    func sendForgotPassword(for email: String) {
        self.email = email
        self.step.accept(LoginStep.sendForgotPassword)
    }
    
    func returnToLogin() {
        self.step.accept(LoginStep.forgotPasswordComplete)
    }
    
}
