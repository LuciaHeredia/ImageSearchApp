//
//  ImageCollectionViewCell.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "ImageCollectionViewCell"
    var frameCell: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    public let imageInCell: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageInCell)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    func setImageInCell(model: ImageModel) {
        let urlImage = URL(string: model.previewURL)
        imageInCell.downloadImage(url: urlImage!)
        self.frameCell.size = CGSize(width: model.previewWidth, height: model.previewHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageInCell.frame = self.frameCell
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
           setNeedsLayout()
           layoutIfNeeded()
       layoutAttributes.frame = self.frameCell
           return layoutAttributes
       }
    
}

extension UIImageView {
    func downloadImage(url: URL){

        //contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                print("Error while getting image from URL.")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}

