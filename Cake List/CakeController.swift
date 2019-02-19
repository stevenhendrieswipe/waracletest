//
//  CakeController
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class CakeController {
    
    let cakeListURL = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    
    var cakes = [CakeItem]()
    var cakeImages = [String: UIImage]()
    
    func cakes(_ complete: @escaping (([CakeItem]) -> Void)) {
     
        NetworkController.get(cakeListURL, succcess: { [weak self] (data) in
            if let self = self {
                self.cakes = self.parseCakes(data: data)
                complete(self.cakes)
            }
        }) { (error) in
            complete([])
        }
    }
    
    func cakeImage(from urlString: String, complete: @escaping ((UIImage?) -> Void)) {
     
        if let image = cakeImages[urlString] {
            DispatchQueue.main.async {
                complete(image)
            }
        } else {
            NetworkController.get(urlString, succcess: { [weak self] (data) in
            if let self = self {
                if let image = self.parseImage(data: data) {
                    self.cakeImages[urlString] = image
                    complete(image)
                } else {
                    complete(nil)
                }
            }
            }) { (error) in
                complete(nil)
            }
        }
    }
    
    private
    
    func parseCakes(data: Data) -> [CakeItem] {
        do {
            let decoder = JSONDecoder()
            let cakes = try decoder.decode([CakeItem].self, from: data)
            return cakes
        } catch {
            return []
        }
    }
    
    func parseImage(data: Data) -> UIImage? {
        let image = UIImage(data: data)
        return image
    }
    
    
}
