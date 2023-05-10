//
//  ViewController.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

final class CollectionViewController: UICollectionViewController {
    
    private var animes: [Anime] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAnime()
        
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animeCell", for: indexPath)
        guard let cell = cell as? CollectionViewCell else { return UICollectionViewCell() }
        let anime = animes[indexPath.row]
        cell.configure(with: anime)
        return cell
    }


}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 24, height: 226)
    }
}


extension CollectionViewController {
    private func fetchAnime() {
        URLSession.shared.dataTask(with: Link.mostPopular.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                self?.animes = try decoder.decode([Anime].self, from: data)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}



