//
//  MasterViewController.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, MasterViewRefreshDelegate {

    @IBOutlet var masterView: MasterView!
    
    var networkController: NetworkController!
    var cakeController: CakeController!
    var cakeTableModelController: CakeTableModelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupModelControllers()
        masterView.state = .loading
        requestCakes()
    }
    
    private func setupModelControllers() {
        
        networkController = NetworkController()
        cakeController = CakeController(networkController: networkController)
        cakeTableModelController = CakeTableModelController(cakeController: cakeController)
        
        masterView.refreshDelegate = self
        masterView.tableView.delegate = cakeTableModelController
        masterView.tableView.dataSource = cakeTableModelController
    }
    
    private func requestCakes() {
        
        cakeController.cakes(success: { [unowned self] (cakes) in
                if cakes.isEmpty {
                    self.displayError()
                } else {
                    self.masterView.state = .itemDisplay
                }
            }, failed: { (error) in
                self.displayError()
        })
    }
    
    private func displayError() {
        
        let errorAlert = UIAlertController(title: "Error", message: "Unable to retrieve cakes", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(errorAlert, animated: true)
    }
    
    func onRefreshActioned() {
        
        requestCakes()
    }
}
