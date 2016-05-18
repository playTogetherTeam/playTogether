//
//  BaseNavigationController.swift
//  BeautifulDay
//
//  Created by jiachen on 16/1/27.
//  Copyright © 2016年 jiachen. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.translucent = false
        self.navigationBar.barTintColor = CustomBarTintColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
