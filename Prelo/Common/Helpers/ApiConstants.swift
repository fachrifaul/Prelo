//
//  ApiConstants.swift
//  Prelo
//
//  Created by Fachri Work on 11/13/17.
//  Copyright © 2017 Decadev. All rights reserved.
//

import Foundation

class ApiConstants: NSObject {
    static let baseUrl = "https://dev.prelo.id/api/"
    
    static let login = "auth/login"
    
    public static func absoluteUrl(path: String) -> String {
        return (ApiConstants.baseUrl as NSString).appendingPathComponent(path)
    }
    
}

class ApiResponse {
    
    enum LoginResponse {
        case success(token: String)
        case error(message: String)
    }
}
