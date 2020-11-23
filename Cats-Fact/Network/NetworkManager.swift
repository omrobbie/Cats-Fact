//
//  NetworkManager.swift
//  Cats-Fact
//
//  Created by omrobbie on 23/11/20.
//

import Foundation

protocol NetworkManagerContract {
    func getRandomFact(completion: @escaping (String) -> ())
}

class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager: NetworkManagerContract {
    func getRandomFact(completion: @escaping (String) -> ()) {
        guard let url = URL(string: ApiCall.randomUrl) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let response = response as? HTTPURLResponse,
               (200...299).contains(response.statusCode) else {
                print("Bad URL Response.")
                return
            }

            guard let data = data else {
                print("Invalid response.")
                return
            }

            do {
                let decodeData = try JSONDecoder().decode(CatModel.self, from: data)

                if let text = decodeData.text {
                    completion(text)
                } else {
                    completion("Cat fact is empty!")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
