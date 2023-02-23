//
//  UIImageExtension.swift
//  ImageSearch
//
//  Created by lucia heredia on 23/02/2023.
//

import UIKit

extension UIImageView {
    func downloadImage(url: URL){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == Constants.urlParams.httpStatusCode,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                print(Constants.errors.imageDownloadError)
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
