//
//  CharactereAPI.swift
//  RickMoya
//
//  Created by any.pinheiro on 01/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//


import Moya

enum CharacterAPI {
    case listCharacters
    case characterLocations
}

extension CharacterAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }
    
    public var path: String {
        switch self {
        case .listCharacters:
            return "/character"
        case .characterLocations:
            return "/locations"
        }
    }
    
    public var method: Method {
        switch self {
        case .listCharacters, .characterLocations:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .listCharacters, .characterLocations:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
