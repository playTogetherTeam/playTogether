//
//  config.swift
//  playTogether
//
//  Created by 泽宇 周 on 16/4/21.
//  Copyright © 2016年 马腾. All rights reserved.
//
import UIKit


public let NavigationH: CGFloat = 64
public let SCREEN_WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
public let SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height
public let MainBounds: CGRect = UIScreen.mainScreen().bounds



public let CustomBarTintColor = UIColor(hexString: "EC5252")
public let MainTitleColor:UIColor = UIColor.init(red: 109/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)
public let SubTitleColor:UIColor = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
public let LightLineColor:UIColor = UIColor.init(hexString: "F9F9F9")
public let GrayLineColor:UIColor = UIColor.init(hexString: "D8D8D8")
public let TitleGrayCorlor:UIColor = UIColor(hexString: "A7A7A7")
/// textView/textfield placeHolder titleColor
public let PlaceHolderColor:UIColor = UIColor(hexString: "B6B6B6")
/// view灰色背景
public let ViewGrayBackGroundColor = UIColor(hexString: "F5F5F5")
/// 文字半黑色
public let HalfBlackTitleColor:UIColor = UIColor(hexString: "959595")

public var MyFavoriteList = Array() as [String]
public var RecommendList = Array() as [String]

///分割线的 cell 背景颜色
public let CellSeparatotBackColor:UIColor = UIColor(hexString: "EEEEEE")
/// cell 中 商品价格，喜欢人数标签的背景颜色
public let TagBackOrangeColor:UIColor = UIColor(hexString: "FFA429")