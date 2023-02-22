//
//  Container.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import UIKit

class Container: Codable {
    let total: Int
    let totalHits: Int
    let hits: [ImageModel]
}
