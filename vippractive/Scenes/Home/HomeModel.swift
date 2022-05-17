//
//  HomeModel.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation


enum Home {
    enum fetchRandomNumber {
        struct Request {
            let min: Int
            let max: Int
            let count: Int
        }
        struct Response {
            let number: Int
        }
        struct ViewModel {
            let number: String
        }
    }
}
