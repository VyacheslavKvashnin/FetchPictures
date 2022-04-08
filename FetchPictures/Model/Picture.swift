//
//  Picture.swift
//  FetchPictures
//
//  Created by Вячеслав Квашнин on 08.04.2022.
//

struct Picture: Decodable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}
