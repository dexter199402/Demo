//
//  SearchHandler.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/21.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation

struct SearchHandler {
    
    static private(set) var list:[ImageDataModel.ImageDataModel_photos_photo] = []
    
    static var page: Int = 0
    static private(set) var text: String = ""
    static private(set) var per_page: String = ""
    static private(set) var pages: Int = 0
    
    static func setNewSearch(data:ImageDataModel,text:String,per_page:String) {
        self.page = 1
        self.text = text
        self.per_page = per_page
        self.pages = data.photos.pages
        self.list = data.photos.photo
    }
    static func addList(datalist:[ImageDataModel.ImageDataModel_photos_photo]) {
        list += datalist
    }
}
