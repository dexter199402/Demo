//
//  ImageDataModel.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/21.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation

struct ImageDataModel: Codable {
    var photos: ImageDataModel_photos
    struct ImageDataModel_photos: Codable {
        var page: Int
        var pages: Int
        var perpage: Int
        var total: String
        var photo: [ImageDataModel_photos_photo]
    }
    struct ImageDataModel_photos_photo: Codable {
        var farm: Int
        var id: String
        var isfamily :Int
        var isfriend :Int
        var ispublic :Int
        var owner :String
        var secret :String
        var server :String
        var title :String
    }
}

