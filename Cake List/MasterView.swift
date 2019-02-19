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
    @IBOutlet weak var loadingView: UIView!
    
    enum DisplayState {
        case loading
        case itemDisplay
        case error
    }
    
    var state: DisplayState = .loading {
        didSet {
            switch state {
            case .loading:
                displayLoading()
            case .itemDisplay:
                displayItems()
            case .error:
                displayError()
            }
        }
    }
    
    private
    
    func displayLoading() {
        tableView.isHidden = true
        loadingView.isHidden = false
    }
    
    func displayItems() {
        tableView.isHidden = false
        loadingView.isHidden = true
        tableView.reloadData()
    }
    
    func displayError() {
        
    }
    
    
    
    func updateView() {
        tableView.reloadData()
    }
}

