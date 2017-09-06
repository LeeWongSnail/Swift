//
//  ArtSingleImageController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/5.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtSingleImageController: UIViewController {

    var imageURL:String? {
        didSet {
            self.imageView.art_setImageWithURL(imageURL: self.imageURL)
        }
    }
    
    var imageDismissTapBlock:(() -> Void)?
    
    
    func imageDidTapBlock(sender:UITapGestureRecognizer) -> Void {
        if (imageDismissTapBlock != nil) {
            imageDismissTapBlock!()
        }
    }
    
    
    func buildUI() -> Void {
        
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ArtSingleImageController.imageDidTapBlock(sender:))))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var imageView = { () -> ArtImageView in 
        let imageView = ArtImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        return imageView
    }()
    

}
