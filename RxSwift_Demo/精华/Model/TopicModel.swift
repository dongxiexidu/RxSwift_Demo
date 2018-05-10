//
//  TopicModel.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import HandyJSON

struct TopicListModel : HandyJSON {
    var list:[TopicModel]?
}


enum TopicType: Int, HandyJSONEnum {
    case all = 1
    case picture = 10
    case word = 29
    case voice = 31
    case video = 41
}

struct TopicModel : HandyJSON {
    
    var ID:String?
    // 用户 -- 发帖者
    var name:String?
    /** 用户的头像 */
    var profile_image:String?
    /** 帖子的文字内容 */
    var text:String?
    /** 帖子审核通过的时间 */
    var create_time:String?
    
    /** 顶数量 */
    var  ding:String?
    /** 踩数量 */
    var cai:String?
    /** 转发\分享数量 */
    var repost:String?
    /** 评论数量 */
    var comment:String?
    
    var sina_v : Bool?
    /** 是否为gif图片 */
    var is_gif:String?
    
    // 这里不支持强制转CGFloat
    /** 视频或图片类型帖子的宽度 */
    var width:String?
    /** 视频或图片类型帖子的高度 */
    var height:String?
    
    
    /** 音频的时长 */
    var voicetime:String?
    /** 播放次数 */
    var playcount:String?
    /** 音频的播放地址 */
    var voiceuri:String?
    
    
    /** 视频的播放地址 */
    var videouri:String?
    /** 视频的时长 */
    var videotime:String?
    
    // 自定义解析规则
    mutating func mapping(mapper: HelpingMapper) {
        
        mapper <<<
            self.small_image <-- "image0"
        mapper <<<
            self.middle_image <-- "image2"
        mapper <<<
            self.middle_image <-- "image2"
    }

    /** 小图片*/
    var small_image:String?
    /** 中图片*/
    var middle_image:String?
    /** 大图片 */
    var large_image:String?
    
    
    /****** 是否为大图 ******/
    var bigImage:Int = 0
    
    /** 最热评论 */
    var top_cmt : [Comment]?
    
    var type:TopicType?
    
    /*  追加的属性 */
   // var contentViewFrame : CGRect?//图片或视频或声音内容尺寸
    
    var pictureFrame : CGRect?
    var voiceFrame : CGRect?
    var videoFrame : CGRect?
    
   // var _created_at:String?
    
    var create_at:String?{
        
        get{
            
            let dataformat =  DateFormatter()
            dataformat.locale =  NSLocale(localeIdentifier: "zh_CN") as Locale!
            dataformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            //将字符串转为NSdata
            let currdata = dataformat.date(from: create_time!)
            //当前时间
            let nowData : Date = Date.init()
            
            //创建日历对象，比较差值
            let cureentCal =  Calendar.current
            
            let component : DateComponents =
                cureentCal.dateComponents([.year,.month,.day,.hour,.minute,.second], from: currdata!, to: nowData)
            
            //是否今年
            if((currdata?.isThisYear()) == true){
                
                if((currdata?.isYesterday()) == true){//是否为昨天
                    
                    dataformat.dateFormat = "昨天 HH:mm"
                    
                    return dataformat.string(from: currdata!)
                }else if((currdata?.isToday()) == true){//是否为今天
                    if(component.hour! >= 1){
                        return "\(component.hour!)小时前"
                    }else if(component.minute! >= 1){
                        return  "\(component.minute!)分钟前"
                    }else{
                        return "刚刚"
                    }
                    
                }else{ //今年的某月某日
                    
                    dataformat.dateFormat = "MM-dd HH:mm";
                    return dataformat.string(from: currdata!)
                    
                }
            }else{//不是今年
                
                dataformat.dateFormat = "yyyy-MM-dd HH:mm";
                return dataformat.string(from: currdata!)
            }
            
        }set(currentime){
            create_at = currentime
        }
    }
    
    var cellHeight:CGFloat? {
        
        // mutating 可以修改 属性值
        mutating get{
// ??????
//            if cellHeight != nil  {
//                return cellHeight
//            }else{
                //顶部的高
                let topheight:CGFloat = 55
                //底部的高
                let bonheight:CGFloat = 35
                let textStr =  self.text! as NSString
                //中间文字的高
            
                let textSize =  textStr.boundingRect(with: CGSize.init(width: screen_width - 2*kMargin, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil).size

                //不是段子
                if self.type != TopicType.word{
                    let width_X = screen_width - 2*kMargin
                    
                    let myWi = (height! as NSString).floatValue
                    let myhe = (height! as NSString).floatValue

                    let scale_w:CGFloat = CGFloat(myWi)/width_X
                    var contentViewH = CGFloat(myhe)/scale_w

                    //如果是视频 并且宽度是250
                    if (self.type == TopicType.video && contentViewH > 250) {
                        contentViewH = 250
                        bigImage = 1
                    }
                    
                    if (myhe > 1500) {
                        contentViewH = 300
                        bigImage = 1
                    }
                    
                    return topheight+bonheight+textSize.height+25+CGFloat(contentViewH)
                }else{
                    return topheight+bonheight+textSize.height+25
                }
//            }
        }
    }
}

extension TopicModel {
    var contentViewFrame:CGRect? {
        
     get{
        
        let topheight:CGFloat = 55
        let textStr =  self.text! as NSString
        //中间文字的高
        let textSize =  textStr.boundingRect(with: CGSize.init(width: screen_width - 2*kMargin, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil).size
        //最大x
        let max = topheight + textSize.height+5
        //不是段子
        if self.type != TopicType.word{
            let width_X = screen_width - 2*kMargin
            
            
            let myWi = (height! as NSString).floatValue
            let myhe = (height! as NSString).floatValue
            
            let contentViewX:CGFloat = kMargin
            let contentViewY:CGFloat = max
            let scale_w:CGFloat = CGFloat(myWi)/width_X
            var contentViewH = CGFloat(myhe)/scale_w
            
            //如果是视频 并且宽度是250
            if (self.type == TopicType.video && contentViewH > 250) {
                contentViewH = 250
            }
            
            if (myhe > 1500) {
                contentViewH = 300
            }
            return CGRect.init(x: contentViewX, y: contentViewY, width: width_X, height: contentViewH)
             
        }else{
            return CGRect.zero
        }
    }
    }

    
}
