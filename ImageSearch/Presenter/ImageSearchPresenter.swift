//
//  ImageSearchPresenter.swift
//  ImageSearch
//
//  Created by lucia heredia on 22/02/2023.
//

import UIKit

protocol ImageSearchPresenterDelegate: AnyObject {
    func presentImages(images: [ImageModel])
}

typealias PresenterDelegate = ImageSearchPresenterDelegate & UIViewController


class ImageSearchPresenter {
    weak var delegate: PresenterDelegate?
        
    private var images = ImagesHolder()
    
    public func getImages(searchText: String, pageNumber: Int, completion:@escaping([ImageModel])->()) {
        guard let url = URL(string: Constants.getUrl(searchStr: searchText, page: pageNumber)) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let res = try JSONDecoder().decode(Container.self, from: data)
                let imagesResult: [ImageModel] = res.hits
                completion(imagesResult)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setImages(imagesRecieved:[ImageModel]){
        self.images.setImagesToArray(imagesRecieved: imagesRecieved)
        self.delegate?.presentImages(images: self.images.getImagesArray())
    }
    
    public func getImages() -> [ImageModel]{
        return self.images.getImagesArray()
    }
    
    public func clearAllImages(){
        self.images.emptyArray()
        self.delegate?.presentImages(images: self.images.getImagesArray())
    }
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    

}
