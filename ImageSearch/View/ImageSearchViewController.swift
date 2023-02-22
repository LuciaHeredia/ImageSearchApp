//
//  ViewController.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import UIKit

class ImageSearchViewController: UIViewController, ImageSearchPresenterDelegate {
    
    let userDefaults = UserDefaults()
    
    @IBOutlet weak var searchText: UITextField!
    var sText: String = ""
    
    @IBOutlet weak var imageCollection: UICollectionView!
    var imagesList = [ImageModel]()
    
    private let presenter = ImageSearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchField()
    }
    
    func initSearchField(){
        if let value = userDefaults.value(forKey: "lastSearch") as? String {
            searchText.text = value
        }
    }
        
    
    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        self.sText = (searchText.text ?? "") as String
            
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getImages(searchText: self.sText)
            
        // Save last search
        saveSearchField()
    }
    
    func saveSearchField(){
        if !self.sText.isEmpty {
            userDefaults.setValue(self.sText, forKey: "lastSearch")
        }
    }

    func presentImages(images: [ImageModel]) {
        self.imagesList = images
        
        DispatchQueue.main.async {
            self.imageCollection.reloadData()
        }
    }
    
}


extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchTextFieldDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let urlImage = URL(string: imagesList[indexPath.row].previewURL)
        cell.imageView.downloadImage(from: urlImage!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/4, height: 128)
    }

}

extension UIImageView {
    func downloadImage(from url: URL){
        contentMode = .scaleToFill
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
