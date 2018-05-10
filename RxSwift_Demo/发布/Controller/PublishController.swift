//
//  PublishController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/27.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class PublishController: UIViewController {

    @IBOutlet weak var titleConst: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.isUserInteractionEnabled = false
        self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -500)
       // self.containerView.transform = CGAffineTransformMakeTranslation(0, -500)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 10,
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: { () -> Void in
                                    self.containerView.transform = CGAffineTransform.identity
                                    
        }) { (bool:Bool) -> Void in
            self.view.isUserInteractionEnabled = true
            self.titleConst.constant = 100
        }
    }
    
    // MARK: 取消
    @IBAction func cancel() {
        
        self.view.isUserInteractionEnabled = false
        self.containerView.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration:0.5, animations: { () -> Void in
            self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -500)
            self.titleConst.constant = -140
        }) { (bool:Bool) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        
        
        
    }
    
    
}
