//
//  ShowPictureController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/10/3.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class ShowPictureController: UIViewController {

    let disposeBag = DisposeBag()
    var topic : TopicModel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }

        imageView = UIImageView.init()
        imageView?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.rx.event.subscribe(onNext: {[unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        imageView?.addGestureRecognizer(tapGesture)
        scrollView.addSubview(imageView!)
        let height = (topic.height! as NSString).floatValue
        let width = (topic.width! as NSString).floatValue

        let pictureH = screen_width * CGFloat((height / width))
        if pictureH > screen_height {
            imageView?.frame = CGRect.init(x: 0, y: 0, width: screen_width, height: pictureH)
            scrollView.contentSize = CGSize.init(width: 0, height: pictureH)
        }else{
            imageView?.m_size = CGSize.init(width: screen_width, height: pictureH)
            imageView?.m_centerY = screen_height * 0.5
        }
        if let imageUrl = topic.large_image {
            imageView?.kf.setImage(with: URL.init(string: imageUrl))
        }else if let imageUrl = topic.middle_image {
            imageView?.kf.setImage(with: URL.init(string: imageUrl))
        }
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
}
