//
//  ArtScrollTab.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/25.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

enum EArtScrollTabItemShowType:Int {
    case Automatic = 1
    case Divide
}

//error: 'weak' cannot be applied to non-class type 'ArtScrollTabDelegate'
/**
    1.将protocol声明为Objective - C的，通过在protocol前面加@objc关键字来实现，这样就只能由class来遵守了，代码大致如下：
    2.在protocol的声明后面加上class，这样可以为编译器显式的指名这个protocol只能由class来遵守，代码大致如下:
 */
@objc protocol ArtScrollTabDelegate {
    
    @objc optional func artScrollTabHeight(scrollTab:ArtScrollTab) -> CGFloat
    @objc optional func artScrollTabIndicatorBottomMargin() -> CGFloat
    @objc optional func artScrollTabItemShowType(scrollTab:ArtScrollTab) -> Int
    @objc optional func artScrollTabItemControlLimitWidth(scrollTab:ArtScrollTab) -> CGFloat
    @objc optional func artScrollTabItemOffset(scrollTab:ArtScrollTab) -> CGFloat
    @objc optional func artScrollTabItemNormalColor(scrollTab:ArtScrollTab) -> UIColor
    @objc optional func artScrollTabItemSelectedColorColor(scrollTab:ArtScrollTab) -> UIColor
    @objc optional func artScrollTabIndicatorViewHidden() -> Bool
}

class ArtScrollTab: UIView {

    //MARK - Properities
    var tabItems = Array<ArtScrollTabDelegate>()
    var selectedColor:UIColor?
    var currentIndex:Int = 0
    
    weak var delegate:ArtScrollTabDelegate?

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTabBarItems(items:Array<ArtScrollTabDelegate>) -> Void {
        setTabBarItems(items: items, index: 0)
    }
    
    func setTabBarItems(items:Array<ArtScrollTabDelegate>,index:Int) -> Void {
        tabItems = items
        constructItemControlsIndex(index: index)
    }
    
    func constructItemControlsIndex(index:Int) -> Void {
        currentIndex = index
        guard tabItems.count > 0 else {
            return
        }
        
        var showType:EArtScrollTabItemShowType = EArtScrollTabItemShowType.Automatic
        if let show = self.delegate?.artScrollTabItemShowType?(scrollTab: self) {
            showType = EArtScrollTabItemShowType(rawValue: show)!
        }
        
        var itemOffset:CGFloat = 0.0
        if let offset = self.delegate?.artScrollTabItemOffset?(scrollTab: self) {
            itemOffset = offset
        }
        

        if itemOffset > CGFloat(0.1) {
            self.flowLayout.sectionInset = UIEdgeInsetsMake(0, itemOffset, 0, itemOffset)
        } else {
            self.flowLayout.sectionInset = UIEdgeInsetsMake(0, ArtStyle.shared.art_scrollTabMargin, 0, 0)
        }
        
        switch showType {
        case .Automatic:
            constructScrollControls()
            break
        case .Divide:
        
            let totalWidth = caculateTotalWidth()
            if totalWidth >= itemControlLimitWidth() {
                self.flowLayout.sectionInset = UIEdgeInsetsMake(0, ArtStyle.shared.art_scrollTabMargin, 0, 0)
                constructScrollControls()
            } else {
                let width = (itemControlLimitWidth() - totalWidth)/CGFloat(tabItems.count+1)
                self.flowLayout.sectionInset = UIEdgeInsetsMake(0, itemOffset+width, 0, itemOffset+width)
                self.flowLayout.minimumLineSpacing =  width
                self.flowLayout.minimumInteritemSpacing = width
                constructScrollControls()
            }
            break
        }
        
        self.flowLayout.prepare()
        self.collectionView.reloadData()
        let indexFrame = (tabItems[index] as? ArtScrollTabItem)?.tabFrame
        self.indicatorView.frame = indicatorViewFrameForItemFrame(frame: indexFrame!)
    }
    
    
    
    func constructScrollControls() -> Void {
        
    }
    
    func caculateTotalWidth() -> CGFloat {
        var totalWidth:CGFloat = 0
        for item  in tabItems {
            let size = titleSize(title: (item as! ArtScrollTabItem).tabTitle!)
            totalWidth += size.width
        }
        
        return totalWidth
    }
    
    func titleSize(title:String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 16)
        let width: CGFloat = CGFloat(title.getTexWidth(font: font, height: CGFloat(MAXFLOAT)))
        let height: CGFloat = CGFloat(title.getTextHeigh(font: font, width: CGFloat(MAXFLOAT)))
        return CGSize(width: width, height: height)
    }
    
    
    func itemControlLimitWidth() -> CGFloat {
        if let width = self.delegate?.artScrollTabItemControlLimitWidth?(scrollTab: self) {
            return width
        }
        return self.frame.size.width
    }
    
    func indicatorViewFrameForItemFrame(frame:CGRect) -> CGRect {
        let x = frame.origin.x - 2.0
        let height:CGFloat = 2.0
        let y = frame.origin.y + frame.size.height - CGFloat(height)
        let width = frame.size.width + 4.0
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    //MARK: - LAZY LOAD
    lazy var collectionView:UICollectionView = {
        let tempCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        return tempCollectionView
    }()
    
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
    
        let tempLayout = UICollectionViewFlowLayout()
        tempLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        tempLayout.minimumLineSpacing = ArtStyle.shared.art_scrollTabMargin
        tempLayout.minimumInteritemSpacing = ArtStyle.shared.art_scrollTabMargin
        return tempLayout
    }()
    
    lazy var indicatorView:UIView = {
        let tempIndicator = UIView()
        return tempIndicator
    }()
    
}


extension ArtScrollTab: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}


extension ArtScrollTab: ArtScrollTabDelegate {
    
    func artScrollTabHeight(scrollTab:ArtScrollTab) -> CGFloat {
        return 44
    }
    func artScrollTabIndicatorBottomMargin() -> CGFloat {
        return 3
    }
    func artScrollTabItemShowType(scrollTab:ArtScrollTab) -> EArtScrollTabItemShowType {
        return EArtScrollTabItemShowType.Automatic
    }
    func artScrollTabItemControlLimitWidth(scrollTab:ArtScrollTab) -> CGFloat {
        return 80
    }
    func artScrollTabItemOffset(scrollTab:ArtScrollTab) -> CGFloat {
        return 40
    }
    func artScrollTabItemNormalColor(scrollTab:ArtScrollTab) -> UIColor {
        return UIColor.gray
    }
    func artScrollTabItemSelectedColorColor(scrollTab:ArtScrollTab) -> UIColor {
        return UIColor.red
    }
    func artScrollTabIndicatorViewHidden() -> Bool {
        return false
    }
}







