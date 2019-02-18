//
//  MasterViewController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var masterView: MasterView!
    
    let cakeController = CakeController()
    let cakeTableModelController = CakeTableModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        masterView.tableView.delegate = cakeTableModelController
        masterView.tableView.dataSource = cakeTableModelController
        
        cakeController.getItems { [weak self] (cakes) in
            if let self = self {
                self.cakeTableModelController.cakeItems = cakes
                self.masterView.updateView()
            }
        }
        
    }

}
