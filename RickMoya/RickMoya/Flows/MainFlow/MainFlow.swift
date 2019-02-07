//
//  MainFlow.swift
//  RickMoya
//
//  Created by any.pinheiro on 01/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxFlow

class MainFlow: Flow {
    
    var root: Presentable{
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? MainStep else {return .none}
        
        switch step {
        case .listCharacter:
            return navigateToCharacterList()
        }
    }
    
    private func navigateToCharacterList() -> NextFlowItems{
        let viewModel = MainViewModel(with: CharacterService.shared)
        let viewController = MainViewController.instantiate(with: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel as! Stepper))
    }
}
