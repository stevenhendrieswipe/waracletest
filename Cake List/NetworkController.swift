//
//  NetworkController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import Foundation

class NetworkController {

    struct NetworkingError: Error {
        
    }
    
    enum NetworkResult {
        case success(Data)
        case failure(Error)
    }
    

    static func makeGETRequest(_ urlString: String, result: @escaping ((NetworkResult) -> Void)) -> Bool {
        
        guard let url = URL(string: urlString) else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    result(.failure(error))
                } else if let jsonData = responseData {
                    result(.success(jsonData))
                } else {
                    let error = NetworkingError() //TODO - Add networking error
                    result(.failure(error))
                }
            }
        }
        task.resume()
        
        return true
    }
    
}
