//
//  ForgotPasswordConfirmViewController.swift
//  RickMoya
//
//  Created by any.pinheiro on 06/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift

class ForgotPasswordConfirmViewController: UIViewController {

    @IBOutlet weak var btReturnLogin: UIButton!
    @IBOutlet weak var lbMessage: UILabel!
    let disposeBag = DisposeBag()
    
    static func instantiate(with viewModel: ForgotPasswordViewModelContract) -> ForgotPasswordConfirmViewController{
        let viewController = R.storyboard.forgotPassword.confirm()!
        
//        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
//        let viewController = storyboard.instantiateInitialViewController() as! ForgotPasswordViewController
      
        viewController.viewModel = viewModel

        return viewController
    }
    
    var viewModel : ForgotPasswordViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindProperties()
        lbMessage.text = "As instruções para recuperação de senha foram enviadas para o email \(viewModel.email)"
    }
    
    func bindProperties() {
        
        btReturnLogin.rx.tap.bind {
            self.viewModel.returnToLogin()
            }.disposed(by: disposeBag)
    }
}
