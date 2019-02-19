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
    
    
    static func get(_ urlString: String, succcess: @escaping ((Data) -> Void), failed: @escaping ((Error) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                let networkError = NetworkingError()
                failed(networkError)
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failed(error)
                } else if let data = responseData {
                    succcess(data)
                } else {
                    let networkError = NetworkingError() //TODO - Add networking error
                    failed(networkError)
                }
            }
        }
        task.resume()
    }
    
}
