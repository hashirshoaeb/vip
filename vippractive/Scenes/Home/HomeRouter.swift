//
//  HomeRouter.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation
import UIKit


protocol HomeRoutingLogic {
    func routeToDetailScreen(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDatastore? { get }
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    var viewController: HomeViewController?
    var dataStore: HomeDatastore?
    
    func routeToDetailScreen(segue: UIStoryboardSegue?) {
        // todo refactor
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            passDataToDetailView(source: viewController , destination: destinationVC)
        }
    }
    
    func passDataToDetailView(source: HomeViewController?, destination: DetailViewController?) {
        // todo refactor 
        destination?.count = dataStore?.count
    }
}
