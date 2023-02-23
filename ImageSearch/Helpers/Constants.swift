//
//  Constants.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import Foundation
struct Constants {
        
    static let pageNumberInit = 1
    
    static func getUrl(searchStr: String, page: Int) -> String {
        return "https://pixabay.com/api/?q=\(searchStr)&key=6814610-cd083c066ad38bb511337fb2b&page=\(String(page))".spaceHandleInUrl()
    }
    
    struct identifiers {
        static let segueId = "toFullImageSegue"
        static let lastSearch = "lastSearch"
        
        static let collectionViewCellId = "ImageCollectionViewCell"
        static let cellId = "cell"
    }
    
    struct collectionConfig {
        static let size = 20
        static let scrollLoad = 10.0
    }
    
    struct urlParams {
        static let httpStatusCode = 200
    }
    
    struct errors {
        static let imageDownloadError = "Error while getting image from URL."
    }
    
}

extension String{
    func spaceHandleInUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
    }
}
