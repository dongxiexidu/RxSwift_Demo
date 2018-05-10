//
//  Date+Extension.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

let formatter_ = DateFormatter()
let calendar_ = NSCalendar.current

extension Date {
    
    public func isToday() -> Bool{
        formatter_.dateFormat = "yyyy-MM-dd"
        let selfDay = formatter_.string(from: self as Date)
        let nowDay = formatter_.string(from: Date.init())
        return selfDay == nowDay
    }
    
    
    func isYesterday() -> Bool {
        formatter_.dateFormat = "yyyy-MM-dd"
        let selfDay = formatter_.string(from: self as Date)
        let nowDay = formatter_.string(from: Date.init())
   
        let selfDate : Date = formatter_.date(from: selfDay)!
        let nowDate : Date = formatter_.date(from: nowDay)!
        
        let cmp1 : DateComponents = calendar_.dateComponents([.year], from: nowDate, to: selfDate)
        let cmp2 : DateComponents = calendar_.dateComponents([.month], from: nowDate, to: selfDate)
        let cmp3 : DateComponents = calendar_.dateComponents([.day], from: nowDate, to: selfDate)
        
        return cmp1.year == 0 && cmp2.month == 0 && cmp3.day == -1
    }
    
    func isThisYear() -> Bool {
        formatter_.dateFormat = "yyyy"
        let selfDay = formatter_.string(from: self as Date)
        let nowDay = formatter_.string(from: Date.init())
        return selfDay == nowDay
    }
}
