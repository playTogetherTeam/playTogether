//
//  AppDelegate.swift
//  playTogether
//
//  Created by 马腾 on 16/4/18.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var tabbarController:UITabBarController!
//临时配置文件
    //public let CustomBarTintColor = UIColor(hexString: "EC5252")
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.createTabBarController()
        self.window?.rootViewController = mainViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func mainViewController() -> UIViewController{
        //firstStart不为空,不是是第一次启动
        
            
            return self.tabbarController
       
    }
    
    
    
    
    func createTabBarController(){
        self.tabbarController = UITabBarController.init()
        tabbarController.delegate = self
        
        //首页
        let homeVC = HomeViewController.init()
        homeVC.tabBarItem = UITabBarItem.init(title: nil, image: UIImage(named: "Home_unselected"),selectedImage:UIImage(named:"Home_selected"))
        let homeNav = UINavigationController.init(rootViewController: homeVC)
        
        //发现
        let DiscoverVC = DiscoverViewController.init()
        DiscoverVC.tabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "Square_normal"), selectedImage: UIImage.init(named: "Square_selected"))
        let DiscoverNav = UINavigationController.init(rootViewController: DiscoverVC)
        
        //发布
        let ReleaseVC = UIViewController.init()
        ReleaseVC .tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Show_normal"), selectedImage: UIImage(named: "Show_normal"))
        let ReleaseNav = UINavigationController(rootViewController: ReleaseVC )
        
        //消息中心
        let messageCenterVC = MessageCenterViewController.init()
        messageCenterVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Message_normal"), selectedImage: UIImage(named: "Message_selected"))
        let messageCenterNav = UINavigationController(rootViewController: messageCenterVC)
        
        //个人中心
        let personCenterVC = PersonCenterViewController.init()
        personCenterVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "PersonCenter_unlogin"), selectedImage: UIImage(named: "PersonCenter_unlogin"))
        let personCenterNav = UINavigationController(rootViewController: personCenterVC)

        
        let viewControlersArr = NSArray.init(objects: homeNav,DiscoverNav,ReleaseNav,messageCenterNav,personCenterNav)
        self.tabbarController.tabBar.translucent = false
        
        self.tabbarController.viewControllers = viewControlersArr as! [UINavigationController]
        
        for var i = 0;i < tabbarController.viewControllers?.count;i++
        {
            let nav = tabbarController.viewControllers![i] as! UINavigationController
            //源代码通过桥接使用了一个第三方库实现了直接输入16进制配置颜色的功能
            
            nav.navigationBar.barTintColor = UIColor.redColor()
            nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
            nav.navigationBar.translucent = false
        }
        
        
        
    }
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        
        let childArray = tabbarController.childViewControllers
        let index = childArray.indexOf(viewController)
        if index == 2 {
            print("Show me!")
            presentShowMeViewController(viewController)
            return false
        }else if index == 3 {
            //点击 '消息中心' 延迟5s 后发出通知
            //模拟网络刷新
//            viewController.tabBarItem.title = nil
//            postNotificationCenter(tabbarController.viewControllers!)
        }
        
        return true
    }
    
    func presentShowMeViewController(viewController:UIViewController) {
        let showMeVC = ReleaseViewController.init(leftTitle: "取消", rightTitle: "")
        let nav = BaseNavigationController(rootViewController: showMeVC)
        tabbarController.presentViewController(nav, animated: true, completion: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    extension AppDelegate {
//        func postNotificationCenter(viewControllers: [UIViewController]) {
//            //延迟10秒  推送 消息
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
//                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: UserHasNewMessage, object: nil))
//                let item = viewControllers[3].tabBarItem
//                item.title = nil
//                item.badgeValue = "NEW"
//            })
//        }
//        
//    }


}

