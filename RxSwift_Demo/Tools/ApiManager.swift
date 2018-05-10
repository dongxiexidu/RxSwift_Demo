//
//  ApiManager.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import ReactiveMoya

enum ApiManager {
    case getRecommendTag
    
    case getTopicsList(a: String,type:String)
    
    case getNewsList
    case getLaunchImg
}

extension ApiManager : TargetType {

    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        case .getLaunchImg, .getNewsList: // Send no parameters
            return .requestPlain
        case .getRecommendTag:  // Always sends parameters in URL
            return .requestParameters(parameters: ["a" : "tag_recommend","c" : "topic", "action" : "sub"], encoding: URLEncoding.queryString)
        case .getTopicsList(let a,let type):  // Always sends parameters in URL
            return .requestParameters(parameters: ["a" : a,"c" : "data","type" : type], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    
    var baseURL : URL {
        return URL.init(string: "http://api.budejie.com/api/api_open.php")!
    }
}
