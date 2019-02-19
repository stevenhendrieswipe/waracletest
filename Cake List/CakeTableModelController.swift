//
//  CakeTableModelController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class CakeTableModelController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let cakeController: CakeController
    
    init(cakeController: CakeController) {
        self.cakeController = cakeController
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cakeController.cakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CakeCell", for: indexPath)
    
        if let cakeCell = cell as? CakeCell {
            
            let cakeItem = cakeController.cakes[indexPath.row]
            cakeCell.titleLabel.text = cakeItem.title
            cakeCell.descriptionLabel.text = cakeItem.description
            cakeCell.cakeImage.image = nil
            
            cakeController.cakeImage(from: cakeItem.imageURL) { (image) in
                if let updatedCell = tableView.cellForRow(at: indexPath) as? CakeCell,
                    let imageview = updatedCell.cakeImage {
                    
                    DispatchQueue.main.async {
                        updatedCell.titleLabel.text = cakeItem.title
                        updatedCell.descriptionLabel.text = cakeItem.description
                        imageview.image = image ?? UIImage(named: "error.png")
                    }
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
