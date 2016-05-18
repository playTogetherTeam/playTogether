//
//  HomeViewController.swift
//  playTogether
//
//  Created by 马腾 on 16/4/18.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

enum TableViewMode{
    /// 半糖精选
    case BanTangGoodSelectMode
    /// 用户推荐
    case UserRecommendMode
}

class HomeViewController: UIViewController ,SegmentViewDelegate,BannerViewDelegate{

    private var tableViewMode = TableViewMode.BanTangGoodSelectMode
    
    var bannerView = BannerView()
    /// 轮播视图 ，标签视图 的容器
    var headView = UIView()
    
    private var segmentView = SegmentView()
    override func viewDidLoad() {
        super.viewDidLoad()
        createBannerView()
        buildSegmentView()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK:创建顶部轮播视图
    func createBannerView()
    {
        headView = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 293))
        headView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(headView)
        
        bannerView = BannerView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 514/2))
        bannerView.delegate = self
        headView.addSubview(bannerView)
    }
    
    func bannerVierFourButtonClicked(clickType: ClickType) {
    
            

    }
    
    func buildSegmentView(){
        segmentView = SegmentView.init(frame: CGRectMake(0, 300, SCREEN_WIDTH, 45), firstTitle: "最热活动", secondTitle: "最新活动")
        segmentView.delegate = self
        view.addSubview(segmentView)
    }
    
    func clickSegmentView(clickIndex: Int) {
        if(tableViewMode == .BanTangGoodSelectMode)
        {
            tableViewMode = .UserRecommendMode
        }else
        {
            tableViewMode = .BanTangGoodSelectMode
        }
        //banTangView.reloadData()
    }

}
