//
//  ArtRequirementCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtRequirementCell: UITableViewCell {

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
    }
    
    
    public class func cellHeight(work:ArtRequirementList) -> CGFloat {
        
        var height:CGFloat = 0.0
        
        if (work.requirement?.text?.characters.count)! > 0 {
            height += CGFloat((work.requirement?.text?.getTextHeigh(font: UIFont.systemFont(ofSize: 15), width: CGFloat(SCREEN_W-20)))!)
        }
        
        height += 55
        height += 37
        
        height+=10
        return height
    }
    
}
