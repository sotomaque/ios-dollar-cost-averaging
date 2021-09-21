//
//  ApiService.swift
//  ios-dollar-cost-averaging
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import Foundation
import Combine

struct APIService {

    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["K6RM6UNX3BVATU4R", "LHCYFQHDMCN5LC5Q", "SY9RG6VXCB8ZFCR5"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
