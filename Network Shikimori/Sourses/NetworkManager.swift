//
//  NetworkManager.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//
import UIKit
import Foundation


enum Link {
    case mostPopular
    case threeRandomAnimeScoreOverSeven
    
    var url: URL {
        switch self {
        case .mostPopular:
            return URL(string:
                "https://shikimori.me/api/animes?season=spring_2023&order=popularity&limit=50")!
        case .threeRandomAnimeScoreOverSeven:
            return URL(string:
                "https://shikimori.me/api/animes?kind=tv&order=random&limit=3&score=7")!
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
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data,NetworkError>)
    -> Void) {
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
}
