//
//  SmogClient.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

class SmogClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func get(from requestType: SmogGET, completion: @escaping (Result<[Station]?, APIError>) -> Void) {
        
        let endpoint = requestType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> [Station]? in
            guard let movieFeedResult = json as? [Station] else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}
