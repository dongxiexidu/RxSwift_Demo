//
//  RootNavController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/27.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class RootNavController: UINavigationController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar.appearance()
        navBar.tintColor = UIColor.black
        self.interactivePopGestureRecognizer?.delegate = self
            //as! UIGestureRecognizerDelegate
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if (self.viewControllers.count>0){
            
            viewController.hidesBottomBarWhenPushed = true
            let button = UIButton.init(type: .custom)
            button.setImage(UIImage.init(named: "navigationButtonReturn"), for: .normal)
            button.setImage(UIImage.init(named: "navigationButtonReturnClick"), for: .highlighted)
            button.setTitle("返回", for: .normal)
            button.setTitleColor(UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1), for: .normal)
            button.setTitleColor(UIColor.red, for: .highlighted)
            button.addTarget(self, action: #selector(self.close), for: .touchUpInside)
            button.frame.size = CGSize(width: 100, height: 30)
            //  button 里的内容左对齐
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func close(){
        self.popViewController(animated: true)
    }
    // 状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1
    }
}
