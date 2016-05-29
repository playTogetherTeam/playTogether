//
//  BannerView.swift
//  playTogether
//
//  Created by 泽宇 周 on 16/5/18.
//  Copyright © 2016年 马腾. All rights reserved.
//

import UIKit

//按钮点击类型


/// 轮播图 每次滚动的距离
private let bannerWidth = SCREEN_WIDTH

protocol BannerViewDelegate:NSObjectProtocol
{
    func bannerButtonClicked(clickType:Int)
    func experHeadView(headView: BannerView, didClickImageViewAtIndex index: Int)
}

class BannerView: UIView,UIScrollViewDelegate {
    
    
    var showScrollView = UIScrollView()
    var bannerArray = NSMutableArray()
    var cateGoryArray = NSMutableArray()
    
    var timer = NSTimer()
    var pageControl = UIPageControl()
    
    
    /// 好物
    var goodSomethingBtn = UIButton()
    /// 搜索
    var searchBtn = UIButton()
    /// 种草
    var plantGrassBtn = UIButton()
    /// 签到
    var signInBtn = UIButton()
    
    weak var delegate:BannerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.bannerArray = ProductRecommend.createDailyBannerModel() //类方法  返回 banner数组
        self.cateGoryArray = ProductRecommend.createCateGoryModel()
        
        print("bannerView ->bannerArray.count = \(self.bannerArray.count)")
        
        self.createBannerView()
        
        self.createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //创建轮播图
    func createBannerView()
    {
        showScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 324/2)
        showScrollView.delegate = self
        showScrollView.pagingEnabled = true
        showScrollView.bounces = false
        showScrollView.showsHorizontalScrollIndicator = false
        
        
        //利用 n+2 方法 index=0 前面加最后一张图片     index = count-1 后加第一张图片
        //最后一张放到index = 0的位置
        let lastImageView = UIImageView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 324/2))
        let bannerModel = self.bannerArray[bannerArray.count-1] as! DailyBannerModel
        lastImageView.sd_setImageWithURL(NSURL(string: bannerModel.imageUrl), placeholderImage: UIImage(named: "placeHolder.jpg"))
        showScrollView.addSubview(lastImageView)
        //第一张放到 index = count 的位置
        let firstImageView = UIImageView.init(frame: CGRectMake(CGFloat(bannerArray.count+1)*SCREEN_WIDTH , 0, SCREEN_WIDTH, 324/2))
        let model = self.bannerArray[0] as! DailyBannerModel
        firstImageView.sd_setImageWithURL(NSURL(string: model.imageUrl), placeholderImage: UIImage(named: "placeHolder.jpg"))
        showScrollView.addSubview(firstImageView)
        
        
        
        for(var index = 0 ;index < self.bannerArray.count ;index++)
        {
            let bannerModel = self.bannerArray[index] as! DailyBannerModel
            let imageView = UIImageView(frame: CGRectMake(SCREEN_WIDTH*CGFloat(index+1), 0, SCREEN_WIDTH, 324/2))
            
            imageView.sd_setImageWithURL(NSURL(string: bannerModel.imageUrl), placeholderImage:UIImage(named: "placeHolder.jpg"))
            
            let tap = UITapGestureRecognizer(target: self, action: "imageClick:")
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            showScrollView.addSubview(imageView)
            
        }
        showScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*CGFloat(bannerArray.count+2), 0)
        showScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0)
        
        self.addSubview(showScrollView)
        
        
        //创建pageControl
        pageControl.numberOfPages = bannerArray.count
        let size = pageControl.sizeForNumberOfPages(bannerArray.count)
        pageControl.frame = CGRectMake(0, 150, size.width, 6)
        pageControl.layer.zPosition = 2
        pageControl.center = CGPointMake(SCREEN_WIDTH/2, pageControl.center.y)
        pageControl.pageIndicatorTintColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 253/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1.0)
        //给 pageControl 添加事件
        pageControl.addTarget(self, action: "currentPageChanged", forControlEvents: UIControlEvents.ValueChanged)
        pageControl.currentPage = 0
        self.addSubview(pageControl)
        
        startTimer()
    }
    
    //开启timer
    func startTimer()
    {
        //开启timer
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "autoMaticScroll", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        //NSRunLoopCommonModes  其他类似scollrVIew控件拖动 不会影响timer的执行
        //NSDefaultRunLoopMode  会暂停timer
    }
    
    func imageClick(tap: UITapGestureRecognizer) {
        delegate?.experHeadView(self, didClickImageViewAtIndex: tap.view!.tag - 1000)
    }
    
    ///创建首页 四个 button
    func createButton()
    {
     
        for(var index = 0 ;index < self.cateGoryArray.count ;index++)
        {
            
            let cateGoryModel = self.cateGoryArray[index] as! CateGoryModel
            plantGrassBtn = UIButton.init(frame: CGRectMake(CGFloat(24+45*index+32*index), 175, 45, 70))
            plantGrassBtn.tag = 3
            plantGrassBtn.setImage(UIImage(named: cateGoryModel.photo!), forState: .Normal)
            plantGrassBtn.setImage(UIImage(named: cateGoryModel.photo!), forState: .Highlighted)
            plantGrassBtn.addTarget(self, action: "clickCenter:", forControlEvents: .TouchUpInside)
            self.addSubview(plantGrassBtn)
            //签到 button
          
        }
       
        
    }
    
    
    
    //MARK:timer计时  滚动视图
    
    //timer 方法 ->改变pageControl.currentPage
    func autoMaticScroll()
    {
        //滑动到最后一张
        if(showScrollView.contentOffset.x == CGFloat(bannerArray.count+1)*SCREEN_WIDTH)
        {
            showScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0)
            pageControl.currentPage = 0
        }else
        {
            let page = Int( (showScrollView.contentOffset.x-SCREEN_WIDTH) / SCREEN_WIDTH)
            pageControl.currentPage = page
        }
        
        showScrollView.setContentOffset(CGPointMake(showScrollView.contentOffset.x+bannerWidth, 0), animated: true)
    }
    
    //MARK:scrollviewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //计算页数
        let page = Int( (showScrollView.contentOffset.x-SCREEN_WIDTH) / SCREEN_WIDTH)
        pageControl.currentPage = page
        //如果滑到 第一张
        if(showScrollView.contentOffset.x == 0)
        {
            showScrollView.contentOffset = CGPointMake(CGFloat(bannerArray.count)*SCREEN_WIDTH, 0)
            pageControl.currentPage = bannerArray.count-1
        }else if(showScrollView.contentOffset.x == CGFloat(bannerArray.count+1)*SCREEN_WIDTH)
        {
            //滑倒最后一张的时候
            showScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0)
            pageControl.currentPage = 0
        }
        
    }
    
    //抓住图片的时候 停止时钟
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer.invalidate()
    }
    //结束拖动状态时  开启时钟
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    
    //MARK:按钮点击方法处理
    
    func clickCenter(sender:UIButton)
    {
            delegate?.bannerButtonClicked(sender.tag)
    }
    
    
    
}
