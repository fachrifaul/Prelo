//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic {
    func presentLogin(response: Login.User.Response)
    func presentLoginError(response: Login.Error.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentLogin(response: Login.User.Response) {
        let viewModel = Login.User.ViewModel()
        viewController?.displayLogin(viewModel: viewModel)
    }
    
    func presentLoginError(response: Login.Error.Response) {
        let viewModel = Login.Error.ViewModel(message: response.message)
        viewController?.displayLoginError(viewModel: viewModel)
    }
    
}
