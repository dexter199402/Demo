//
//  SearchViewController.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/21.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let viewModel = SearchViewModel()
    lazy var resultViewController: SearchResultViewController = {
       return SearchResultViewController(collectionViewLayout: UICollectionViewFlowLayout())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        bindViewModel()
    }
    //view基本設定
    func viewInit() {
        searchTextField.placeholder = "關鍵字"
        searchTextField.tag = 0
        pageTextField.placeholder = "每頁顯示數量"
        pageTextField.tag = 1
        searchTextField.delegate = self
        pageTextField.delegate = self
        searchButton.setTitle("搜尋", for: .normal)
        searchButton.tintColor = .white
        buttonStatusChange(enabled:false)
    }
    //按鈕狀態更新
    func buttonStatusChange(enabled:Bool) {
        if enabled {
            searchButton.isEnabled = true
            searchButton.backgroundColor = .blue
        }else{
            searchButton.isEnabled = false
            searchButton.backgroundColor = .lightGray
        }
    }
    //綁定viewModel
    func bindViewModel() {
        viewModel.buttonStatusChange = {[weak self] in
            DispatchQueue.main.async {
                guard let vc = self else {return}
                vc.buttonStatusChange(enabled: vc.viewModel.searchButtonisEnabled)
            }
        }
        viewModel.searchResultCompletion = {[weak self] in
            DispatchQueue.main.async {
                guard let vc = self else {return}
                if (vc.navigationController?.topViewController?.isKind(of: vc.classForCoder)) ?? false {
                    vc.resultViewController.collectionView.setContentOffset(CGPoint(x:0,y:-88.0), animated: false)
                    vc.resultViewController.navigationItem.title = SearchHandler.text
                    vc.navigationController?.pushViewController(vc.resultViewController, animated: true)
                }
            }
        }
    }
    //MARK: - UI觸發
    @IBAction func searchButtonAction(_ sender: Any) {
        viewModel.searchImage()
    }
    
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            viewModel.searchText = textField.text ?? ""
        case 1:
            viewModel.pageNumberText = textField.text ?? ""
        default:
            break
        }
    }
}
