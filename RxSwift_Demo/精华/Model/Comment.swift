//
//  Comment.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/10/1.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import HandyJSON

struct Comment : HandyJSON {
    
    var ID:String?
    
    /** 音频时长 */
    var voicetime:String?
    
    /** 用户的头像 */
    var profile_image:String?
    
    /** 音频文件的路径 */
    var voiceuri:String?
    
    /** 评论文字内容 */
    var content:String?
    
    /** 被点赞的数量 */
    var like_count:String?
    
    /** 用户 */
    var user:User?

}
