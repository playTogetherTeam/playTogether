//
//  LoginViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/20.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  登陆控制器

import UIKit
import Foundation

public let NavigationHH: CGFloat = 64
public let AppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let AppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let MainBound: CGRect = UIScreen.mainScreen().bounds

public let SD_UserLogin_Notification = "SD_UserLogin_Notification"
public let SD_UserDefaults_Account = "SD_UserDefaults_Account"
public let SD_UserDefaults_Password = "SD_UserDefaults_Password"

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    var bottomView: UIView!
    var backScrollView: UIScrollView!
    var topView: UIView!
    var phoneTextField: UITextField!
    var psdTextField: UITextField!
    var loginImageView: UIImageView!
    var quickLoginBtn: UIButton!
    var forgetPwdImageView: UIImageView!
    var registerImageView: UIImageView!
    let textCoclor: UIColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
    let loginW: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "登录"
        view.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        //添加scrollView
        addScrollView()
        // 添加手机文本框和密码文本框
        addTextField()
        // 添加登录View
        addLoginImageView()
        // 添加快捷登录按钮
        addQuictLoginBtn()
        // 添加底部忘记密码和注册view
        addBottomView()
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
        loginLabel.text = "登  录"
        loginLabel.textAlignment = .Center
        loginLabel.textColor = textCoclor
        loginLabel.font = UIFont.systemFontOfSize(22)
        loginImageView.addSubview(loginLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "loginClick")
        loginImageView.addGestureRecognizer(tap)
        
        backScrollView.addSubview(loginImageView)
    }
    
    func addTextField() {
        let textH: CGFloat = 55
        let leftMargin: CGFloat = 10
        let alphaV: CGFloat = 0.2
        topView = UIView(frame: CGRectMake(0, 20, AppWidth, textH * 2))
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
        
        psdTextField = UITextField()
        addTextFieldToTopViewWiht(psdTextField!, frame: CGRectMake(leftMargin, textH + 1, AppWidth - leftMargin, textH - 1), placeholder: "密码")
    }
    
    func addQuictLoginBtn() {
        quickLoginBtn = UIButton()
        quickLoginBtn.setTitle("无账号快捷登录", forState: .Normal)
        quickLoginBtn.titleLabel?.sizeToFit()
        quickLoginBtn.contentMode = .Right
        let quickW: CGFloat = quickLoginBtn.titleLabel!.frame.size.width
        quickLoginBtn.frame = CGRectMake(AppWidth - quickW - 10, CGRectGetMaxY(loginImageView.frame) + 10, quickW, 30)
        quickLoginBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        quickLoginBtn.addTarget(self, action: "quickLoginClick", forControlEvents: .TouchUpInside)
        quickLoginBtn.setTitle("无账号快捷登录", forState: .Normal)
        quickLoginBtn.setTitleColor(textCoclor, forState: .Normal)
        quickLoginBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        backScrollView.addSubview(quickLoginBtn)
    }
    
    func addTextFieldToTopViewWiht(textField: UITextField ,frame: CGRect, placeholder: String) {
        textField.frame = frame
        textField.autocorrectionType = .No
        textField.clearButtonMode = .Always
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = placeholder
        topView!.addSubview(textField)
    }
    
    func addBottomView() {
        let forgetPwdImageViewH: CGFloat = 45
        
        bottomView = UIView(frame: CGRectMake((AppWidth - loginW) * 0.5, AppHeight - forgetPwdImageViewH - 10 - 64, loginW, forgetPwdImageViewH))
        bottomView.backgroundColor = UIColor.clearColor()
        backScrollView.addSubview(bottomView)
        
        forgetPwdImageView = UIImageView()
        addBottomViewWithImageView(forgetPwdImageView, tag: 10, frame: CGRectMake(0, 0, loginW * 0.5, forgetPwdImageViewH), imageName: "c1_1", title: "忘记密码")
        
        registerImageView = UIImageView()
        addBottomViewWithImageView(registerImageView, tag: 11, frame: CGRectMake(bottomView.frame.size.width * 0.5, 0, loginW * 0.5, forgetPwdImageViewH), imageName: "c1_2", title: "注册")
    }
    
    func addBottomViewWithImageView(imageView: UIImageView, tag: Int, frame: CGRect, imageName: String, title: String) {
        imageView.frame = frame
        imageView.image = UIImage(named: imageName)
        imageView.tag = tag
        imageView.userInteractionEnabled = true
        
        let label = UILabel(frame: CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height))
        label.textAlignment = .Center
        label.textColor = textCoclor
        label.text = title
        label.font = UIFont.systemFontOfSize(15)
        imageView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: "bottomViewColcikWith:")
        imageView.addGestureRecognizer(tap)
        
        bottomView.addSubview(imageView)
        
    }
    
    /// 底部忘记密码和注册按钮点击
    func bottomViewColcikWith(tap: UIGestureRecognizer) {
        if tap.view!.tag == 10 { // 忘记密码
            print("忘记密码", terminator: "")
        } else {                 // 注册
            print("注册", terminator: "")
            //SVProgressHUD.showErrorWithStatus("直接登录就行...没有注册功能", maskType: .Black)
        }
    }
    
    /// 登录按钮被点击
    func loginClick() {
        
        if !phoneTextField.text!.validateMobile() {
           // SVProgressHUD.showErrorWithStatus("请输入11位的正确手机号", maskType: SVProgressHUDMaskType.Black)
            return
        } else if psdTextField.text!.isEmpty {
          //  SVProgressHUD.showErrorWithStatus("密码不能为空", maskType: SVProgressHUDMaskType.Black)
            return
        }
        
        //将用户的账号和密码暂时保存到本地,实际开发中光用MD5加密是不够的,需要多重加密
        let account = phoneTextField.text
        let psdMD5 = psdTextField.text!.md5
        NSUserDefaults.standardUserDefaults().setObject(account, forKey: SD_UserDefaults_Account)
        NSUserDefaults.standardUserDefaults().setObject(psdMD5, forKey: SD_UserDefaults_Password)
        if NSUserDefaults.standardUserDefaults().synchronize() {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    /// 快捷登录点击
    func quickLoginClick() {
        print("快捷登陆", terminator: "")
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
extension UIColor {
    class func colorWith(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        return color
    }
    
}
