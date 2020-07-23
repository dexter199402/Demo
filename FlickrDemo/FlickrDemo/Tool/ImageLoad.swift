//
//  ImageLoad.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/23.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

struct ImageLoad {
    static let imageCache = NSCache<NSString, UIImage>()
    static func cellImageLoad(imageView:UIImageView,urlStr:String) {
        imageView.accessibilityIdentifier = urlStr
        
        imageView.image = nil
        
        guard let url = URL(string: urlStr) else { return }
        
        if let imageFromCache = imageCache.object(forKey: urlStr as NSString) {
            imageView.image = imageFromCache
            imageView.layer.borderWidth = 0
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if imageView.accessibilityIdentifier == urlStr {
                    imageView.image = imageToCache
                    imageView.layer.borderWidth = 0
                }
                
                self.imageCache.setObject(imageToCache, forKey: urlStr as NSString)
            }
            
        }).resume()
    }
}
