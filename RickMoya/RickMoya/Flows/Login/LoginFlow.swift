//
//  LoginFlow.swift
//  RickMoya
//
//  Created by any.pinheiro on 06/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow
import NotificationBannerSwift

class LoginFlow: Flow {
   
    var root: Presentable{
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    var forgotPasswordViewModel : ForgotPasswordViewModel?
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? LoginStep else {
            return .none
        }
        
        switch step {
        case .login:
            return navigateToLoginScreen()
        case .loginComplete:
            self.rootViewController.dismiss(animated: false, completion: nil)
            return .end(withStepForParentFlow: StartupStep.selectInitialFlow)
        case .error(let message):
            let banner = NotificationBanner(title: message, subtitle: nil, leftView: nil, rightView: nil, style: .danger, colors: nil)
            banner.show()
        case .forgotPassword:
            return navigateToForgotPassword()
        case .sendForgotPassword:
            return navigateToForgotPasswordConfirm()
        case .forgotPasswordComplete:
            return navigateToLoginScreen()
        }
        return .none
    }
    private func navigateToLoginScreen() -> NextFlowItems{
        if rootViewController.viewControllers.count > 0{
            rootViewController.popViewController(animated: true)
            return .none
        }
        
        let viewModel = LoginViewModel(with: SecurityService.shared)
        let viewController = LoginViewController.instantiate(with: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    private func navigateToForgotPassword() -> NextFlowItems {
        self.forgotPasswordViewModel = ForgotPasswordViewModel()
        
        let viewController = ForgotPasswordViewController.instantiate(with: self.forgotPasswordViewModel!)
        viewController.title = "Esqueci minha senha"
        
        rootViewController.pushViewController(viewController, animated: true)
        rootViewController.setNavigationBarHidden(false, animated: false)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: self.forgotPasswordViewModel!))
    }
    
    private func navigateToForgotPasswordConfirm() -> NextFlowItems {
        let viewController = ForgotPasswordConfirmViewController.instantiate(with: self.forgotPasswordViewModel!)
        
        rootViewController.pushViewController(viewController, animated: true)
        rootViewController.setNavigationBarHidden(true, animated: false)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: self.forgotPasswordViewModel!))
    }
    
    private func navigateToMainScreen() -> NextFlowItems {
        rootViewController.dismiss(animated: true, completion: nil)
        return .end(withStepForParentFlow: StartupStep.selectInitialFlow)
    }
}
