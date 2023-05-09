//
//  ViewController.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animeCard", for: indexPath)
    
        // Configure the cell
    
        return cell
    }


}

extension CollectionViewController {
    private func fetchAnime() {
        URLSession.shared.dataTask(with: Link.mostPopular.url)
        { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let animes = try decoder.decode([Anime].self, from: data)
                print(animes)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func fetchRandomAnime(){
        URLSession.shared.dataTask(with: Link.threeRandomAnimeScoreOverSeven.url)
        { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let animesRandom = try decoder.decode([Anime].self, from: data)
                print(animesRandom)
            } catch {
                print(error)
            }
        }.resume()
    }
}



