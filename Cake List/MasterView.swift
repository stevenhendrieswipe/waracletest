//
//  MasterView.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

protocol MasterViewRefreshDelegate {
    func onRefreshActioned()
}

class MasterView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    let refreshControl = UIRefreshControl()
    
    var refreshDelegate: MasterViewRefreshDelegate? {
        didSet {
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refreshControl
            } else {
                tableView.addSubview(refreshControl)
            }
            refreshControl.addTarget(self, action: #selector(refreshActioned), for: .valueChanged)
        }
    }
    
    enum DisplayState {
        case loading
        case itemDisplay
    }
    
    var state: DisplayState = .loading {
        didSet {
            switch state {
            case .loading:
                displayLoading()
            case .itemDisplay:
                displayItems()
            }
        }
    }
    
    private func displayLoading() {
        
        tableView.isHidden = true
        loadingView.isHidden = false
    }
    
    private func displayItems() {
        
        tableView.isHidden = false
        loadingView.isHidden = true
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    @objc private func refreshActioned() {
        
        if let refreshDelegate = refreshDelegate {
            refreshDelegate.onRefreshActioned()
        }
    }
}

