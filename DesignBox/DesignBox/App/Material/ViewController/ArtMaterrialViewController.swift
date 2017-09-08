//
//  ArtMaterrialViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/7.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtMaterrialViewController: UIViewController {

    var dataCount = 20
    var columnCount = 2
    
    var topics:[Any]?
    var materialList: [ArtMaterial]?
    
    func fetchMaterialList() -> Void {
        let cmd = ArtCommandMaterial()
        cmd.count = "20"
        cmd.pageno = 0
        
        cmd.fetchMaterial(success: { (material,topics) in
            self.topics = topics
            self.materialList = material
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    
    
    func buildUI() -> Void {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "ArtMaterialHeaderView", bundle: nil), forSupplementaryViewOfKind: kSupplementaryViewKindHeader, withReuseIdentifier: "ArtMaterialHeaderView")
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchMaterialList()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var collectionView = { () -> UICollectionView in
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = UIColor.white
        
        

        
        return tempCollectionView
    }()


    lazy var layout = { () -> RMCollectionViewLayout in 
        let tempLayout = RMCollectionViewLayout()
        tempLayout.isLoadHeader = true       // 允许载入Header，false时，设置高度无效
        tempLayout.defaultHeaderHeight = ArtMaterialHeaderView.materialHeaderHeight()  // header高度
        // 设置代理
        tempLayout.delegate = self
        // 设置滚动方向 默认垂直
        tempLayout.scrollDirection = .vertical
        /** 列数 用于垂直滚动*/
        tempLayout.defaultColumnCount = 2
        /** 列间距 */
        tempLayout.defaultColumnMargin = 10.0
        return tempLayout
    }()
    
}


extension ArtMaterrialViewController: UICollectionViewDelegate,UICollectionViewDataSource,RMCollectionViewLayoutDelegate {
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor    = [UIColor.blue, UIColor.red, UIColor.yellow][indexPath.row % 3]
        cell.contentView.clipsToBounds      = true
        cell.contentView.layer.cornerRadius = 5
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == kSupplementaryViewKindHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ArtMaterialHeaderView", for: indexPath) as! ArtMaterialHeaderView
            if let topic = self.topics {
                header.configHeader(topics: topic)
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_W, height: 100)
    }
    
    /** 根据宽度，获取对应的比例的高度 用于垂直滚动 */
    func collectionViewLayout(_ collectionViewLayout: RMCollectionViewLayout, heightForItemAt index: Int, itemWidth width:CGFloat) -> CGFloat {
        let height = 200 + arc4random() % 100
        return CGFloat(height)
    }
    
    /** 根据高度，获取对应的比例的宽度 用于水平滚动 */
    func collectionViewLayout(_ collectionViewLayout: RMCollectionViewLayout, widthForItemAt index: Int, itemHeight height:CGFloat) -> CGFloat {
        return 0
    }
}
