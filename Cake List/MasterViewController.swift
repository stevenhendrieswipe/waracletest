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
    
    lazy var cakeTableModelController = CakeTableModelController(cakeController: self.cakeController)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        masterView.tableView.delegate = cakeTableModelController
        masterView.tableView.dataSource = cakeTableModelController
        
        masterView.state = .loading
        
        cakeController.cakes { [weak self] (cakes) in
            if let self = self {
                self.masterView.state = .itemDisplay
            } else {
                
//                displayError
            }
        }
        
    }

}
