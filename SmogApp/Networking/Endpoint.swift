//
//  File.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {

    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }

}


enum SmogGET {
    case getAllStation
    case getIndexOfStation(id: Int)
    case getSensorsOfStation(id: Int)
    
}

extension SmogGET: Endpoint{
    
    var base: String{
        return ""
    }
    
    var path: String {
        switch self {
        case .getAllStation:
            return ""
        case .getIndexOfStation(let id):
            return ""
        case .getSensorsOfStation(let id):
            return ""
        }
    }
    
}
