//
//  signUpViewController.swift
//  playTogether
//
//  Created by 马腾 on 16/6/13.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit
import Foundation

//public let NavigationHH: CGFloat = 64
//public let AppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
//public let AppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
//public let MainBound: CGRect = UIScreen.mainScreen().bounds
//
//public let SD_UserLogin_Notification = "SD_UserLogin_Notification"
//public let SD_UserDefaults_Account = "SD_UserDefaults_Account"
//public let SD_UserDefaults_Password = "SD_UserDefaults_Password"

class signUpViewController: UIViewController, UIScrollViewDelegate {
    
    //var user: AVUser?
   // let user: AVUser
    var bottomView: UIView!
    var backScrollView: UIScrollView!
    var topView: UIView!
    var phoneTextField: UITextField!
    var checkCodeTextField: UITextField!
    var psdTextFieldConfirm: UITextField!
    var loginImageView: UIImageView!
    var quickLoginBtn: UIButton!
    var forgetPwdImageView: UIImageView!
    var registerImageView: UIImageView!
    let textCoclor: UIColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
    let loginW: CGFloat = 250
   //时间返回按钮
    var sendButton: UIButton!
    
    var countdownTimer: NSTimer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            sendButton.setTitle("验证码已发送(\(newValue)秒后重新获取)", forState: .Normal)
            
