//
//  MainViewController.swift
//  RickMoya
//
//  Created by any.pinheiro on 04/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITableViewController {
    
    static func instantiate(with viewModel: MainViewModelContract) -> MainViewController {
        let viewController = R.storyboard.main.instantiateInitialViewController()!
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    var viewModel: MainViewModelContract!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        bind()
    }
    
    private func bind(){
        viewModel.fetchCharacter().drive(tableView.rx.items(cellIdentifier: "CharacterCell", cellType: CharacterCell.self)) { _, element, cell in
            cell.set(character: element)
            }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

