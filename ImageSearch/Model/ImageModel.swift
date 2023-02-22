//
//  Image.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import UIKit

class ImageModel: Codable {
    let tags: String
    
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
}
