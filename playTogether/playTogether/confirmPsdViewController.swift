//
//  confirmPsdViewController.swift
//  playTogether
//
//  Created by 马腾 on 16/6/21.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

class confirmPsdViewController: UIViewController {
    var mobilePhoneNum: String!
   // var bottomView: UIView!
    var backScrollView: UIScrollView!
    var topView: UIView!
   // var phoneTextField: UITextField!
    var psdTextField: UITextField!
    var psdTextFieldConfirm: UITextField!
    var loginImageView: UIImageView!
  //  var quickLoginBtn: UIButton!
   // var forgetPwdImageView: UIImageView!
 //   var registerImageView: UIImageView!
    let textCoclor: UIColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
    let loginW: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "输入密码"
        view.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        //添加scrollView
        addScrollView()
        // 添加手机文本框和密码文本框
        addTextField()
        // 添加注册View
        addLoginImageView()
        // 添加键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrameNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        // Do any additional setup after loading the view.
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
        
        psdTextField = UITextField()
        addTextFieldToTopViewWiht(psdTextField!, frame: CGRectMake(leftMargin, 1, AppWidth - leftMargin, textH - 1), placeholder: "请输入密码")
        
        let line2 = UIView(frame: CGRectMake(0, textH, AppWidth, 1))
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = alphaV
        topView!.addSubview(line2)
        
        
        psdTextFieldConfirm = UITextField()
        addTextFieldToTopViewWiht(psdTextFieldConfirm!, frame: CGRectMake(leftMargin, textH + 1, AppWidth - leftMargin, textH - 1), placeholder: "请重复密码")
        
      
        
        
        
        
        //        psdTextFieldConfirm = UITextField()
        //        addTextFieldToTopViewWiht(psdTextFieldConfirm!, frame: CGRectMake(leftMargin, textH * 2 + 1, AppWidth - leftMargin, textH - 1), placeholder: "重复密码")
    }
    
    func addLoginImageView() {
        let loginH: CGFloat = 50
        loginImageView = UIImageView(frame: CGRectMake((AppWidth - loginW) * 0.5, CGRectGetMaxY(topView!.frame) + 10, loginW, loginH))
        loginImageView.userInteractionEnabled = true
        loginImageView.image = UIImage(named: "signin_1")
        
        let loginLabel = UILabel(frame: loginImageView.bounds)
        loginLabel.text = "创建账户"
        loginLabel.textAlignment = .Center
        loginLabel.textColor = textCoclor
        loginLabel.font = UIFont.systemFontOfSize(22)
        loginImageView.addSubview(loginLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "loginClick:")
        loginImageView.addGestureRecognizer(tap)
        
        backScrollView.addSubview(loginImageView)
    }
    
    func loginClick(sender: UIButton){
        if psdTextField.text != psdTextFieldConfirm.text {
           UIAlertController(title: "系统警告", message: "重复输入密码错误", preferredStyle: UIAlertControllerStyle.ActionSheet)
        }else{
            AVUser.logInWithMobilePhoneNumberInBackground(mobilePhoneNum, password: psdTextField.text, block: { (user, error) in
                if error != nil {
                    print("login succeed")
                    
                }
            })
        }
    }
    
    func addTextFieldToTopViewWiht(textField: UITextField ,frame: CGRect, placeholder: String) {
        textField.frame = frame
        textField.autocorrectionType = .No
        textField.clearButtonMode = .Always
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = placeholder
        topView!.addSubview(textField)
    }

    
    func backScrollViewTap() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
