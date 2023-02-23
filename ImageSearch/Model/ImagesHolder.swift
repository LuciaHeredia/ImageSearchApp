//
//  Images.swift
//  ImageSearch
//
//  Created by lucia heredia on 23/02/2023.
//

import Foundation

class ImagesHolder {
    
    private var imagesArray: [ImageModel] = []
    
    init(){}
    
    public func setImagesToArray(imagesRecieved:[ImageModel]){
        for item in imagesRecieved {
            self.imagesArray.append(item)
        }
    }
    
    public func getImagesArray() -> [ImageModel]{
        return self.imagesArray
    }
    
    public func emptyArray(){
        self.imagesArray = []
    }
    
}
