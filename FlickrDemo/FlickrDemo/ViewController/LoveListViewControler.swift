//
//  LoveListViewControler.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/23.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

class LoveListViewControler: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let viewModel = LoveListViewModel()
    let cellName = "SearchListCollCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    func viewInit() {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UINib(nibName: cellName, bundle:nil), forCellWithReuseIdentifier: cellName)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListNumber()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! SearchListCollCell
        
        let data = viewModel.getList()?[indexPath.row]
        
        cell.titleLabel.text = data?.title ?? ""
        viewModel.cellImageLoad(imageView: cell.imageVIew, urlString: data?.imageUrl ?? "")
        cell.backgroundColor = .lightGray
        cell.loveButton.setImage(viewModel.getLoveButtonImage(row: indexPath.row), for: .normal)
        cell._loveButtonAction = {[weak self] in
            guard let vc = self else {return}
            vc.viewModel.loveImageAction(urlString: data?.imageUrl ?? "")
            vc.collectionView.reloadData()
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
