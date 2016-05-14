//
//  SegmentView.swift
//  BeautifulDay
//
//  Created by jiachen on 16/1/21.
//  Copyright © 2016年 jiachen. All rights reserved.
//

import UIKit

protocol SegmentViewDelegate:NSObjectProtocol{
    func clickSegmentView(clickIndex:Int)
}

class SegmentView: UIView {
    
    var firstTitle = String()
    var secondTitle = String()
    var currentIndex:CGFloat!{
        didSet
        {
            var centerX = CGFloat()
            if(currentIndex == 0)
            {
                centerX = firstLabel.center.x
                firstLabel.textColor = selectedTextColor
                secondLabel.textColor = normalTextColor
            }else
            {
                centerX = secondLabel.center.x
                firstLabel.textColor = normalTextColor
                secondLabel.textColor = selectedTextColor
            }
            weak var weakSelf = self
            UIView.animateWithDuration(0.3) { () -> Void in
                weakSelf!.indicator.center = CGPointMake(centerX, weakSelf!.indicator.center.y)
            }
        }
    }
    
    //label 默认颜色
    var normalTextColor = MainTitleColor {
        didSet{
            if currentIndex == 0 {
                secondLabel.textColor = selectedTextColor
            }else {
                firstLabel.textColor = normalTextColor
            }
        }
    }
    // 选中颜色
    var selectedTextColor = CustomBarTintColor {
        didSet{
            if currentIndex == 0 {
                firstLabel.textColor = selectedTextColor
                secondLabel.textColor = normalTextColor
            }else {
                firstLabel.textColor = normalTextColor
                secondLabel.textColor = selectedTextColor
            }
        }
    }
    
    private var firstLabel = UILabel()
    private var secondLabel = UILabel()
    private var indicator = UIView()
    
    //分割线
    private var topLine = UIView()
    private var bottomLine = UIView()
    var isShowSeprator: Bool? {
        didSet{
            topLine.hidden = !(isShowSeprator!)
            bottomLine.hidden = !(isShowSeprator!)
        }
    }
    
    var isShowIndictor: Bool? {
        didSet{
            indicator.hidden = isShowIndictor!
        }
    }
    weak var delegate:SegmentViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect,firstTitle:String,secondTitle:String)
    {
        self.init(frame:frame)
        backgroundColor = UIColor.whiteColor()
        self.firstTitle = firstTitle
        self.secondTitle = secondTitle
        self.buildUI()
    }
    
    
    
    func buildUI()
    {
        firstLabel = UILabel()
        firstLabel.tag = 1
        firstLabel.userInteractionEnabled = true
        firstLabel.text = firstTitle
        firstLabel.font = UIFont.systemFontOfSize(15.0)
        firstLabel.textColor = normalTextColor
        firstLabel.sizeToFit()
        firstLabel.frame = CGRectMake(45, 45, firstLabel.frame.size.width, firstLabel.frame.size.height)
        firstLabel.center = CGPointMake(self.frame.size.width/4, self.frame.size.height/2)
        let tapGesture1 = UITapGestureRecognizer.init(target: self, action: "clickLabel:")
        firstLabel.addGestureRecognizer(tapGesture1)
        addSubview(firstLabel)
        
        secondLabel = UILabel()
        secondLabel.tag = 2
        secondLabel.userInteractionEnabled = true
        secondLabel.text = secondTitle
        secondLabel.font = UIFont.systemFontOfSize(15.0)
        secondLabel.textColor = normalTextColor
        secondLabel.sizeToFit()
        secondLabel.frame = CGRectMake(45, 45, firstLabel.frame.size.width, firstLabel.frame.size.height)
        secondLabel.center = CGPointMake(self.frame.size.width/4*3, self.frame.size.height/2)
        let tapGesture2 = UITapGestureRecognizer.init(target: self, action: "clickLabel:")
        secondLabel.addGestureRecognizer(tapGesture2)
        addSubview(secondLabel)
        
        // 中间分割线
        let lineView = UIView.init(frame: CGRectMake(self.frame.size.width/2-0.5, 45/2-17/2, 1, 17))
        lineView.backgroundColor = GrayLineColor
        addSubview(lineView)
        
        //上下分割线
        topLine = UIView.init(frame: CGRectMake(0, 0, self.frame.size.width, 0.5))
        topLine.backgroundColor = LightLineColor
        addSubview(topLine)
        
        bottomLine = UIView.init(frame: CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5))
        bottomLine.backgroundColor = LightLineColor
        addSubview(bottomLine)
        
        //指示器  默认指示第一个元素
        currentIndex = 0
        indicator = UIView.init(frame: CGRectMake(0, self.frame.size.height-3, firstLabel.frame.size.width+20, 3))
        indicator.center = CGPointMake(firstLabel.center.x, indicator.center.y)
        indicator.backgroundColor = CustomBarTintColor
        addSubview(indicator)
    }
    
    
    func clickLabel(tapGesture:UITapGestureRecognizer)
    {
        //点击的label 执行动画
        let label = tapGesture.view as? UILabel
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            label?.transform = CGAffineTransformMakeScale(1.2, 1.2)
        }) { (finished:Bool) -> Void in
            if(finished)
            {
                label?.transform = CGAffineTransformIdentity
            }
        }
        
        //        UIView.animateWithDuration(0.4, animations: { () -> Void in
        //            label?.transform = CGAffineTransformMakeScale(1.2, 1.2)
        //            }) { (finished:Bool) -> Void in
        //                if(finished)
        //                {
        //                    label?.transform = CGAffineTransformIdentity
        //                }
        //        }
        
        
        //点击的label不是当前已经显示的label
        if( Int(currentIndex!) != (tapGesture.view?.tag)!-1)
        {
            //返回 被点击label的tag
            delegate?.clickSegmentView((tapGesture.view?.tag)!)
            currentIndex = CGFloat( (tapGesture.view?.tag)! ) - 1
        }
        
        
    }
    
    
    
}
