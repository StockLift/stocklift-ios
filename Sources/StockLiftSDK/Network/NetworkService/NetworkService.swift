//
//  NetworkService.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//
//

import Foundation
import UIKit
import os

//TODO: - finish setup
@available(iOS 13.0, *)
public final class NetworkService {
    
    private init() { }
    //TODO: - investigate what this issue is - it does not show in the main app package
    @MainActor public static let shared = NetworkService()
//    static let oneSignalAppId = OneSignalHelper.appId
    private let defaults = UserDefaults.standard
    
    public static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    public static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
//    var deviceId: String {
//        UIDevice.current.identifierForVendor?.uuidString ?? "NO_DEVICE_ID"
//    }
    
    /// HEADERS
    var baseHeaders: [String : String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(defaults.string(forKey: UserKeys.jwToken) ?? "NO_ACCESS_TOKEN")",
            "uid": "\(defaults.string(forKey: UserKeys.userUuid) ?? "NO_UID")",
//            "Device-ID": "\(deviceId)",
            "App-Version": "\(NetworkService.appVersion?.replacingOccurrences(of: ".", with: "") ?? "version_null")"
        ]
    }
    
    /// HTTP Methods
    public enum Methods: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /// LOGGER
//    public static let logger = Logger (
//        subsystem: Bundle.main.bundleIdentifier!,
//        category: String(describing: NetworkService.self)
//    )
    
    /// SET SIGNED IN USER IN USER DEFAULTS
//    public func setUserObject(_ user: SLUser?) {
//        do {
//            try self.defaults.setObject(user, forKey: UserKeys.userObj)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    /// GET SIGNED IN USER IN USER DEFAULTS
//    public func getUserObject() -> SLUser? {
//        do {
//            let user = try defaults.getObject(forKey: UserKeys.userObj, castTo: SLUser.self)
//            return user
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//    
//    /// SET SIGNED IN USER CREDENTIALS IN USER DEFAULTS
//    public func setCredentialObject(_ credential: Credentials) {
//        do {
//            try self.defaults.setObject(credential, forKey: UserKeys.credentials)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    /// GET SIGNED IN USER CREDENTIALS IN USER DEFAULTS
//    public func getCredentialObject() -> Credentials? {
//        do {
//            let credential = try defaults.getObject(forKey: UserKeys.credentials, castTo: Credentials.self)
//            return credential
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
}


