//
//  LoveListViewModel.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/23.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation
import UIKit

class LoveListViewModel {
    
    func getListNumber() -> Int {
        return LoveModel.getAllEntity()?.count ?? 0
    }
    
    func getList() -> [Entity]? {
        return LoveModel.getAllEntity()
    }
    
    //圖片讀取
    func cellImageLoad(imageView:UIImageView,urlString:String) {
        ImageLoad.cellImageLoad(imageView: imageView, urlStr: urlString)
    }
    
    func getLoveButtonImage(row:Int) -> UIImage? {
        return UIImage(systemName: "heart.fill")
    }
    
    func loveImageAction(urlString:String) {
        LoveModel.deleteEntity(url: urlString)
    }
    
}
