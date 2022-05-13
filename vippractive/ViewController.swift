//
//  ViewController.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 12/05/2022.
//

import UIKit

//  MARK:  View

protocol ViewSetup {
    func setup() -> Void
}

protocol HomeDisplayLogic {
    func updateCount(label: String)
}

class HomeViewController: UIViewController, ViewSetup, HomeDisplayLogic {
    var interactor : HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        let router = HomeRouter()
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.routeToDetailScreen(segue: segue)
    }
    func updateCount(label: String) -> Void {
        self.label.text = label
    }
    
    @IBAction func onIncrementPressed(_ sender: Any) {
        interactor?.increment()
    }
    
    @IBAction func onDecrementPressed(_ sender: Any) {
        interactor?.decrement()
    }
    

    
}

// MARK: Interactor

protocol HomeBusinessLogic {
    func increment()
    func decrement()
}

protocol HomeDatastore {
    var count: Int {get}
}

class HomeInteractor: HomeBusinessLogic , HomeDatastore {
    var presenter: HomePresentationLogic?
    
    var count: Int = 0
    
    // todo set default func
    
    func increment() {
        count += 1
        presenter?.updateCount(count: count)
    }
    
    func decrement() {
        count -= 1
        presenter?.updateCount(count: count)
    }
    
}


// MARK: Presenter

protocol HomePresentationLogic {
    func updateCount(count: Int)
}

class HomePresenter: HomePresentationLogic {
    var viewController: HomeViewController?
    
    func updateCount(count: Int) {
        let label = "\(count)"
        viewController?.updateCount(label: label)
    }
    
}


// MARK: Router

protocol HomeRoutingLogic {
    func routeToDetailScreen(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    var viewController: HomeViewController?
    var dataStore: HomeDatastore?
    
    func routeToDetailScreen(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            passDataToDetailView(source: viewController , destination: destinationVC)
        }
    }
    
    func passDataToDetailView(source: HomeViewController?, destination: DetailViewController?) {
        destination?.count = dataStore?.count
    }
}
