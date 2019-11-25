//
//  AppDelegate.swift
//  ImageGridApp
//
//  Created by YuriyFpc on 11/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let webService = Webservice()
    
    lazy var root: UINavigationController = {
        let vc = CitiesController.instantiate()
        let model = CitiesModel()
        let imageOperations = ImageLoadOperations(operationsFactory: OperationsFactory(), service: webService, resourceFactory: ImageRresourceFactory())
        model.operationsOperator = imageOperations
        model.delegate = vc
        vc.model = model
        let root = UINavigationController(rootViewController: vc)
        return root
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        let w = UIWindow()
        w.rootViewController = root
        window = w
        w.makeKeyAndVisible()
        
        return true
    }

}

