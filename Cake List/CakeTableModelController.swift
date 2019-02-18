//
//  CakeTableModelController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class CakeTableModelController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cakeItems = [CakeItem]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cakeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return tableView.dequeueReusableCell(withIdentifier: "CakeCell", for: indexPath) as! CakeCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CakeCell {
            let cakeItem = cakeItems[indexPath.row]
            cell.titleLabel.text = cakeItem.title
            cell.descriptionLabel.text = cakeItem.description
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
  
}
