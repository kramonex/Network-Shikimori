//
//  TableViewCell.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet var animeImage: UIImageView!
    @IBOutlet var animeName: UILabel!
    @IBOutlet var animeType: UILabel!
    @IBOutlet var animeStatus: UILabel!
    @IBOutlet var animeScore: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with anime: Anime) {
        animeName.text = anime.russian
        animeType.text = anime.kind
        animeStatus.text = anime.status
        animeScore.text = anime.score
        
        
        guard let imageUrl = URL(string: "https://shikimori.me/" + "\(anime.image.preview)") else { return }
        
        networkManager.fetchImage(from: imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.animeImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
