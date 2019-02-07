//
//  LoginViewController.swift
//  RickMoya
//
//  Created by any.pinheiro on 05/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btForgotPassword: UIButton!
    
    let disposeBag = DisposeBag()
    
    static func instantiate(with viewModel: LoginViewModelContract) -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    var viewModel: LoginViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindProperties()
    }
    
    private func bindProperties() {
        tfUserName.rx.controlEvent(.editingDidEndOnExit).bind {
            self.tfPassword.becomeFirstResponder()
            }.disposed(by: disposeBag)
        
        tfPassword.rx.controlEvent(.editingDidEndOnExit).bind {
            self.doLogin()
            }.disposed(by: disposeBag)
        
        let usernameValidation = tfUserName.rx.value.map { !($0 ?? "").isEmpty }.share()
        let passwordValidation = tfPassword.rx.value.map { !($0 ?? "").isEmpty }.share()
        let buttonValidation = Observable.combineLatest(usernameValidation, passwordValidation) {
            return $0 && $1
        }
        
        buttonValidation.bind(to: btLogin.rx.isEnabled).disposed(by: disposeBag)
        
        btLogin.rx.tap.bind {
            self.doLogin()
            }.disposed(by: disposeBag)
        
        btForgotPassword.rx.tap.bind {
            self.viewModel.forgotPassword()
            }.disposed(by: disposeBag)
    }
    
    private func doLogin() {
        if let username = self.tfUserName.text, let password = self.tfPassword.text {
            self.viewModel.login(login: username, password: password)
        }
    }
}

