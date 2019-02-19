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
    
    var networkController: NetworkController!
    var cakeController: CakeController!
    var cakeTableModelController: CakeTableModelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupModelControllers()
        
        masterView.state = .loading
        
        cakeController.cakes(success: { (cakes) in
            self.masterView.state = cakes.isEmpty ? .error : .itemDisplay
        }, failed: { (error) in
            self.masterView.state = .error
        })
        
    }
    
    private func setupModelControllers() {
        
        networkController = NetworkController()
        cakeController = CakeController(networkController: networkController)
        cakeTableModelController = CakeTableModelController(cakeController: cakeController)
        
        masterView.tableView.delegate = cakeTableModelController
        masterView.tableView.dataSource = cakeTableModelController
    }
}
