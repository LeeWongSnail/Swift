//
//  ArtLabel.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ActiveLabel
class ArtLabel: ActiveLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
            self.customize { label in
                label.numberOfLines = 0
                label.enabledTypes = [.mention, .hashtag, .url]
                label.text = "This is a post with #multiple #hashtags and a @userhandle."
                label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
                label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
                label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
                label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
                label.handleMentionTap { _ in self.handleMentionTap() }
                label.handleHashtagTap { _ in self.handleHashtagTap() }
                label.handleURLTap { _ in self.handleURLTap() }
            }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension ArtLabel {
    
    func handleMentionTap() -> Void {
        print("handleMentionTap")
    }
    
    func handleHashtagTap() -> Void {
        print("handleHashtagTap")
    }
    
    func handleURLTap() -> Void {
        print("handleURLTap")
    }
    
}
