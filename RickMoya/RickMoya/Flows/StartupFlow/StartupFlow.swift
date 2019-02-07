//
//  StartupFlow.swift
//  RickMoya
//
//  Created by any.pinheiro on 04/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow

class StartupFlow: Flow {
    var root: Presentable{
        return self.rootViewController
    }
    
    private lazy var rootViewController: UIViewController = {
        //return UIViewController()
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private var securityService: SecurityServiceContract!
    
    init(with securityService: SecurityServiceContract) {
        self.securityService = securityService
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? StartupStep else {
            //return .none
            fatalError()
        }
        
        switch step {
        case .selectInitialFlow:
            return chooseInitialFlow()
        }
    }
    
    private func chooseInitialFlow() -> NextFlowItems{
//        let mainFlow = MainFlow()
//
//        Flows.whenReady(flow1: mainFlow){ [unowned self] root in
//            self.rootViewController.present(root, animated: false, completion: nil)
//        }
//
//        return .one(flowItem: NextFlowItem(nextPresentable: mainFlow, nextStepper: OneStepper(withSingleStep: MainStep.listCharacter)))
        
        if !securityService.isAuthenticated{
            return navigateToLoginFlow()
        }
        
        return navigateToMainFlow()
    }
    
    private func navigateToLoginFlow() -> NextFlowItems{
        let loginFlow = LoginFlow()
        Flows.whenReady(flow1: loginFlow) { [unowned self] root in
            self.rootViewController.present(root, animated: true, completion: nil)
        }
        
        return .one(flowItem: NextFlowItem(nextPresentable: loginFlow, nextStepper: OneStepper(withSingleStep: LoginStep.login)))
    }
    
    private func navigateToMainFlow() -> NextFlowItems{
        let mainFlow = MainFlow()
        
        Flows.whenReady(flow1: mainFlow){ [unowned self] root in
            self.rootViewController.present(root, animated: true, completion: nil)
        }
        
        return .one(flowItem: NextFlowItem(nextPresentable: mainFlow, nextStepper: OneStepper(withSingleStep: MainStep.listCharacter)))
    }
}
