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
        
        //  MARK: - set your SDK ACCESS TOKEN
        //  https://sdk-stocklift.co/docs/
        StockLiftSDK.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Im11V0NRRFdkYXlObk1GdEp5a241SlVrZGhpSjIiLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJpYXQiOjE3Mjg0ODU1OTd9.Qo6xYVdBWLW0lQX3SGOkjsblmUgYCy3WTpCKP0W98vw"
        
        return true
    }
}
