//
//  DetailViewController.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 13/05/2022.
//

import UIKit



class DetailViewController: UIViewController {

    
    var count: Int?

    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCount()
    }
    
//    func setup() {
//        let viewController = self
//        let interactor = DetailInteractor()
//        let presenter = DetailPresenter()
//        viewController.interactor = interactor
//        interactor.presenter = presenter
//        presenter.viewController = viewController
//    }
    
    func setupCount() {
        counterLabel.text = "\(count ?? -1)"
    }
    
}


