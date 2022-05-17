//
//  Presenter.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation


protocol HomePresentationLogic {
    func updateCount(count: Int)
    func startFetching()
    func presentFetchedNumber(response: Home.fetchRandomNumber.Response)
    func stopFetching()
}

class HomePresenter: HomePresentationLogic {
    
    // MARK:  VIP setup
    
    let viewController: HomeDisplayLogic
    
    init(viewController: HomeDisplayLogic) {
        self.viewController = viewController
    }
    
    func startFetching() {
        viewController.showProgressIndicator()
        viewController.disableButtons()
    }
    
    func stopFetching() {
        viewController.hideprogressIndicator()
        viewController.unableButtons()
    }
    
    func presentFetchedNumber(response: Home.fetchRandomNumber.Response) {
        stopFetching()
        updateCount(count: response.number)
    }
    
    func updateCount(count: Int) {
        let viewModel = Home.fetchRandomNumber.ViewModel(number: "\(count)")
        viewController.updateCount(viewModel: viewModel)
    }
    
}
