//
//  LovelistViewController.swift
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

protocol LovelistDisplayLogic: class {
    func displayLovelist(viewModel: Lovelist.Products.ViewModel)
    func displayLovelistError(viewModel: Lovelist.Error.ViewModel)
}

class LovelistViewController: UIViewController, LovelistDisplayLogic {
    var interactor: LovelistBusinessLogic?
    var router: (NSObjectProtocol & LovelistRoutingLogic & LovelistDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var products : [Product] = []
    
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
        let interactor = LovelistInteractor()
        let presenter = LovelistPresenter()
        let router = LovelistRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupUI() {
        
        self.tableView.register(UINib(nibName: "LovelistCell", bundle: nil), forCellReuseIdentifier: "LovelistCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.isHidden = false
        }
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
        self.navigationController?.isNavigationBarHidden = false
        setupNavigationBar()
        setupUI()
        loadLovelist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Do something
    
    @IBAction func logoutAction(_ sender: Any) {
        CacheManager.shared.token = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadLovelist() {
        interactor?.lovelist()
    }
    
    func displayLovelist(viewModel: Lovelist.Products.ViewModel) {
        self.products = viewModel.products
        self.tableView.reloadData()
    }
    
    func displayLovelistError(viewModel: Lovelist.Error.ViewModel) {
        print("#error \(viewModel.message)")
    }
}



extension LovelistViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LovelistCell", for: indexPath) as! LovelistCell
        
        if self.products.count != 0 {
            let product = self.products[indexPath.row]
            cell.productNameView.text = product.name
            cell.productPriceView.text = "Rp. \(product.price)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
