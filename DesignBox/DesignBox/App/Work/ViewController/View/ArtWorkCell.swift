//
//  ArtWorkCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtWorkCell: UITableViewCell {

    func buildUI() -> Void {
        
        
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Lazy Load
    lazy var iconImage: ArtImageView? = {
        var tempImage = ArtImageView()
        return tempImage
    }()
    
    lazy var nickname: UILabel? = {
        var tempLabel = UILabel()
        tempLabel.font = UIFont().withSize(15)
        tempLabel.textColor = UIColor.black
        return tempLabel
    }()
    
    lazy var detailLabel: UILabel? = {
        var tempLabel = UILabel()
        tempLabel.font = UIFont().withSize(12)
        tempLabel.textColor = UIColor.black
        return tempLabel
    }()
    
    lazy var tagBtn:UIButton? = {
        var tempBtn = UIButton(type: UIButtonType.custom)
        tempBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return tempBtn
    }()
    
    lazy var contentLabel: UILabel? = {
        var tempLabel = UILabel()
        
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        
        return tempLabel
    }()
    
}
