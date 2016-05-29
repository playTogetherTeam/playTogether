//
//  ProductRecommend.swift
//  BeautifulDay
//
//  Created by jiachen on 16/1/14.
//  Copyright © 2016年 jiachen. All rights reserved.
//

import UIKit

class ProductRecommend: NSObject {

    var fileName = "app_JSON"
    let jsonNameArray = NSArray(objects: "app_JSON")
    var productArr = NSMutableArray()
    var categoryArr = NSMutableArray()
    var bannerArr = NSMutableArray()
    var dict = NSDictionary()
    
    override init() {
        super.init()
    
    }
    ///从json中获取数据
    func getDataFromJSONFile(index:Int)
    {
        
        fileName = jsonNameArray[index] as! String
        //获取资源文件
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        print("get data success")
        
        self.dict = ( try! NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) ) as! NSDictionary
    }
    
    //MARK:创建首页清单推荐模型 --各种分类下的model
    func createProductRecommendModel(categoryIndex:Int) ->NSMutableArray
    {
        
        self.getDataFromJSONFile(categoryIndex)
        //从json 中解析出 data 数组
        let dataArr = dict.objectForKey("data") as! NSDictionary
        
        //从data数组汇总解析出 topicArray
        let topicArr = dataArr.objectForKey("topic") as! NSArray
        
        self.productArr = NSMutableArray() //否则  切换频道的时候 数组会叠加
        for(var i:Int = 0;i < topicArr.count ;i++)
        {
            //从topicArray中解析出 model
            let obj = topicArr[i]
            //给model赋值
            let model = ProductRecommendModel.init()
            model.productID = ( obj.objectForKey("id") )as? String
            model.title = (obj.objectForKey("title")) as? String
            model.subTitle = obj.objectForKey("tags") as? String
            model.imageUrl = obj.objectForKey("pic") as? String
            model.likesNumber = obj.objectForKey("likes") as? String
            model.isLike = obj.objectForKey("islike") as? Bool
            model.updataTime = obj.objectForKey("update_time") as? Int
            model.type = obj.objectForKey("type") as? String
            
            self.productArr.addObject(model)
        }
        print("\(jsonNameArray[categoryIndex] as! String)个数 :\(self.productArr.count)")
        return self.productArr
    }
    
    
    //MARK:创建首页轮播scrollView --每日精选
    class func createDailyBannerModel() -> NSMutableArray
    {
        let product = ProductRecommend()
        //从json 中解析出 data 数组
        product.getDataFromJSONFile(0)
        
        let dataArr = product.dict.objectForKey("data") as! NSDictionary
    
        
        //从data数组汇总解析出 bannerArray
        let bannerArr = dataArr.objectForKey("banner") as! NSArray
        
        for(var i:Int = 0;i < bannerArr.count ;i += 1)
        {
            //从topicArray中解析出 model
            let obj = bannerArr[i]
            //给model赋值
            let model = DailyBannerModel.init()
            model.bannerID = ( obj.objectForKey("id") ) as? String
            model.title = (obj.objectForKey("title")) as? String
            model.subTitle = obj.objectForKey("tags") as? String
            model.imageUrl = obj.objectForKey("photo") as! String
            model.type = obj.objectForKey("type") as? String
            
            product.bannerArr.addObject(model)
        }
        print("轮播图片个数 :\(product.bannerArr.count)")
        return product.bannerArr
    }
    
    //MARK:创建 分类模型 --"文艺" "设计" 等等
    class func createCateGoryModel() ->NSMutableArray
    {
        //从json 中解析出 data 数组
        let product = ProductRecommend()
        product.getDataFromJSONFile(0)
        let dataArr = product.dict.objectForKey("data") as! NSDictionary
        
        //从data数组汇总解析出 categoryArr
        let categoryArr = dataArr.objectForKey("category_element") as! NSArray
        
        for(var i:Int = 0;i < categoryArr.count ;i++)
        {
            //从topicArray中解析出 model
            let obj = categoryArr[i]
            //给model赋值
            let model = CateGoryModel.init()
            model.categoryID = ( obj.objectForKey("id") ) as? String
            
            model.title = (obj.objectForKey("title")) as? String
            model.subTitle = obj.objectForKey("tags") as? String
            model.type = obj.objectForKey("type") as? String
            model.extend = obj.objectForKey("extend") as? String
            model.photo = obj.objectForKey("photo") as? String
            product.categoryArr.addObject(model)
        }
        
        //print("分类个数 :\(self.categoryArr.count)")
        return product.categoryArr
    }
    
}



//清单推荐Model
class ProductRecommendModel {
    /** 清单ID*/
    var productID:String?
    /** 一级标题*/
    var title:String?
    /** 二级标题*/
    var subTitle:String?
    /** 图片url*/
    var imageUrl:String?
    /** 喜欢人数*/
    var likesNumber:String?
    /** 是否已经喜欢*/
    var isLike:Bool?
    /** 更新时间*/
    var updataTime:Int?
    /** 清单类型*/
    var type:String?
}


 /// 每日轮播图
class DailyBannerModel{
    /// id
    var bannerID:String?
    /// 标题
    var title:String?
    /// 子标题
    var subTitle:String?
    /// 类型
    var type:String?
    /// 图片url
    var imageUrl:String!
}

//各种分类Model
class CateGoryModel {
    /** 分类ID*/
    var categoryID:String?
    /** 一级标题*/
    var title:String?
    /** 二级标题*/
    var subTitle:String?
    /** 类型*/
    var type:String?
    /** 扩展*/
    var extend:String?
    var photo:String?
}
