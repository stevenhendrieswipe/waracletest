//
//  CakeController
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import Foundation

class CakeController {
    
    let cakeURL = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    
    func getItems(_ complete: @escaping ([CakeItem]) -> Void) {
     
        
        if NetworkController.makeGETRequest(cakeURL) { (result) in
            switch(result) {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let cakes = try decoder.decode([CakeItem].self, from: data)
                    complete(cakes)
                } catch {
                    complete([])
                }
            case .failure(let error):
                complete([])
            }
        }
    }
}
