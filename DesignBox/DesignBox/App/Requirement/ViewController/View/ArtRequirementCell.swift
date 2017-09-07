//
//  ArtRequirementCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtRequirementCell: UITableViewCell {

    @IBOutlet weak var imageArea: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func calculateImageCenterAtIndex(index:UInt) -> CGPoint {
        let y = index/3
        let x = index%3
        let centerX = Float(x) * (ArtStyle.shared.art_workGridImageWidth + 5) + 5 + ArtStyle.shared.art_workGridImageWidth/2.0;
        let centerY = Float(y) * (ArtStyle.shared.art_workGridImageWidth + 5) + ArtStyle.shared.art_workGridImageWidth/2.0;
        
        
        var point: CGPoint = CGPoint()
        point.x = CGFloat(centerX)
        point.y = CGFloat(centerY)
        return point
    }
    
    func configImageGridView(work:ArtRequirement?) -> Void {
        for  view in imageArea.subviews {
            view.removeFromSuperview()
        }
        
        
        if work?.imgs?.count == 0 {
            imageArea.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(0)
                make.left.equalTo(self.contentView)
                make.top.equalTo(contentLabel.snp.bottom).offset(10)
            })
            return
        }
        
        for index in 0...work!.imgs!.count-1 {
            let paintImage = ArtImageView()
            paintImage.isUserInteractionEnabled = true
            
            paintImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ArtWorkCell.imageDidTap(gesture:))))
            paintImage.tag = 10000+index
            let image:[String:AnyObject] = work?.imgs![index] as! [String : AnyObject]
            paintImage.art_setImageWithURL(imageURL: image["imgurl"] as? String)
            var imageSize = CGSize()
            imageSize.width = CGFloat(ArtStyle.shared.art_workGridImageWidth)
            imageSize.height = CGFloat(ArtStyle.shared.art_workGridImageWidth)
            paintImage.frame.size = imageSize
            paintImage.center = calculateImageCenterAtIndex(index: UInt(index))
            imageArea.addSubview(paintImage)
            
        }
        
        //设置imageArea
        let row = (work?.imgs?.count)!/3
        let column = (work?.imgs?.count)!%3
        let height = (ArtStyle.shared.art_workGridImageWidth + 5) * (Float(row) + Float(column == 0 ? 0 : 1))
        imageArea.snp.remakeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.height.equalTo(height)
        }
        
    }
    
    
    func configRequirementCell(requrement:ArtRequirementList) -> Void {
        if let content = requrement.requirement?.text {
            self.contentLabel.text = content
        }
        self.purposeLabel.text = "想找: ".appending((requrement.requirement?.target)!)
        if (requrement.requirement?.budget == 0) {
            self.priceLabel.text = "预算: ".appending("面议")
        } else {
            self.priceLabel.text = "预算: ".appending("\(String(describing: requrement.requirement!.budget!))")
        }
        
        
        if (requrement.requirement?.last_modified_time?.characters.count)! > 0 {
            
            if let time = Int64((requrement.requirement?.last_modified_time)!) {
                self.timeLabel.text = NSNumber(value: time).timestampString()
            }
            
        }
        self.numberLabel.text = "需求编号: ".appending((requrement.requirement?.orderno)!)
        
        configImageGridView(work: requrement.requirement)
    }
    
    
    public class func cellHeight(work:ArtRequirementList) -> CGFloat {
        
        var height:CGFloat = 0.0
        
        if (work.requirement?.text?.characters.count)! > 0 {
            height += CGFloat((work.requirement?.text?.getTextHeigh(font: UIFont.systemFont(ofSize: 15), width: CGFloat(SCREEN_W-20)))!)
        }
        
        if (work.requirement?.imgs?.count)! > 0 {
            let row = (work.requirement?.imgs?.count)!/3
            let column = (work.requirement?.imgs?.count)!%3
             height += CGFloat(ArtStyle.shared.art_workGridImageWidth + 5) * CGFloat(Float(row) + Float(column == 0 ? 0 : 1))

        } else {
            height += 10
        }
        
        height += 55
        height += 37
        
        height+=10
        return height
    }
    
}
