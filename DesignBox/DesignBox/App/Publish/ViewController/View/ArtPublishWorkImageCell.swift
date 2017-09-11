//
//  ArtPublishWorkImageCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPublishWorkImageCell: UITableViewCell {

    
    //MARK: BUILD UI
    
    func buildUI() -> Void {
        self.contentView.addSubview(self.sepLine)
        self.sepLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    lazy var sepLine = { () -> UIView in 
        let tempLine = UIView()
        tempLine.backgroundColor = UIColor.art_sepLineHColor()
        return tempLine
    }()

}
