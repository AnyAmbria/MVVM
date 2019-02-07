//
//  LoginViewModel.swift
//  RickMoya
//
//  Created by any.pinheiro on 05/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow
import RxSwift

protocol LoginViewModelContract {
    func login(login: String, password: String)
    func forgotPassword()
}

class LoginViewModel: Stepper, LoginViewModelContract {
    let securityService: SecurityServiceContract
    
    init(with securityService: SecurityServiceContract) {
        self.securityService = securityService
    }
    
    func login(login: String, password: String) {
        self.securityService.login(username: login, password: password)
        guard self.securityService.isAuthenticated else {
            self.step.accept(LoginStep.error(message: "Usuário ou Senha inválidos"))
            return
        }
        
        self.step.accept(LoginStep.loginComplete)
    }
    
    func forgotPassword() {
        self.step.accept(LoginStep.forgotPassword)
    }
}