            if newValue <= 0 {
                sendButton.setTitle("重新获取验证码", forState: .Normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                
                sendButton.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                sendButton.backgroundColor = UIColor.redColor()
            }
            
            sendButton.enabled = !newValue
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "注册"
        view.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        //添加scrollView
        addScrollView()
        // 添加手机文本框和密码文本框
        addTextField()
        // 添加注册View
        addLoginImageView()
        // 添加键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrameNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
  
    
  
    
    func addScrollView() {
        backScrollView = UIScrollView(frame: view.bounds)
        backScrollView.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        backScrollView.alwaysBounceVertical = true
        let tap = UITapGestureRecognizer(target: self, action: "backScrollViewTap")
        backScrollView.addGestureRecognizer(tap)
        view.addSubview(backScrollView)
    }
    
    func addLoginImageView() {
        let loginH: CGFloat = 50
        loginImageView = UIImageView(frame: CGRectMake((AppWidth - loginW) * 0.5, CGRectGetMaxY(topView!.frame) + 10, loginW, loginH))
        loginImageView.userInteractionEnabled = true
        loginImageView.image = UIImage(named: "signin_1")
        
        let loginLabel = UILabel(frame: loginImageView.bounds)
        loginLabel.text = "注 册"
        loginLabel.textAlignment = .Center
        loginLabel.textColor = textCoclor
        loginLabel.font = UIFont.systemFontOfSize(22)
        loginImageView.addSubview(loginLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "loginClick:")
        loginImageView.addGestureRecognizer(tap)
        
        backScrollView.addSubview(loginImageView)
    }
    
    func addTextField() {
        let textH: CGFloat = 55
        let leftMargin: CGFloat = 10
        let alphaV: CGFloat = 0.2
        topView = UIView(frame: CGRectMake(0, 20, AppWidth, textH * 3))
        topView?.backgroundColor = UIColor.whiteColor()
        backScrollView.addSubview(topView!)
        
        let line1 = UIView(frame: CGRectMake(0, 0, AppWidth, 1))
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = alphaV
        topView!.addSubview(line1)
        
        phoneTextField = UITextField()
        phoneTextField?.keyboardType = UIKeyboardType.NumberPad
        addTextFieldToTopViewWiht(phoneTextField!, frame: CGRectMake(leftMargin, 1, AppWidth - leftMargin, textH - 1), placeholder: "请输入手机号")
        
        
        let line2 = UIView(frame: CGRectMake(0, textH, AppWidth, 1))
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = alphaV
        topView!.addSubview(line2)
        
//        let line3 = UIView(frame: CGRectMake(0, textH * 2, AppWidth, 1))
//        line3.backgroundColor = UIColor.grayColor()
//        line3.alpha = alphaV
//        topView!.addSubview(line3)
        
        checkCodeTextField = UITextField()
        addTextFieldToTopViewWiht(checkCodeTextField!, frame: CGRectMake(leftMargin, textH + 1, AppWidth - leftMargin, textH - 1), placeholder: "验证码")
        
        sendButton = UIButton()
        sendButton.frame = CGRect(x: 5, y: textH * 2 + 20, width: AppWidth - leftMargin, height: textH - 1)
        sendButton.backgroundColor = UIColor.redColor()
        sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendButton.setTitle("获取验证码", forState: .Normal)
        sendButton.addTarget(self, action: "sendButtonClick:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(sendButton)
        
        
        
        
//        psdTextFieldConfirm = UITextField()
//        addTextFieldToTopViewWiht(psdTextFieldConfirm!, frame: CGRectMake(leftMargin, textH * 2 + 1, AppWidth - leftMargin, textH - 1), placeholder: "重复密码")
    }
    
    func sendButtonClick(sender: UIButton) {
        isCounting = true
        let user = AVUser()
        
        //user.username = self.randomString(6)
        user.mobilePhoneNumber = phoneTextField.text
    //    user.mobilePhoneNumber = phoneTextField.text!
//        AVUser.requestMobilePhoneVerify(phoneTextField.text) { (succeed, error) in
//           if succeed {
//                print("succeed")
//           }
//        }
       
        AVOSCloud.requestSmsCodeWithPhoneNumber(user.mobilePhoneNumber) { (succeed, error) in
            if succeed {
                print("succeed")
            }
        }
        
    }
    
    func updateTime(timer: NSTimer) {
        remainingSeconds -= 1
    }
    

    
    func addTextFieldToTopViewWiht(textField: UITextField ,frame: CGRect, placeholder: String) {
        textField.frame = frame
        textField.autocorrectionType = .No
        textField.clearButtonMode = .Always
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = placeholder
        topView!.addSubview(textField)
    }
    
  
    
    

    
    func loginClick(sender: UIButton) {
       
        AVUser.signUpOrLoginWithMobilePhoneNumberInBackground(phoneTextField.text, smsCode: checkCodeTextField.text) { (succeed, error) in
            if (error != nil) {
            print("出错了")
            } else {
               //AVOSCloud.verifySmsCode(self.checkCodeTextField.text, mobilePhoneNumber: self.phoneTextField.text, callback: { (succeed, error) in
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    //需要长时间处理的代码
                    dispatch_async(dispatch_get_main_queue(), {
                        //需要主线程执行的代码
                
                        let toConfirmPsd = confirmPsdViewController()
                        toConfirmPsd.mobilePhoneNum = self.phoneTextField.text
                        self.hidesBottomBarWhenPushed = true
                        //self.presentViewController(plantGrassVC, animated: true, completion: nil)
                        self.navigationController!.pushViewController(toConfirmPsd, animated:true)
                        //self.hidesBottomBarWhenPushed = false
                        
                    })
                })
                
                
                

        
           }
//            let toConfirmPsd = confirmPsdViewController()
//                            self.hidesBottomBarWhenPushed = true
//                            //self.presentViewController(plantGrassVC, animated: true, completion: nil)
//                            self.navigationController!.pushViewController(toConfirmPsd, animated:true)
//                            //self.hidesBottomBarWhenPushed = false
            
            
      }
       
    }
    
   
    
    func keyboardWillChangeFrameNotification(note: NSNotification) {
        // TODO 添加键盘弹出的事件
        let userinfo = note.userInfo!
        let rect = userinfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        var boardH = AppHeight - rect.origin.y
        if boardH > 0 {
            boardH = boardH + NavigationHH
        }
        backScrollView.contentSize = CGSizeMake(0, view.frame.size.height + boardH)
    }
    
    func backScrollViewTap() {
        view.endEditing(true)
    }
}




// UIColor的扩展
//extension UIColor {
//    class func colorWith(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
//        let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
//        return color
//    }
//    
//}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


