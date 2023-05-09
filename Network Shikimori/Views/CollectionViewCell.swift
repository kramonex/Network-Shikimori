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
    
    
    func configure(with anime: Anime) {
        name.text = anime.russian
        type.text = anime.kind
        status.text = anime.status
        score.text = anime.score
        
        
        guard let imageUrl = URL(string: "https://shikimori.me/" + "\(anime.image.preview)") else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl ) else { return }
            DispatchQueue.main.async {
                self?.image.image = UIImage(data: imageData)
            }
        }
    }
}

