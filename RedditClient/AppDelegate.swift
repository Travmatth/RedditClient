//
//  AppDelegate.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/7/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        
        // Root views of the respective nav controllers
        let settingsViewController: SettingsViewController = SettingsViewController()
        let multiRedditsViewController: MultiRedditsViewController = MultiRedditsViewController()
        let allRedditsViewController: GenericRedditsViewController = GenericRedditsViewController()
        let frontRedditsViewController: GenericRedditsViewController = GenericRedditsViewController()
        
        // Root nav controllers
        let allNavController: UINavigationController = UINavigationController.init(rootViewController: allRedditsViewController)
        let settingsNavController: UINavigationController = UINavigationController.init(rootViewController: settingsViewController)
        let multiNavController: UINavigationController = UINavigationController.init(rootViewController: multiRedditsViewController)
        let frontNavController: UINavigationController = UINavigationController.init(rootViewController: frontRedditsViewController)
        
        allRedditsViewController.pageType = .All
        frontRedditsViewController.pageType = .Front
        
        let userImage = UIImage(named: "circle-user-7")
        let multiRedditsImage = UIImage(named: "command-7")
        let redditsImage = UIImage(named: "layout-arrange-10-7")
        
        settingsNavController.tabBarItem = UITabBarItem(title: "User", image: userImage, tag: 1)
        multiNavController.tabBarItem = UITabBarItem(title: "Multi", image: multiRedditsImage, tag: 2)
        frontNavController.tabBarItem = UITabBarItem(title: "Front", image: redditsImage, tag: 3)
        allNavController.tabBarItem = UITabBarItem(title: "All", image: redditsImage, tag: 4)
        
        let tabBarController = UITabBarController()
        let controllers = [settingsNavController, multiNavController, frontNavController, allNavController]
        
        tabBarController.viewControllers = controllers
        
        self.window!.rootViewController = tabBarController
        self.window!.addSubview(tabBarController.view)
        self.window!.makeKeyAndVisible()
        
        return true
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


}

