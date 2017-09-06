//
//  ArtBannerCellTableViewCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtBannerCell: UITableViewCell {

    var bannerList: ArtBannerList?
    var banners: [ArtBanner]?
    var timer: Timer?
    
    func configBannerCell(bannerList:ArtBannerList) -> Void {
        guard (bannerList.banners?.count)! > 0 else {
            return
        }
        
        self.bannerList = bannerList
        self.banners = bannerList.banners
        
        self.banners?.insert((bannerList.banners?.last)!, at: 0)
        self.banners?.append((bannerList.banners?.first)!)
        
        self.pageControl.numberOfPages = (self.bannerList?.banners?.count)!
        self.pageControl.currentPage = (self.bannerList?.currentPage)!
        
        for view in self.scrollView.subviews {
            if view.isKind(of: ArtImageView.self) {
                view.removeFromSuperview()
            }
        }
        var index = -1
        
        for banner in self.banners! {
            index += 1
            let imageView = ArtImageView()
            imageView.contentMode = UIViewContentMode.scaleToFill
            imageView.backgroundColor = UIColor.art_backgroundColor()
            imageView.art_setImageWithURL(imageURL: banner.imgurl)
            imageView.frame = CGRect(x: CGFloat(index)*SCREEN_W, y: 0, width: SCREEN_W, height: ArtBannerCell.bannerHeight())
            imageView.tag = 10000+index
            imageView.isUserInteractionEnabled = true
            
            if (index > 0) && (index < (self.banners?.count)!-1) {
                imageView.tag = 10000+index-1
            }
            
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_W*CGFloat((self.banners?.count)!), height: ArtBannerCell.bannerHeight())
        
        let scroll = banners?.count == 1
        self.scrollView.isScrollEnabled = !scroll
        if scroll {
            removeTimer()
        } else {
            addTimer()
        }
    }
    
    func buildUI() -> Void {
        self.contentView.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        self.scrollView.setContentOffset(CGPoint.init(x: SCREEN_W, y: 0), animated: false)
        self.contentView.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.scrollView.snp.bottom).offset(-5)
            make.right.equalTo(self.contentView.snp.right).offset(-11)
            make.height.equalTo(20)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func bannerHeight() -> CGFloat {
        return SCREEN_W * 234.0/750.0
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: LAZY
    lazy var scrollView = { () -> UIScrollView in 
        let tempScrollView = UIScrollView()
        tempScrollView.showsVerticalScrollIndicator = false
        tempScrollView.showsHorizontalScrollIndicator = false
        tempScrollView.isPagingEnabled = true
        tempScrollView.bounces = false
        tempScrollView.isUserInteractionEnabled = true
        tempScrollView.delegate = self;
        return tempScrollView
    }()
    
    lazy var pageControl = { () -> UIPageControl in 
        let pageControl = UIPageControl()
        
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.art_mainColor()
        pageControl.hidesForSinglePage = true
        
        return pageControl
    }()

}





extension ArtBannerCell: UIScrollViewDelegate {
    
    func nextImage() -> Void {
        self.pageControl.currentPage = (Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width))
        scrollToPage(page: self.pageControl.currentPage+1, animated: true)
    }
    
    
    func setContentOffset(offset:CGPoint,completion: (() -> Void)?) -> Void {
        UIView.animate(withDuration: 0.25, animations: { 
            self.scrollView.contentOffset = offset
        }) { (finish) in
            if completion != nil {
                completion!()
            }
        }
    }
    
    func scrollToPage(page:Int,animated:Bool) -> Void {
        var scrollPage = page
        let offset = CGPoint.init(x: CGFloat(page)*self.scrollView.frame.size.width, y: 0)
        if scrollPage == (self.banners?.count)! - 1 {
            scrollPage = 1
            self.setContentOffset(offset: offset, completion: { 
                self.scrollToPage(page: scrollPage, animated: false)
            })
        }
        
        if scrollPage == 0 {
            scrollPage = (self.banners?.count)!-2
            self.setContentOffset(offset: offset, completion: { 
                self.scrollToPage(page: scrollPage, animated: false)
            })
            
            return
        }
        
        self.bannerList?.currentPage = scrollPage-1
        self.pageControl.currentPage = scrollPage-1
        self.scrollView.setContentOffset(offset, animated: animated)
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = (Int(scrollView.contentOffset.x / scrollView.frame.size.width))
        self.scrollToPage(page: self.pageControl.currentPage, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    
    
    func addTimer() -> Void {

        if self.scrollView.contentOffset.x == 0 {
            self.scrollToPage(page: 1, animated: false)
        }
        
        if self.timer != nil {
            return
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ArtBannerCell.nextImage), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
    }
    
    
    func removeTimer() -> Void {
        
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        
    }
    

}
