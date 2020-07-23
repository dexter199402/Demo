//
//  SearchViewModel.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/21.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation
import Alamofire

class SearchViewModel {
    
    var searchText: String = "" {
        didSet {
            textFelidCheck()
        }
    }
    var pageNumberText: String = "" {
        didSet {
            textFelidCheck()
        }
    }
    var searchButtonisEnabled:Bool = false {
        didSet {
            buttonStatusChange?()
        }
    }
    
    //MARK: - 通知方法
    //按鈕更新狀態
    var buttonStatusChange: (() -> Void)?
    //查詢結果完成
    var searchResultCompletion: (() -> Void)?
    
    //MARK: - func
    //輸入文字檢查更新按鈕狀態
    private func textFelidCheck() {
        let bool:Bool = {
            return searchText != "" && pageNumberText != ""
        }()
        if searchButtonisEnabled != bool {
            searchButtonisEnabled = bool
        }
    }
    //關鍵字找圖片動作
    func searchImage() {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c183a1f9ddd87838165e02849da1234d&text=\(searchText)&per_page=\(pageNumberText)&page=1&format=json&nojsoncallback=1"
        Alamofire.request(url, method: .post, encoding: URLEncoding.httpBody).responseJSON { (response) in
            do {
                let data = try JSONDecoder().decode(ImageDataModel.self, from: response.data ?? Data())
                SearchHandler.setNewSearch(data: data,text:self.searchText,per_page:self.pageNumberText)
                self.searchResultCompletion?()
            }catch{
                print(error)
            }
        }
    }
}
