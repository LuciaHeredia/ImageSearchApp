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
    
    public func getImages(searchText: String){
        guard let url = URL(string: "https://pixabay.com/api/?q=kittens&key=6814610-cd083c066ad38bb511337fb2b") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let res = try JSONDecoder().decode(Container.self, from: data)
                let allImages = res.hits
                
                // filter
                let filteredImages = allImages.filter({ (image) -> Bool in
                    return image.tags.split(separator: ",").contains{$0 == searchText} })

                self?.delegate?.presentImages(images: filteredImages)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    

}
