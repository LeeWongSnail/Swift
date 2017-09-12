//
//  ArtPublishWorkImageCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

let kTopAndBottomMargin:CGFloat = 15;
let kLeftPadding:CGFloat = 17.5; //左右边缘间距
let kImagePadding:CGFloat = 12.0; //图片之间的间距
var kImageWidth = ArtStyle.shared.art_CGFloatPixelRound(value: (SCREEN_W - 12.0 * 2.0 - 12.0 * 3.0) / 4)


class ArtPublishWorkImageCell: UITableViewCell {


    var addImageBtn: UIButton?
    var imagesBtns: [UIButton]?
    var removeImageBlock: ((_ image:UIImage) -> Void)?
    
    
    //MARK: Public Method
    func addImage(image:UIImage) -> Void {
        
        if (self.imagesBtns?.count)! >= 9 {
            return
        }
        
        let btn = createImageBtn(image: image, canRemove: true)
        if self.imagesBtns?.count == 8 {
            self.addImageBtn?.isHidden = true
            var idx = 0
            for btn in self.imagesBtns! {
                btn.center = self.caculateCenterForIndex(index: idx)
                idx += 1
            }
        }
        
        btn.center = self.caculateCenterForIndex(index: (self.imagesBtns?.count)!)
        if (self.imagesBtns?.count)! < 8 {
            self.addImageBtn?.center = self.caculateCenterForIndex(index: (self.imagesBtns?.count)!+1)
        }
        
        self.contentView.addSubview(btn)
        self.imagesBtns?.append(btn)
    }
    
    
    func setImages(images:[UIImage]?) -> Void {
        
        if self.imagesBtns != nil {
            for btn in self.imagesBtns! {
                btn.removeFromSuperview()
            }
        }
        
        self.imagesBtns?.removeAll()
        
        for image in images! {
            self.addImage(image: image)
        }
        
    }
    
    
    //MARK: Calculate
    func caculateCenterForIndex(index:Int) -> CGPoint {
        
        let xMargin = CGFloat(index%4)*(kImagePadding + kImageWidth)
        let x = xMargin + (kLeftPadding + kImageWidth/2)
        
        let yMargin = CGFloat(index / 4)*(kTopAndBottomMargin + kImageWidth)
        let y = yMargin + (kTopAndBottomMargin + kImageWidth/2.0)
        
        return CGPoint(x:x,y:y)
    }
    
    
    
    //MARK: BUILD UI
    func createImageBtn(image:UIImage,canRemove:Bool) -> UIButton {
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(image, for: UIControlState.normal)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        btn.imageView?.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: kImageWidth, height: kImageWidth)
        
        
        if canRemove {
          let removeBtn = UIButton(type: UIButtonType.custom)
            removeBtn.setImage(UIImage.init(named: ""), for: UIControlState.normal)
            btn.addSubview(removeBtn)
            removeBtn.addTarget(self, action: #selector(ArtPublishWorkImageCell.removeImage(sender:)), for: UIControlEvents.touchUpInside)
            removeBtn.snp.makeConstraints({ (make) in
                make.width.height.equalTo(22)
                make.top.equalTo(btn.snp.top).offset(5)
                make.right.equalTo(btn.snp.right).offset(-5)
            })
        }
        
        return btn
    }
    
    func removeImage(sender:UIView) -> Void {
        self.removeImageBtn(btn: sender.superview!)
    }
    
    
    func removeImageBtn(btn:UIView) -> Void {
        if (self.addImageBtn?.isHidden)! {
            self.addImageBtn?.alpha = 0
            self.addImageBtn?.isHidden = false
        }
        
        self.imagesBtns?.remove(at: (self.imagesBtns?.index(of: btn as! UIButton))!)
        UIView.animate(withDuration: 0.2, animations: { 
            btn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
            self.addImageBtn?.alpha = 1
            
            var index = 0
            for btn in self.imagesBtns! {
                btn.center = self.caculateCenterForIndex(index: index)
                index+=1
            }
            self.addImageBtn?.center = self.caculateCenterForIndex(index: (self.imagesBtns?.count)!)
            
        }) { (finish) in
            btn.removeFromSuperview()
            self.removeImageBlock!((btn as! UIButton).image(for: UIControlState.normal)!)
        }
        
    }
    
    
    func buildUI() -> Void {
        self.contentView.addSubview(self.sepLine)
        self.sepLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
        
        self.addImageBtn = createImageBtn(image: UIImage.init(named: "icon_add_pic")!, canRemove: false)
        self.addImageBtn?.center = self.caculateCenterForIndex(index: 0)
        self.contentView.addSubview(self.addImageBtn!)
    }
    
    
    class func rowHeight() -> CGFloat {
        return  kTopAndBottomMargin + kImageWidth
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.clipsToBounds = true
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
