//
//  AppDelegate.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/10/24.
//

import UIKit
import StockLiftSDK

public final class AppDelegate: NSObject, UIApplicationDelegate {
    
    public func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //MARK: - set your SDK ACCESS TOKEN https://sdk-stocklift.co/docs/
        StockLiftSDK.accessToken = "123"
        
        return true
    }
}
