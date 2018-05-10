//
//  RootTabBarController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/27.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChild()
        // 统一给所有的UITabBarItem设置文字属性
        let item = UITabBarItem.appearance()
    item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.gray,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: UIControlState.normal)//
    item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.darkGray,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: UIControlState.selected)//
        
        
        /**
         * 处理TabBar 替换成自定义的
         */
        // 会崩溃??????
        //self.setValue(RootTabBar(), forKeyPath: "tabBar")
       // self.setValue(RootTabBar(), forKey: "tabBar")
    }
    func setupChild(){
       let essenVC =  EssenceController()
        essenVC.view.backgroundColor = UIColor.red
        CreationChild(title: "精华", image: "tabBar_essence_icon", selectImage: "tabBar_essence_click_icon", childVC:essenVC )
        
        let newVC =  NewViewController()
        newVC.view.backgroundColor = UIColor.green
        CreationChild(title: "最新", image: "tabBar_new_icon", selectImage: "tabBar_new_click_icon", childVC: newVC)
        
        let TrendsVC =  FriendTrendsController()
        TrendsVC.view.backgroundColor = UIColor.gray
        CreationChild(title: "关注", image: "tabBar_friendTrends_icon", selectImage: "tabBar_friendTrends_click_icon", childVC: TrendsVC)
        
        let meVC =  MeController()
        meVC.view.backgroundColor = UIColor.gray
        CreationChild(title: "我", image: "tabBar_me_icon", selectImage: "tabBar_me_click_icon", childVC: meVC)
        
    }
    
    func CreationChild(title: String , image: String ,selectImage: String , childVC: UIViewController){
        
        //   imageWithRenderingMode不根据系统的样式
        
        
        let nav = RootNavController.init(rootViewController: childVC)
        nav.title = title
        nav.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(nav)
    }
}
