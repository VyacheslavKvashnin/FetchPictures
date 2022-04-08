//
//  PictureTableViewController.swift
//  FetchPictures
//
//  Created by Вячеслав Квашнин on 08.04.2022.
//

import UIKit

class PictureTableViewController: UITableViewController {
    
    private var pictures: [Picture] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureButtonPressed()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPicture", for: indexPath) as! PictureTableViewCell
        let picture = pictures[indexPath.row]
        cell.setPicture(picture)

        return cell
    }
}

extension PictureTableViewController {
    func pictureButtonPressed() {
        NetworkManager.shared.fetch(dataType: Picture.self, from: Link.photoURL.rawValue) { result in
            switch result {
                
            case .success(let pictures):
                self.pictures = pictures
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
