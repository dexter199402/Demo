//
//  SearchResultViewModel.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/22.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation
import Alamofire

class SearchResultViewModel {
    
    func getListNumber() -> Int {
        return SearchHandler.list.count
    }
    
    func getList() -> [ImageDataModel.ImageDataModel_photos_photo] {
        return SearchHandler.list
    }
    
    //查詢結果完成
    var searchResultCompletion: (() -> Void)?
    
    //下頁資料讀取完成
    var loadNextPageCompletion: (() -> Void)?
    
    //查詢結果
    func reLoadResult() {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c183a1f9ddd87838165e02849da1234d&text=\(SearchHandler.text)&per_page=\(SearchHandler.per_page)&page=1&format=json&nojsoncallback=1"
        Alamofire.request(url, method: .post, encoding: URLEncoding.httpBody).responseJSON { (response) in
            do {
                let data = try JSONDecoder().decode(ImageDataModel.self, from: response.data ?? Data())
                SearchHandler.setNewSearch(data: data,text:SearchHandler.text,per_page:SearchHandler.per_page)
                self.searchResultCompletion?()
            }catch{
                print(error)
            }
        }
    }
    
    //下頁資料讀取
    var isNextLoading:Bool = false
    func loadNextPage() {
        guard SearchHandler.pages >= (SearchHandler.page+1) && !isNextLoading else {
            return
        }
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c183a1f9ddd87838165e02849da1234d&text=\(SearchHandler.text)&per_page=\(SearchHandler.per_page)&page=\(SearchHandler.page+1)&format=json&nojsoncallback=1"
        SearchHandler.page+=1
        
        print(SearchHandler.page)
        
        isNextLoading = true
        Alamofire.request(url, method: .post, encoding: URLEncoding.httpBody).responseJSON { (response) in
            do {
                let data = try JSONDecoder().decode(ImageDataModel.self, from: response.data ?? Data())
                SearchHandler.addList(datalist: data.photos.photo)
                self.loadNextPageCompletion?()
            }catch{
                print(error)
            }
            self.isNextLoading = false
        }
    }
    
    //圖片讀取
    func cellImageLoad(imageView:UIImageView,row:Int) {
        
        let urlString: String = ImageUrl(row: row)
                
        ImageLoad.cellImageLoad(imageView: imageView, urlStr: urlString)
    }
    
    func ImageUrl(row:Int) -> String {
        let data = SearchHandler.list[row]
        return "https://farm\(data.farm).staticflickr.com/\(data.server)/\(data.id)_\(data.secret)_m.jpg"
    }
    
    //MARK: - 我的最愛功能
    func getLoveButtonImage(row:Int) -> UIImage? {
        return isLoved(row:row) ? UIImage(systemName: "heart.fill"):UIImage(systemName: "heart")
    }
    
    func loveImageAction(row:Int) {
        let url = ImageUrl(row: row)
        if isLoved(row:row) {
            LoveModel.deleteEntity(url: url)
        }else{
            LoveModel.addEntity(title: getList()[row].title, imageUrl: url)
        }
    }
    
    func isLoved(row:Int) -> Bool {
        if LoveModel.getEntity(url: ImageUrl(row: row)) != nil {
            return true
        }
        return false
    }
    
    
}
