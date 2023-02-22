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
        collectionConfiguration()
    }
        
    private func collectionConfiguration(){
        if let layout = imageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.estimatedItemSize = CGSize(width: 50, height: 50)
                layout.itemSize = UICollectionViewFlowLayout.automaticSize
            }
        imageCollection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
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
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.setImageInCell(model: imagesList[indexPath.row])
        return cell
    }

}
