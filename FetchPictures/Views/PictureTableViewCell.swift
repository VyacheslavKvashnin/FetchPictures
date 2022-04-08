//
//  PictureTableViewCell.swift
//  FetchPictures
//
//  Created by Вячеслав Квашнин on 08.04.2022.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: CharacterImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setPicture(_ picture: Picture) {
        nameLabel.text = picture.title
        descriptionLabel.text = "\(picture.id)"
        pictureImageView.fetchImage(from: picture.thumbnailUrl)
    }
}
