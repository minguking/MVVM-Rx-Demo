//
//  RootViewController.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }

}
