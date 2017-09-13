//
//  ArtPublishWorkViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import DKImagePickerController

class ArtPublishWorkViewController: UIViewController {


    var publishImages: [UIImage] = Array()
    var imageCell: ArtPublishWorkImageCell?
    
    //MARK: -CUSTOM METHOD
    func backDidClick() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextStep() -> Void {
        
        if let image = self.publishImages.first {
            AliyunOSSService.shared.uploadImage(image: image)
        }
        
    }
    
    
    func caculateRowsForCount(count:Int) -> Int {
        
        if count <= 3 {
            return 1
        } else if (count <= 6) {
            return 2
        } else {
            return 3
        }
        
    }
    
    func handleRemoveImage(image:UIImage) -> Void {
        
        self.publishImages.remove(at: self.publishImages.index(of: image)!)
        
        if self.publishImages.count == 0 {
            
        }
        
        let row1 = self.caculateRowsForCount(count: (self.publishImages.count+2))
        let row2 = self.caculateRowsForCount(count: (self.publishImages.count)+1)
        
        if row1 != row2 {
            self.tableView.reloadData()
        }
        
    }
    
    func addImage(image:UIImage) -> Void {
        
        var width = image.size.width
        var height = image.size.height
        
        let maxW = SCREEN_W * image.scale
        if width * image.scale > maxW {
            height *= (maxW/(width * image.scale))
            width = maxW
        }
        
        self.publishImages.append(image)
        self.imageCell?.addImage(image: image)
        
        let row1 = self.caculateRowsForCount(count: (self.publishImages.count))
        let row2 = self.caculateRowsForCount(count: (self.publishImages.count)+1)

        if row1 != row2 {
            self.tableView.reloadData()
        }
        
    }
    
    
    func openImagePicker() -> Void {
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            for asset in assets {
                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                    if image != nil {
                        self.addImage(image: image!)
                    }
                })
            }
            
        }
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func registerCells() -> Void {
        tableView.register(UINib.init(nibName: "ArtPublishWorkTextCell", bundle: nil), forCellReuseIdentifier: "ArtPublishWorkTextCell")
        tableView.register(UINib.init(nibName: "ArtPublishWorkControlCell", bundle: nil), forCellReuseIdentifier: "ArtPublishWorkControlCell")
        tableView.register(ArtPublishWorkImageCell.self, forCellReuseIdentifier: "ArtPublishWorkImageCell")
    }
    
    //MARK: - LOAD VIEW
    func configNavItems() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.backDidClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.nextStep))
    }
    
    func buildUI() -> Void {
        registerCells()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        configNavItems()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var tableView = { () -> UITableView in 
        let tempTableView = UITableView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = nil
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tempTableView
    }()

}

extension ArtPublishWorkViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkTextCell") as! ArtPublishWorkTextCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkImageCell") as! ArtPublishWorkImageCell
            cell.addImageBtn?.addTarget(self, action: #selector(ArtPublishWorkViewController.openImagePicker), for: UIControlEvents.touchUpInside)
            self.imageCell = cell
            
            cell.removeImageBlock =  { (image) -> Void in
                self.handleRemoveImage(image: image)
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkControlCell") as! ArtPublishWorkControlCell
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return ArtPublishWorkTextCell.cellHeight()
            
        case 1:
            let height = ArtPublishWorkImageCell.rowHeight()
            return CGFloat(self.caculateRowsForCount(count: self.publishImages.count + 1)) * height + 10.0
        case 2:
            return 48
        default:
            return 0
        }
    }
    
}




