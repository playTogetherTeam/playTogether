//
//  File.swift
//  playTogether
//
//  Created by 马腾 on 16/6/7.
//  Copyright © 2016年 马腾. All rights reserved.
//

import Foundation
struct LoginMember {
    var name: String
    var pwd: String
    var phoneNum: String
    
    init(name:String, pwd:String, phoneNum: String){
        self.name = name
        self.pwd = pwd
        self.phoneNum = phoneNum
    }
}
