//
//  NetworkController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import Foundation

class NetworkController {

    enum NetworkingError: Error {
        case invalidURL
        case responseError(Error)
        case invalidResponse
    }
    
    func get(_ urlString: String, succcess: @escaping ((Data) -> Void), failed: @escaping ((NetworkingError) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                failed(NetworkingError.invalidURL)
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failed(NetworkingError.responseError(error))
                } else if let data = responseData {
                    succcess(data)
                } else {
                    failed(NetworkingError.invalidResponse)
                }
            }
        }
        task.resume()
    }
    
}
