//
//  SearchResultViewController.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/22.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

class SearchResultViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let viewModel = SearchResultViewModel()
    let cellName = "SearchListCollCell"
    
    lazy var refresher:UIRefreshControl = {
        let refresherControl = UIRefreshControl()
        refresherControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        return refresherControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    func viewInit() {
        self.collectionView.refreshControl = refresher
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UINib(nibName: cellName, bundle:nil), forCellWithReuseIdentifier: cellName)
    }
    
    func bindViewModel() {
        viewModel.searchResultCompletion = {[weak self] in
            DispatchQueue.main.async {
                guard let vc = self else {return}
                vc.refresher.endRefreshing()
                vc.collectionView.reloadData()
            }
        }
        viewModel.loadNextPageCompletion = {[weak self] in
            DispatchQueue.main.async {
                guard let vc = self else {return}
                vc.collectionView.reloadData()
            }
        }
    }
    
    // 滑動畫面
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 當 scrollView 的 contentOffset 的 y 座標 + scrollView.frame 的高「大於等於」scrollView 的 contentView 的承載量時，表示快滾到最後一筆了，此時即可開始載入資料
        if ((scrollView.contentOffset.y + scrollView.frame.size.height + 200) >= scrollView.contentSize.height) {
            viewModel.loadNextPage()
        }
    }
    
    @objc func refreshControlAction() {
        viewModel.reLoadResult()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListNumber()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! SearchListCollCell
        cell.titleLabel.text = viewModel.getList()[indexPath.row].title
        viewModel.cellImageLoad(imageView: cell.imageVIew, row: indexPath.row)
        cell.backgroundColor = .lightGray
        cell.loveButton.setImage(viewModel.getLoveButtonImage(row: indexPath.row), for: .normal)
        cell._loveButtonAction = {[weak self] in
            guard let vc = self else {return}
            vc.viewModel.loveImageAction(row: indexPath.row)
            cell.loveButton.setImage(vc.viewModel.getLoveButtonImage(row: indexPath.row), for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width/2)-5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
