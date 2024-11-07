//
//  Predators.swift
//  JP APex Predators
//
//  Created by Jinyuan Zhang on 06/11/2024.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []

    init() {
        decodeApexPredatorData()
    }

    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    //返回一个临时的过滤后的数组
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                predators in
                predators.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }

    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predators2 in
            if alphabetical {
                predator1.name < predators2.name
            } else {
                predator1.id < predators2.id
            }
        }
    }

    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
  
