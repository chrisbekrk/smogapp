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
    case getSensorsData(id: Int)
}

extension SmogGET: Endpoint{
    
    var base: String{
        return "http://api.gios.gov.pl"
    }
    
    var path: String {
        switch self {
        case .getAllStation:
            return "/pjp-api/rest/station/findAll"
        case .getIndexOfStation(let id):
            return "/pjp-api/rest/aqindex/getIndex/\(id)"
        case .getSensorsOfStation(let id):
            return "/pjp-api/rest/station/sensors/\(id)"
        case .getSensorsData(let id):
            return "/pjp-api/rest/data/getData/\(id)"
        }
    }
    
}
