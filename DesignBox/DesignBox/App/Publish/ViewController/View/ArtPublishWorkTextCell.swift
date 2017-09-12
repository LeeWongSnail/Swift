//
//  ArtPublishWorkTextCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPublishWorkTextCell: UITableViewCell {

    @IBOutlet weak var textView: ArtTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    class func cellHeight() -> CGFloat {
        return 216
    }
    
}

extension ArtPublishWorkTextCell:UITextViewDelegate {
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.characters.count < 1 {
            textView.text = "请填写作品描述"
            textView.textColor = UIColor.gray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请填写作品描述" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
}


