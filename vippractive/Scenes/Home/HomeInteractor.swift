//
//  HomeInteractor.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation

// expose to view controller
// events trigger by scene/view/user
protocol HomeBusinessLogic {
    func fetchRandomNumber(request: Home.fetchRandomNumber.Request)
    func increment()
    func decrement()
}

// expose to router
// store the state of the scene
protocol HomeDatastore {
    var count: Int {get}
}

class HomeInteractor: HomeBusinessLogic , HomeDatastore {
    
    // MARK: VIP setup
    
    var presenter: HomePresentationLogic?
    let worker = HomeWorker()
    
    // MARK: States
    
    var count: Int = 0
    
    // MARK: Events
    
    // todo set default func
    // todo refactor, and loading, and all
    func fetchRandomNumber(request: Home.fetchRandomNumber.Request) {
        do {
            try worker.fetchRandomNumber(onSuccess: { number in
                let response = Home.fetchRandomNumber.Response(number: number)
                // todo wow! what was the benifit of getting raw response. lol
                self.count = response.number
                self.presenter?.presentFetchedNumber(response: response)
            })
        } catch {
            print("OH M G ERROR")
        }
    }
    
    func increment() {
        count += 1
        presenter?.updateCount(count: count)
    }
    
    func decrement() {
        count -= 1
        presenter?.updateCount(count: count)
    }
    
}
