//
//  MainTabBarController.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/21.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

class MainTabBarController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            newNavViewController(vc: SearchViewController(), title: "搜尋",image: UIImage(systemName: "magnifyingglass")),
            newNavViewController(vc: LoveListViewControler(collectionViewLayout: UICollectionViewFlowLayout()), title: "我的最愛",image: UIImage(systemName: "heart"))
        ]
    }
    
    //viewcontroller
    func newNavViewController(vc: UIViewController,title:String,image:UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        vc.view.backgroundColor = .white
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return navController
    }
}
