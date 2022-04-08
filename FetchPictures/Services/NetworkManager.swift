//
//  NetworkManager.swift
//  FetchPictures
//
//  Created by Вячеслав Квашнин on 08.04.2022.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "Bad URL address!"
    case invalidData = "Invalid Data!"
}

enum Link: String {
    case photoURL = "https://jsonplaceholder.typicode.com/photos"
}

class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, from urlString: String, completion: @escaping(Result<[T], NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let type = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }

        }.resume()
    }
}
