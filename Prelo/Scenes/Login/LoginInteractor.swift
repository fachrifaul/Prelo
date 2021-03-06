//
//  LoginInteractor.swift
//  Prelo
//
//  Created by Fachri Work on 11/13/17.
//  Copyright (c) 2017 Decadev. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
    func login(request: Login.User.Request)
}

protocol LoginDataStore {
    //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker = LoginWorker()
    //var name: String = ""
    
    // MARK: Do something
    
    func login(request: Login.User.Request) {
        worker.login(request) { response in

            switch response {
            case .success(let token):
                CacheManager.shared.token = token
                let response = Login.User.Response()
                self.presenter?.presentLogin(response: response)
            case .error(let message):
                let response = Login.Error.Response(message: message)
                self.presenter?.presentLoginError(response: response)
            }
        }
    }
}
