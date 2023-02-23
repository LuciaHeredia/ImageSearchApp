//
//  FullImageViewController.swift
//  ImageSearch
//
//  Created by lucia heredia on 23/02/2023.
//

import UIKit

class FullImageViewController: UIViewController {

    var imageModel: ImageModel? = nil
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Full Image View.")
        
        // loading spinner
        spinner.startAnimating()
        
        // show NavBar
        self.navigationController?.isNavigationBarHidden = false
        
        initImageView()
    }
    
    func initImageView(){
        guard let imageUrl = URL(string: imageModel!.largeImageURL) else { return}
        self.imageView.downloadImage(url: imageUrl)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            debugPrint("Back Btn pressed.")
            if self.spinner.isAnimating{
                // stop loading spinner
                self.spinner.stopAnimating()
                // hiding spinner
                self.spinner.isHidden = true
            }
        }
    }
    
}
