//
//  SceneDelegate.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftUI
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
                       let deliveryListingViewController = Assembler.shared
                            .resolver
                            .resolve(DeliveryListingViewController.self)!
                 

                        let navigation = UINavigationController(rootViewController: deliveryListingViewController)
                        window.rootViewController = navigation

                        self.window = window
                        window.makeKeyAndVisible()
        }
    }
}

