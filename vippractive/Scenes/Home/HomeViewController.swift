//
//  ViewController.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 12/05/2022.
//

import UIKit

protocol ViewSetup {
    func setup() -> Void
}

// Methods that we only want to expose for presenter to call
protocol HomeDisplayLogic {
    func updateCount(viewModel: Home.fetchRandomNumber.ViewModel)
    func showProgressIndicator()
    func hideprogressIndicator()
    func unableButtons()
    func disableButtons()
}

class HomeViewController: UIViewController, ViewSetup, HomeDisplayLogic {
    
    // MARK: VIP setup
    
    var interactor : HomeBusinessLogic!
    var router: (HomeRoutingLogic & HomeDataPassing)!
    
    func setup() {
        let viewController = self
        let presenter = HomePresenter(viewController: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(viewController: viewController, dataStore: interactor)
        // router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.routeToDetailScreen(segue: segue)
    }
    
    // MARK: View
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
        progressIndicator.hidesWhenStopped = true
        loadRandomNumber()
    }
    
    func showProgressIndicator() {
        progressIndicator.startAnimating()
    }
    
    func hideprogressIndicator() {
        progressIndicator.stopAnimating()
    }
    
    func unableButtons() {
        incrementButton.isEnabled = true
        decrementButton.isEnabled = true
        detailButton.isEnabled = true
    }
    
    func disableButtons() {
        incrementButton.isEnabled = false
        decrementButton.isEnabled = false
        detailButton.isEnabled = false
    }
    
    func loadRandomNumber() {
        let request = Home.fetchRandomNumber.Request(min: 0, max: 20, count: 1)
        interactor.fetchRandomNumber(request: request)
    }
    
    func updateCount(viewModel: Home.fetchRandomNumber.ViewModel) -> Void {
        self.label.text = viewModel.number
    }
    
    @IBAction func onIncrementPressed(_ sender: Any) {
        interactor.increment()
    }
    
    @IBAction func onDecrementPressed(_ sender: Any) {
        interactor.decrement()
    }
    
}
