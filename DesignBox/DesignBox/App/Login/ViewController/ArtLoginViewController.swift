//
//  ArtLoginViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtLoginViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    
    
    
    
    //MARK - 登录相关操作
    @IBAction func backDidClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mobileClearDidClear(_ sender: UIButton) {
        self.mobileTextField.text = ""
    }

    @IBAction func pwdVisibleDidClick(_ sender: UIButton) {
        sender.isSelected = true
        self.pwdTextField.isSecureTextEntry = sender.isSelected
    }
    
    @IBAction func loginDidClick(_ sender: UIButton) {
        let operation = ArtUserOperation()
        operation.mobile = self.mobileTextField.text
        operation.passwd = self.pwdTextField.text
        ArtUserService.shared.loginWithUserOperation(operation: operation) { (aError) in
            if (aError == nil) {
                //成功
                self.dismiss(animated: true, completion: nil)
                return
            }
            
            print(aError!)
        }
    }
    
    @IBAction func forgetPwdDidClick(_ sender: UIButton) {
    }
    
    @IBAction func RegisterDidClick(_ sender: UIButton) {
    }
    
    
    @IBAction func qqLoginDidClick(_ sender: UIButton) {
        UMSocialDataManager.default().clearAllAuthorUserInfo()
        UMSocialManager.default().getUserInfo(with: .QQ, currentViewController: self, completion: { (result, userError) in
            if (result != nil) {
                //获取用户的个人信息
                let userInfo = result as! UMSocialUserInfoResponse
                
                let operation = ArtUserOperation()
                operation.nickname = userInfo.name
                operation.gender = userInfo.gender
                operation.icon = userInfo.iconurl
                operation.openid = userInfo.openid
                operation.platform = "QQ"
                
                ArtUserService.shared.loginWithUserOperation(operation: operation, completed: { (aError) in
                    if (aError == nil) {
                        //成功
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                    
                    print(aError!)
                })
                
            }else
            {
                debugPrint("--",userError.debugDescription)
            }
        })
    }
    
    @IBAction func weChatLoginDidClick(_ sender: UIButton) {
        UMSocialDataManager.default().clearAllAuthorUserInfo()
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self, completion: { (result, userError) in
            if (result != nil) {
                //获取用户的个人信息
                let userInfo = result as! UMSocialUserInfoResponse
                
                let operation = ArtUserOperation()
                operation.nickname = userInfo.name
                operation.gender = userInfo.gender
                operation.icon = userInfo.iconurl
                operation.openid = userInfo.openid
                operation.platform = "QQ"
                
                ArtUserService.shared.loginWithUserOperation(operation: operation, completed: { (aError) in
                    if (aError == nil) {
                        //成功
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                    
                    print(aError!)
                })
                
            }else
            {
                debugPrint("--",userError.debugDescription)
            }
        })
    }
    
    
    //MARK: 界面调整
    func buildUI() -> Void {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





extension ArtLoginViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    
    
    
}
