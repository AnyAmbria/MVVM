//
//  MainViewModel.swift
//  RickMoya
//
//  Created by any.pinheiro on 04/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import RxCocoa

protocol MainViewModelContract {
    func  fetchCharacter() -> Driver<[Character]>
}

class MainViewModel: MainViewModelContract {
    let characterService : CharacterServiceContract
    
    init(with characterService: CharacterServiceContract) {
        self.characterService = characterService
    }
    
    func fetchCharacter() -> Driver<[Character]> {
        return self.characterService.fetchCharacter().asDriver(onErrorJustReturn: [])
    }
}
