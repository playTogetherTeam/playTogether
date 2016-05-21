//
//  ReleaseViewController.swift
//  playTogether
//
//  Created by 马腾 on 16/4/18.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

class ReleaseViewController: BaseViewController , UITextFieldDelegate ,UITextViewDelegate{
    var txtTitle:UITextField!
    var txtTime:UITextField!
    var txtPnum:UITextField!
    var txtActtype:UITextField!
    var txtDetailContent:UITextView!
    
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let mainSize = UIScreen.mainScreen().bounds.size
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRectMake(mainSize.width/2-211/2, 50, 211, 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRectMake(61 - offsetLeftHand, 90, 40, 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        let vLogin =  UIView(frame:CGRectMake(15, 150, mainSize.width - 30, 510))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGrayColor().CGColor
        vLogin.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(vLogin)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
     
        
        
        txtTitle = UITextField(frame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44))
        txtTitle.delegate = self
        txtTitle.layer.cornerRadius = 5
        txtTitle.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtTitle.layer.borderWidth = 0.5
        txtTitle.leftView = UIView(frame:CGRectMake(0, 0, 60, 44))
        txtTitle.leftViewMode = UITextFieldViewMode.Always
        
        //标题输入框左侧文字
//        let imgUser =  UIImageView(frame:CGRectMake(11, 11, 22, 22))
//        imgUser.image = UIImage(named:"iconfont-user")
        let Title =  UILabel(frame:CGRectMake(11, 11, 55, 22))
        Title.text = "标题:"
        //TimeChoice.backgroundColor = UIColor.blackColor()
        Title.textColor = UIColor.redColor()
        txtTitle.leftView!.addSubview(Title)
        vLogin.addSubview(txtTitle)
        
        txtTime = UITextField(frame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44))
        txtTime.delegate = self
        txtTime.layer.cornerRadius = 5
        txtTime.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtTime.layer.borderWidth = 0.5
        //txtTime.secureTextEntry = true
        txtTime.leftView = UIView(frame:CGRectMake(0, 0, 92, 44))
        txtTime.leftViewMode = UITextFieldViewMode.Always
        
        //时间选择输入框左侧文字
//        let imgPwd =  UIImageView(frame:CGRectMake(11, 11, 44, 22))
//        imgPwd.image = UIImage(named:"iconfont-password")
        let TimeChoice =  UILabel(frame:CGRectMake(11, 11, 77, 22))
        TimeChoice.text = "时间选择:"
        //TimeChoice.backgroundColor = UIColor.blackColor()
        TimeChoice.textColor = UIColor.redColor()
        txtTime.leftView!.addSubview(TimeChoice)
        vLogin.addSubview(txtTime)
        
        txtPnum = UITextField(frame:CGRectMake(30, 150, vLogin.frame.size.width - 60, 44))
        txtPnum.keyboardType = UIKeyboardType.NumberPad
        txtPnum.delegate = self
        txtPnum.layer.cornerRadius = 5
        txtPnum.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtPnum.layer.borderWidth = 0.5
        //txtPnum.secureTextEntry = true
        txtPnum.leftView = UIView(frame:CGRectMake(0, 0, 92, 44))
        txtPnum.leftViewMode = UITextFieldViewMode.Always
        
        let ActNum =  UILabel(frame:CGRectMake(11, 11, 77, 22))
        ActNum.text = "活动人数:"
        //TimeChoice.backgroundColor = UIColor.blackColor()
        ActNum.textColor = UIColor.redColor()
        txtPnum.leftView!.addSubview(ActNum)
        vLogin.addSubview(txtPnum)
        
        txtActtype = UITextField(frame:CGRectMake(30, 210, vLogin.frame.size.width - 60, 44))
        txtActtype.delegate = self
        txtActtype.layer.cornerRadius = 5
        txtActtype.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtActtype.layer.borderWidth = 0.5
        //txtActtype.secureTextEntry = true
        txtActtype.leftView = UIView(frame:CGRectMake(0, 0, 92, 44))
        txtActtype.leftViewMode = UITextFieldViewMode.Always
        
        let ActType =  UILabel(frame:CGRectMake(11, 11, 77, 22))
        ActType.text = "活动类型:"
        //TimeChoice.backgroundColor = UIColor.blackColor()
        ActType.textColor = UIColor.redColor()
        txtActtype.leftView!.addSubview(ActType)
        vLogin.addSubview(txtActtype)
        
        txtDetailContent = UITextView(frame:CGRectMake(30, 270, vLogin.frame.size.width - 60, 224))
        txtDetailContent.delegate = self
        txtDetailContent.layer.cornerRadius = 5
        txtDetailContent.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtDetailContent.layer.borderWidth = 0.5
        //txtDetailContent.secureTextEntry = true
        //txtDetailContent.leftView = UIView(frame:CGRectMake(0, 0, 92, 44))
        //txtDetailContent.leftViewMode = UITextFieldViewMode.Always
        
        vLogin.addSubview(txtDetailContent)
        
        // Do any additional setup after loading the view.
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(textField:UITextField)
    {
        //如果当前是用户名输入
        if textField.isEqual(txtTitle) || textField.isEqual(txtPnum){
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            //播放不遮眼动画
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y + 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x + 48,
                    self.imgRightHand.frame.origin.y + 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x - 70,
                    self.imgLeftHandGone.frame.origin.y, 40, 40)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x + 30,
                    self.imgRightHandGone.frame.origin.y, 40, 40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(txtTime) || textField.isEqual(txtActtype){
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            //播放遮眼动画
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y - 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x - 48,
                    self.imgRightHand.frame.origin.y - 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x + 70,
                    self.imgLeftHandGone.frame.origin.y, 0, 0)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x - 30,
                    self.imgRightHandGone.frame.origin.y, 0, 0)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//登录框状态枚举
enum LoginShowType {
    case NONE
    case USER
    case PASS
}

    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }

    

