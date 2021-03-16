//
//  Coordinator.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navRootViewController
        window.makeKeyAndVisible()
    }
}
