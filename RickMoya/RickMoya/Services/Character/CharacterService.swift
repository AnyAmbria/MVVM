//
//  CharacterService.swift
//  RickMoya
//
//  Created by any.pinheiro on 01/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//


import RxSwift
import Moya
import SwiftyJSON

protocol CharacterServiceContract {
    func fetchCharacter() -> Observable<[Character]>
}

class CharacterService: CharacterServiceContract {
    
    static let shared = CharacterService()
    
    let provider = MoyaProvider<CharacterAPI>()
    
    func fetchCharacter() -> Observable<[Character]> {
        return provider.rx.request(.listCharacters).map { response in
            guard let response = try? response.filterSuccessfulStatusCodes(), let json = try? JSON(data: response.data) else {

                return []
            }
            
//            guard let response = try? response.filterSuccessfulStatusCodes(), let data = try? response.data else {
//
//                return []
//            }
//
//            let character = try! JSONDecoder().decode(Response.self, from: data)
           
            
            //let baseImageUrl: String = json["BaseImageUrl"].stringValue
        
            let characters = json["results"].array?.map { json -> Character in

                let id = json["id"].intValue
                let name = json["name"].stringValue
                let gender = json["gender"].stringValue
                let imageUrl = json["image"].stringValue

                return Character(Id: id, Name: name, Gender: gender, Image: imageUrl)
            }
            
            //return character.results ?? []
            return characters ?? []
            }.asObservable()
    }
}
