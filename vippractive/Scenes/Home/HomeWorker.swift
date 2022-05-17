//
//  HomeWorker.swift
//  vippractive
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation


class HomeWorker {
    func fetchRandomNumber(onSuccess: @escaping (Int)->()) throws {
        let url = URL(string: "https://www.randomnumberapi.com/api/v1.0/random?min=1&max=10&count=1")
        print("going to get data")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                print("parsing data")
                if let numbers = try? JSONDecoder().decode(RWResponse.self, from: data) {
                    print("data parsed: ",numbers)
                    DispatchQueue.main.async {
                        onSuccess(numbers.first!)
                    }
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            print("Printing")
            
        }.resume()
    }
}
