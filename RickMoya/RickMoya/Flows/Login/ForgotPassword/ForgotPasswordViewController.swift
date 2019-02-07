//
//  ForgotPasswordViewController.swift
//  RickMoya
//
//  Created by any.pinheiro on 06/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btSend: UIButton!
    
    let disposeBag = DisposeBag()
    
    static func instantiate(with viewModel: ForgotPasswordViewModelContract) -> ForgotPasswordViewController{
        //let viewController = R.storyboard.forgotPassword.
        
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ForgotPasswordViewController
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    var viewModel : ForgotPasswordViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindProperties()
    }
    
    private func bindProperties(){
        tfEmail.rx.value.map{ $0?.count ?? 0 > 0}.bind(to: btSend.rx.isEnabled).disposed(by: disposeBag)
        tfEmail.rx.controlEvent(.editingDidEndOnExit).bind{
            self.sendForgotPassword()
        }.disposed(by: disposeBag)
        
        btSend.rx.tap.bind{
            self.sendForgotPassword()
        }.disposed(by: disposeBag)
    }
    
    private func sendForgotPassword(){
        if let email = self.tfEmail.text{
            self.viewModel.sendForgotPassword(for: email)
        }
    }
}
