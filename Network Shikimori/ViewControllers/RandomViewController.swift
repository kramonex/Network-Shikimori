//
//  RandomViewController.swift
//  Network Shikimori
//
//  Created by kramonex on 09.05.2023.
//

import UIKit

final class RandomViewController: UITableViewController {
    
    private var randomAnime: [Anime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRandomAnime()
    }
    
    @IBAction func refreshAnimeDidTap() {
        fetchRandomAnime()
    }
    
// MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomAnime.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animeRandomCell", for: indexPath)
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        let animes = randomAnime[indexPath.row]
        cell.configure(with: animes)
        return cell
    }
}


//MARK: - RandomViewController

extension RandomViewController {
    private func fetchRandomAnime() {
        URLSession.shared.dataTask(with: Link.threeRandomAnime.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                self?.randomAnime = try decoder.decode([Anime].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
