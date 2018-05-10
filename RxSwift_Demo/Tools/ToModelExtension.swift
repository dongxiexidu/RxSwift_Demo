//
//  ToModelExtension.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap{ response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
    
    public func mapArrayModel<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap{ response -> Observable<[T]> in
            return Observable.just(response.mapArrayModel(T.self))
        }
    }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)?.description
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
    func mapArrayModel<T: HandyJSON>(_ type: T.Type) -> [T] {
        
        let jsonString = String.init(data: data, encoding: .utf8)?.description
        return JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString)! as! [T]
    }
}
