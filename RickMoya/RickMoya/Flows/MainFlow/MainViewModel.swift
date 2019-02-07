//
//  MainViewModel.swift
//  RickMoya
//
//  Created by any.pinheiro on 04/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxCocoa
import RxSwift
import RxFlow

protocol MainViewModelContract {
    func  fetchCharacter() -> Driver<[Character]>
}

class MainViewModel: Stepper, MainViewModelContract {
    let characterService : CharacterServiceContract
    
    init(with characterService: CharacterServiceContract) {
        self.characterService = characterService
    }
    
    func fetchCharacter() -> Driver<[Character]> {
        return characterService.fetchCharacter().asDriver(onErrorJustReturn: [])
    }
}
