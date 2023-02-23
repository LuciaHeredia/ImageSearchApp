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
    var pageNumber: Int = Constants.pageNumberInit
    
    var imageTapped:Int = 0
        
    @IBOutlet weak var imageCollection: UICollectionView!
    var imagesList = [ImageModel]()
    
    let presenter = ImageSearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initApp()
    }
    
    func initApp(){
        collectionConfiguration()
        presenter.setViewDelegate(delegate: self)
        
        // default text in search field
        if let value = userDefaults.value(forKey: Constants.identifiers.lastSearch) as? String {
            searchText.text = value
            // show filtered images
            self.setUpData(searchText: value)
        } else {
            // show all images
            self.setUpData(searchText: "")
        }
    }
        
    private func collectionConfiguration(){
        if let layout = imageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: Constants.collectionConfig.size, height: Constants.collectionConfig.size)
                layout.itemSize = UICollectionViewFlowLayout.automaticSize
            }
        imageCollection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        self.sText = (searchText.text ?? "") as String
            
        // clean
        self.presenter.clearAllImages()
        
        // show filtered images
        self.pageNumber = Constants.pageNumberInit
        self.setUpData(searchText: self.sText)
            
        // Save last search
        saveSearchField()
    }
    
    func setUpData(searchText: String){
        presenter.getImages(searchText: searchText.lowercased(), pageNumber: self.pageNumber) { (imagesResult) in
            if !imagesResult.isEmpty {
                self.presenter.setImages(imagesRecieved: imagesResult)
            } else {
                // clean
                self.presenter.clearAllImages()
                print("No images found.")
            }
        }
    }
    
    func saveSearchField(){
        if !self.sText.isEmpty {
            userDefaults.setValue(self.sText, forKey: Constants.identifiers.lastSearch)
        }
    }

    func presentImages(images: [ImageModel]) {
        self.imagesList = images
        
        DispatchQueue.main.async {
            self.imageCollection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! FullImageViewController
        VC.imageModel = presenter.getImages()[self.imageTapped]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.imageTapped = indexPath.row
        performSegue(withIdentifier: Constants.identifiers.segueId, sender: self)
   }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yCord = scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom        
        if yCord > (scrollView.contentSize.height + Constants.collectionConfig.scrollLoad) {
            self.pageNumber = self.pageNumber + 1
            setUpData(searchText: self.sText)
        }
    }

}
