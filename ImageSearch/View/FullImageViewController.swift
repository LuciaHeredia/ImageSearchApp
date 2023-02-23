//
//  FullImageViewController.swift
//  ImageSearch
//
//  Created by lucia heredia on 23/02/2023.
//

import UIKit

class FullImageViewController: UIViewController {

    var imageModel: ImageModel? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        imageViewSettings()
        initImageView()
    }
    
    func imageViewSettings(){
        var frameCell: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        frameCell.size = CGSize(width: imageModel!.previewWidth, height: imageModel!.previewHeight)
        imageView.frame = frameCell
    }
    
    func initImageView(){
        guard let imageUrl = URL(string: imageModel!.largeImageURL) else { return}
        self.imageView.downloadImage(url: imageUrl)
    }
    
}
