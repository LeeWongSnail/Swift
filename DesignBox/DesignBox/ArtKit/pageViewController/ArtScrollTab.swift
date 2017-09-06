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

class ArtScrollTab: UIView,ArtPageHeaderViewProtocol {

    //MARK - Properities
    var tabItems = Array<ArtScrollTabDelegate>()
    var selectedColor:UIColor?
    var curIndexDidChangeBlock:((_ index:Int) -> Void)?
    
    var currentIndex:Int = 0 {
        willSet
        {
            print("Will set an new value \(newValue) to currentIndex")
            

            
        }
       
        didSet
        {
            let newButFrame = (tabItems[currentIndex] as! ArtScrollTabItem).tabFrame
            if currentIndex == oldValue {
                self.collectionView.scrollToItem(at: IndexPath.init(row: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                return
            }
            
            let array = [IndexPath.init(row: oldValue, section: 0),IndexPath.init(row: currentIndex, section: 0)]
            
            self.collectionView.reloadItems(at: array)
            
            
            if self.indicatorView.isHidden {
                self.collectionView.scrollToItem(at: IndexPath.init(row: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                return
            }
            
            let frame = indicatorViewFrameForItemFrame(frame: newButFrame!)
            UIView.animate(withDuration: 0.2, animations: {
                
                self.indicatorView.center = CGPoint(x: ((newButFrame?.origin.x)!+(newButFrame?.size.width)! / 2.0), y: self.indicatorView.center.y)
                self.indicatorView.transform = CGAffineTransform(scaleX: frame.size.width/self.indicatorView.frame.size.width, y: 1.0);
            }) { (finish:Bool) in
                self.indicatorView.transform = CGAffineTransform.identity;
                self.indicatorView.frame = frame;
                self.collectionView.scrollToItem(at: NSIndexPath.init(item: self.currentIndex, section: 0) as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            }
            print("age filed changed form \(oldValue) to \(currentIndex)")
            
            
            if (curIndexDidChangeBlock != nil) {
                curIndexDidChangeBlock!(currentIndex)
            }
        }
    }
    
    weak var delegate:ArtScrollTabDelegate?

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.collectionView.addSubview(self.indicatorView)
        
        registerCells()
        
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
            self.flowLayout.sectionInset = UIEdgeInsetsMake(0,0, 0, 0)
        }
        
        switch showType {
        case .Automatic:
            constructScrollControls()
            break
        case .Divide:
        
            let totalWidth = caculateTotalWidth()
            if totalWidth >= itemControlLimitWidth() {
                self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
        let sectionInset = self.flowLayout.sectionInset
        let margin = self.flowLayout.minimumInteritemSpacing
        var lastx = sectionInset.left
        for item in tabItems {
            let size = titleSize(title: (item as! ArtScrollTabItem).tabTitle!)
            var height:CGFloat = 0
            if let h = self.delegate?.artScrollTabHeight?(scrollTab: self) {
                height = h
            }
            (item as! ArtScrollTabItem).tabFrame = CGRect(x: lastx, y: 0, width: size.width, height: height)
            lastx = lastx + size.width + margin
        }
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
        let width: CGFloat = CGFloat(title.getTexWidth(font: font, height: CGFloat(MAXFLOAT)))+10
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
        let x = frame.origin.x + 10.0
        let height:CGFloat = 2.0
        let y = frame.origin.y + frame.size.height - CGFloat(height)
        let width = frame.size.width - 20.0
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    //MARK: - LAZY LOAD
    lazy var collectionView:UICollectionView = {
        let tempCollectionView:UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 44), collectionViewLayout: self.flowLayout)
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.alwaysBounceHorizontal = true
        tempCollectionView.backgroundColor = UIColor.white
        return tempCollectionView
    }()
    
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
    
        let tempLayout = UICollectionViewFlowLayout()
        tempLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        tempLayout.itemSize = CGSize(width: 60, height: 44)
        tempLayout.minimumLineSpacing = 0;
        tempLayout.minimumInteritemSpacing = ArtStyle.shared.art_scrollTabMargin
        return tempLayout
    }()
    
    lazy var indicatorView:UIView = {
        let tempIndicator = UIView()
        tempIndicator.backgroundColor = UIColor.art_colorWithHexString(hexString: "FEE306")
        return tempIndicator
    }()
    
}


extension ArtScrollTab {
    
    func tabHeight() -> CGFloat {
        if let h = self.delegate?.artScrollTabHeight?(scrollTab: self) {
            return h
        }
        return 0
    }
    
}


extension ArtScrollTab: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func registerCells() -> Void {
        self.collectionView.register(ArtScrollTabCell.self, forCellWithReuseIdentifier: "ArtScrollTabCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tabItems.count > 0 ? 1 : 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtScrollTabCell", for: indexPath) as! ArtScrollTabCell
        
        if let item = (tabItems[indexPath.item]) as? ArtScrollTabItem {
            cell.titleLabel.text = item.tabTitle
            cell.tapBlock =  {(_ scrollTab:ArtScrollTabCell) -> (Void) in
                print(item)
                self.currentIndex = cell.tag - 10000
            }
        }
        cell.tag = 10000+indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = (tabItems[indexPath.item]) as? ArtScrollTabItem {
            if let size = item.tabFrame?.size {
                return size;
            }
        }
        
        return CGSize(width: 60, height: 44)
    }
    

    
}


class ArtScrollTabCell: UICollectionViewCell {
    
    typealias scrollTabDidTapBlock = (_ scrollTab:ArtScrollTabCell) -> Void
    var tapBlock:scrollTabDidTapBlock?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollTabDidTap() -> Void {
        if tapBlock != nil {
            tapBlock!(self)
        }
    }
    
    func buildUI() -> Void {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ArtScrollTabCell.scrollTabDidTap)))
    }
    
    
   public lazy var titleLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 17)
        tempLabel.textColor = UIColor.art_colorWithHexString(hexString: "333333")
        tempLabel.textAlignment = NSTextAlignment.center
        return tempLabel
    }()
    
}






