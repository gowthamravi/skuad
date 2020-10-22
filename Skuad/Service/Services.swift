//
//  Services.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/16/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import Foundation

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()

    enum ServiceError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(ServiceError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }

            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(ServiceError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        task.resume()
    }
}
