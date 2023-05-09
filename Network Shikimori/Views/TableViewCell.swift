//
//  TableViewCell.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var animeImage: UIImageView!
    @IBOutlet var animeName: UILabel!
    @IBOutlet var animeType: UILabel!
    @IBOutlet var animeStatus: UILabel!
    @IBOutlet var animeScore: UILabel!
    
    
    func configure(with anime: Anime) {
        animeName.text = anime.russian
        animeType.text = anime.kind
        animeStatus.text = anime.status
        animeScore.text = anime.score
        
        
        guard let imageUrl = URL(string: "https://shikimori.me/" + "\(anime.image.preview)") else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl ) else { return }
            DispatchQueue.main.async {
                self?.animeImage.image = UIImage(data: imageData)
            }
        }
    }
}
