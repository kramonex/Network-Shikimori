//
//  NetworkManager.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import Foundation


enum Link {
    case mostPopular
    case threeRandomAnime
    
    var url: URL {
        switch self {
        case .mostPopular:
            return URL(string:
                "https://shikimori.me/api/animes?season=spring_2023&status=ongoing&order=popularity&limit=50")!
        case .threeRandomAnime:
            return URL(string:
                "https://shikimori.me/api/animes?kind=tv&order=random&limit=3&score=6&season=2000_2022")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data,NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let animes = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(animes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

