//
//  MainTabbar.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/7/17.
//

import UIKit
import RAMAnimatedTabBarController

class MainTabbar: RAMAnimatedTabBarController,UITabBarControllerDelegate {
    
}

extension MainTabbar{
    func commonInitView(){
        view.backgroundColor = UIColor.white;
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.yellow
        tabBar.barTintColor = .white
    }
}
