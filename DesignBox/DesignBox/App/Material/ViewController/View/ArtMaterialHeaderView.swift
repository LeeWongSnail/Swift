//
//  ArtMaterialHeaderView.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/7.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtMaterialHeaderView: UICollectionReusableView {

    @IBOutlet weak var materialSugView: UIScrollView!
    var topicViewArray:[ArtImageView]?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func topicDidTapBlock(sender:UITapGestureRecognizer ) -> Void {
        
    }
    
    
    
    let IMAGE_HEIGHT = 70
    
    func configHeader(topics:[Any]) -> Void {
        
        if ((self.topicViewArray != nil) && ((self.topicViewArray?.count)! > 0)) {
            for btn in self.topicViewArray! {
                btn.removeFromSuperview()
            }            
        }
        
        var index = 0
        for topic in topics {
            
            let btn = ArtImageView()
            let offset = CGFloat(index == 0 ? 0 : 5*index) +  (CGFloat(index) * CGFloat(IMAGE_HEIGHT))
           
            
            btn.frame = CGRect(x: Int(offset), y: 0, width: IMAGE_HEIGHT, height: IMAGE_HEIGHT)
            btn.backgroundColor = UIColor.clear
            btn.tag = 10000 + index
            
            
            let defaultImage = UIImage.init(named: "picture_default")
            btn.art_setImageWith(imageURL: (topic as! [String:AnyObject])["imgurl"] as? String, placeholder: defaultImage!)
            btn.isUserInteractionEnabled = true
            btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ArtMaterialHeaderView.topicDidTapBlock(sender:))))
            
            let maskView = UIView.init(frame: btn.bounds)
            maskView.backgroundColor = UIColor.black
            maskView.alpha = 0.4
            btn.addSubview(maskView)
            maskView.isUserInteractionEnabled = false
            
            let size = btn.bounds.size
            let label = UILabel(frame: CGRect(x: 6, y: 0, width: size.width-12, height: size.height))
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 13)
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.white
            label.text = (topic as! [String:AnyObject])["name"] as? String
            label.isUserInteractionEnabled = false
            btn.addSubview(label)
            
            self.materialSugView.addSubview(btn)
            self.topicViewArray?.append(btn)
            
            index += 1
        }
        
        let width = IMAGE_HEIGHT * topics.count + 5 * (topics.count - 1)
        self.materialSugView.contentSize = CGSize(width: width, height: IMAGE_HEIGHT)
        
    }
    
    class func materialHeaderHeight() -> CGFloat {
        return 220
    }
    
}
