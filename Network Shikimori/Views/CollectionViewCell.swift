//
//  CollectionViewCell.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var score: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with anime: Anime) {
        name.text = anime.russian
        type.text = anime.kind
        status.text = anime.status
        score.text = anime.score
        
        
        guard let imageUrl = URL(string: "https://shikimori.me/" + "\(anime.image.preview)") else { return }
        
        networkManager.fetchImage(from: imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.image.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}


