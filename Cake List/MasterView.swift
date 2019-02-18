//
//  MasterView.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class MasterView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    func updateView() {
        tableView.reloadData()
    }
}

