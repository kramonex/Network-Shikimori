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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomAnime.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animeRandomCell", for: indexPath)
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        let anime = randomAnime[indexPath.row]
        cell.configure(with: anime)
        return cell
    }
    


}
