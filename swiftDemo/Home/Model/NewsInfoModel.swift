//
//  NewsInfoModel.swift
//  swiftDemo
//
//  Created by edz on 2021/7/29.
//

import SwiftyJSON

struct NewsInfoModel {
    var path: String?
    var image: String?
    var title: String?
    var passtime: String?
    
    init(jsonData:JSON) {
        path = jsonData["path"].stringValue
        image = jsonData["image"].stringValue
        title = jsonData["title"].stringValue
        passtime = jsonData["passtime"].stringValue
    }

}
