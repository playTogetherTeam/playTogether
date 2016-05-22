//
//  PersonCenterViewController.swift
//  playTogether
//
//  Created by 马腾 on 16/4/18.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

class PersonCenterViewController: UIViewController {
    // 标识符
    let cellId = "cellID"
    
    // 懒加载
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.frame = CGRect(x: 0, y: -64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height+64)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var headImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "fight"))
        imageView.frame.size.width = UIScreen.mainScreen().bounds.size.width
        imageView.frame.size.height = 200
        return imageView
    }()
    
    lazy var accountImg: UIImageView = {
        let image: UIImageView = UIImageView(image: UIImage(named: "fight"))
        image.frame = CGRect(x: UIScreen.mainScreen().bounds.width*2/3, y: 30, width: 80, height: 80)
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    lazy var data: NSArray = {
        let arr = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("data", ofType: "plist")!)!
        return arr
    }()
    
    lazy var picker: UIImagePickerController = {
        let pick: UIImagePickerController = UIImagePickerController()
        pick.view.backgroundColor = UIColor.grayColor()
        pick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pick.delegate = self
        return pick
    }()
    
    lazy var alert: UIAlertController = {
        let alertCon = UIAlertController(title: "图片选取方式", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        return alertCon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perpareUI()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // 准备UI
    func perpareUI() {
        title = "个人中心"
        self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(dictionary: [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.grayColor()]) as? [String : AnyObject]
        
        // 设置状态栏颜色为白色
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        // 去除NavigationBar底部黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //设置NavigationBar背景为透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg"), forBarMetrics: UIBarMetrics.Default)
        
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.cameraClick()
        }))
        alert.addAction(UIAlertAction(title: "从手机相册取", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.photoLibraryClick()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (alert) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        accountImg.userInteractionEnabled = true
        headImage.userInteractionEnabled = true
        
        let panGesture = UITapGestureRecognizer(target: self, action: "headImgClicked:")
        accountImg.addGestureRecognizer(panGesture)
        
        headImage.addSubview(accountImg)
        
        tableView.tableHeaderView = headImage
        tableView.tableFooterView = UIView()
        
        view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - ViewController控制器的事件处理
extension PersonCenterViewController {
    func headImgClicked(sender: UITapGestureRecognizer) {
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     选取拍照
     */
    func cameraClick() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            NSLog("支持相机")
            self.presentViewController(picker, animated: true, completion: nil)
        }else {
            NSLog("不支持拍照")
        }
    }
    
    /**
     选取相册
     */
    func photoLibraryClick() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
            NSLog("支持图库")
            self.presentViewController(picker, animated: true, completion: nil)
        }else {
            NSLog("不支持图库")
        }
    }
}

// MARK: - 实现UITableView的代理方法
extension PersonCenterViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1) {
            return 35
        }else {
            return  0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return self.data.count
        }else {
            return 10
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellId)
        
        // 取消选中效果
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if(indexPath.section == 0) {
            cell.textLabel?.text = self.data[indexPath.row][0] as? String
            cell.detailTextLabel?.text = self.data[indexPath.row][1] as? String
        }else {
            cell.textLabel?.text = "重庆\(indexPath.row + 1)中"
            cell.detailTextLabel?.text = "万州\(indexPath.row + 1)中"
        }
        return cell
    }
}

// MARK: - 实现UIScrollView的代理方法
extension PersonCenterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffSet: CGFloat = self.tableView.contentOffset.y
        if(contentOffSet < 72) {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg"), forBarMetrics: UIBarMetrics.Default)
        }else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg4"), forBarMetrics: UIBarMetrics.Default)
        }
        
    }
}

// MARK: - UIImagePickerControllerDelegate代理实现
extension PersonCenterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /**
     点击图片
     
     - parameter picker: picker
     - parameter info:   图片
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        NSLog("info: \(info)")
        let image: UIImage = NSDictionary(dictionary: info).objectForKey("UIImagePickerControllerOriginalImage") as! UIImage
        // 更换图片
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.accountImg.image = image
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        NSLog("select")
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
