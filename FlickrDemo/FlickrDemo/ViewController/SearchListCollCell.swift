//
//  SearchListCollCell.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/22.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import UIKit

class SearchListCollCell: UICollectionViewCell {
    
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        
    }
    
    var _loveButtonAction: (() -> Void)?
    @IBAction func loveButtonAction(_ sender: Any) {
        _loveButtonAction?()
    }
    
    
}
