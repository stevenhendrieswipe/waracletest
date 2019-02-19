//
//  CakeController
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class CakeController {
    
    private let cakeListURL = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    
    let networkController: NetworkController
    
    var cakes = [CakeItem]()
    var cakeImages = [String: UIImage]()
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func cakes(success: @escaping (([CakeItem]) -> Void), failed: @escaping ((NetworkController.NetworkingError) -> Void)) {
        
        networkController.get(cakeListURL, succcess: { [unowned self] (data) in
            self.cakes = self.parseCakes(data: data)
            success(self.cakes)
        }, failed: { (error) in
            failed(error)
        })
    }
    
    func cakeImage(from urlString: String, success: @escaping ((UIImage?) -> Void), failed: @escaping ((NetworkController.NetworkingError) -> Void)) {
     
        if let image = cakeImages[urlString] {
            DispatchQueue.main.async {
                success(image)
            }
        } else {
            
            networkController.get(urlString, succcess: { [unowned self] (data) in
                if let image = self.parseImage(data: data) {
                    self.cakeImages[urlString] = image
                    success(image)
                } else {
                    failed(NetworkController.NetworkingError.invalidResponse)
                }
            }, failed: { (error) in
                failed(error)
            })
        }
    }
    

    
    private func parseCakes(data: Data) -> [CakeItem] {
        do {
            let decoder = JSONDecoder()
            let cakes = try decoder.decode([CakeItem].self, from: data)
            return cakes
        } catch {
            return []
        }
    }
    
    private func parseImage(data: Data) -> UIImage? {
        let image = UIImage(data: data)
        return image
    }
    
    
}
