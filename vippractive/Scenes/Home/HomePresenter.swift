//
//  Presenter.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation


protocol HomePresentationLogic {
    func updateCount(count: Int)
    func presentFetchedNumber(response: Home.fetchRandomNumber.Response)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK:  VIP setup
    
    var viewController: HomeViewController?
    
    func presentFetchedNumber(response: Home.fetchRandomNumber.Response) {
        updateCount(count: response.number)
    }
    
    func updateCount(count: Int) {
        let viewModel = Home.fetchRandomNumber.ViewModel(number: "\(count)")
        viewController?.updateCount(viewModel: viewModel)
    }
    
}
