//
//  TopicPictureView.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class TopicPictureView: UIView {

    let disposeBag = DisposeBag()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var seeBigButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.rx.event.subscribe(onNext: {[unowned self] _ in
            
            let showVC = ShowPictureController.init(nibName: "ShowPictureController", bundle: nil)
            showVC.topic = self.model
            let controller = UIApplication.shared.keyWindow?.rootViewController
            controller?.present(showVC, animated: true, completion: nil)
            
        }).addDisposableTo(disposeBag)
        imageView?.addGestureRecognizer(tapGesture)
    }
    @IBAction func showPicture(_ sender: Any) {
        let showVC = ShowPictureController.init(nibName: "ShowPictureController", bundle: nil)
        showVC.topic = self.model
        let controller = UIApplication.shared.keyWindow?.rootViewController
        controller?.present(showVC, animated: true, completion: nil)
    }
    
    var model : TopicModel? {
        didSet{
            guard let model = model else {
                return
            }
            if let imageUrl = model.large_image {
                imageView.kf.setImage(with: URL.init(string: imageUrl))
            }else if let imageUrl = model.middle_image {
                imageView.kf.setImage(with: URL.init(string: imageUrl))
            }
            
            if model.bigImage == 0 {
                seeBigButton.isHidden = false
                imageView.contentMode = .scaleAspectFill
            }else{
                seeBigButton.isHidden = true
                imageView.contentMode = .scaleToFill
            }
        }
    }

}
