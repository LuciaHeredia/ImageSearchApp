//
//  UIImageExtension.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: from) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
