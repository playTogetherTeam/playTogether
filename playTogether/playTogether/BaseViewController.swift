//
//  BaseNavigationController.swift
//  BeautifulDay
//
//  Created by jiachen on 16/1/19.
//  Copyright © 2016年 jiachen. All rights reserved.
//

import UIKit


struct barButtonItem {
    var title:String?
    var action:Selector?
}
class BaseViewController: UIViewController {
    
    
    
    private var leftTitle = String()
    private var rightTitle = String()
    
    
    
    init(leftTitle:String,rightTitle:String)
    {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
        
        var  backButtonItem = UIBarButtonItem.init()
        if(leftTitle == ""){
            backButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .Done, target: self, action: "barCancel")
        }else{
            backButtonItem = UIBarButtonItem.init(title: leftTitle, style: .Done, target: self, action:"barCancel")
        }
        
        backButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = backButtonItem
        
        var completeButtomItem = UIBarButtonItem.init()
        if(rightTitle != ""){
            completeButtomItem = UIBarButtonItem.init(title: rightTitle, style: .Done, target: self, action: "barOK")
            navigationItem.rightBarButtonItem = completeButtomItem
        }
        completeButtomItem.tintColor = UIColor.whiteColor()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //桥接文件,暂时注释
        // SVProgressHUD.show()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //桥接文件,暂时注释
        // SVProgressHUD.dismiss()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if title != nil {
            print("离开 \(title!)")
        }
        
    }
    
    //nacigationBar 方法
    func barCancel()
    {
        navigationController?.popViewControllerAnimated(true)
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func barOK()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
