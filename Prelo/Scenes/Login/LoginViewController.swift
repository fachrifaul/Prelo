//
//  LoginViewController.swift
//  Prelo
//
//  Created by Fachri Work on 11/13/17.
//  Copyright (c) 2017 Decadev. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import RxSwift
import RxCocoa
import SkyFloatingLabelTextField
import UIKit

protocol LoginDisplayLogic: class {
    func displayLogin(viewModel: Login.User.ViewModel)
    func displayLoginError(viewModel: Login.Error.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    @IBOutlet weak var emailUsernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let minimalEmailUsernameLength = 4
    fileprivate let minimalPasswordLength = 6
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        passwordTextField.isSecureTextEntry = true
        
        setupTextFieldValidations()
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let token = CacheManager.shared.token
        if !token.isEmpty {
            router?.routeToLovelist(segue: nil)
        }
    }
    
    // MARK: Actions
    
    @IBAction func loginAction(_ sender: Any) {
        let request = Login.User.Request(emailUsername: emailUsernameTextField.text!,
                                         password: passwordTextField.text!)
        interactor?.login(request: request)
    }
    
    @IBAction func loginFacebookAction(_ sender: Any) {
        showAlert(title: nil, message: "Still in Development")
    }
    
    @IBAction func loginTwitterAction(_ sender: Any) {
        showAlert(title: nil, message: "Still in Development")
    }
    
    // MARK: Display
    
    func displayLogin(viewModel: Login.User.ViewModel) {
        router?.routeToLovelist(segue: nil)
    }
    
    func displayLoginError(viewModel: Login.Error.ViewModel) {
        showAlert(title: nil, message: viewModel.message)
    }
}

extension LoginViewController {
    
    func setupTextFieldValidations() {
        let emailUsernameValid = emailUsernameTextField
            .rx
            .text
            .orEmpty
            .map { $0.characters.count >= self.minimalEmailUsernameLength }
            .share(replay: 1)
        
        emailUsernameValid
            .subscribe(onNext: { emailUsernameValid in
                self.emailUsernameTextField.errorMessage = emailUsernameValid ? nil : "minimal 4 karakter"
            })
            .disposed(by: disposeBag)
        
        let passwordValid = passwordTextField
            .rx
            .text
            .orEmpty
            .map { $0.characters.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        passwordValid
            .subscribe(onNext: { emailUsernameValid in
                self.passwordTextField.errorMessage = emailUsernameValid ? nil : "minimal 6 karakter"
            })
            .disposed(by: disposeBag)
        
        let everythingValid = Observable
            .combineLatest(emailUsernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        everythingValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
