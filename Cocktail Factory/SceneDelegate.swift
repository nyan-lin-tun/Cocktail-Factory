//
//  SceneDelegate.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 21/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let dataController = DataController(modelName: "CocktailFactory")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        dataController.load()
        //tabBar
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        self.window?.rootViewController = mainTabBarController
        
        let homeNavigationContorller = mainTabBarController.viewControllers?[0] as? UINavigationController
        let homeViewController = homeNavigationContorller?.topViewController as! HomeCollectionViewController
        
        let categoryNavigationContorller = mainTabBarController.viewControllers?[1] as? UINavigationController
        let categoryViewController = categoryNavigationContorller?.topViewController as! CategoryTableViewController
        
        let glassNavigationContorller = mainTabBarController.viewControllers?[2] as? UINavigationController
        let glassViewController = glassNavigationContorller?.topViewController as! GlassTableViewController
        
        homeViewController.dataController = dataController
        categoryViewController.dataController = dataController
        glassViewController.dataController = dataController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        self.saveViewContext()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        self.saveViewContext()
    }

    
    func saveViewContext() {
        try? dataController.viewContext.save()
    }

}

