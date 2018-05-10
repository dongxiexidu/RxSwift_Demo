//
//  TopicVoiceView.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class TopicVoiceView: UIView {
    
    @IBOutlet weak var voiceLengthLabel: UILabel!
    
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
            playCountLabel.text = model.playcount
            let second = NSInteger(model.voicetime!)!%60
            let minute = NSInteger(model.voicetime!)!/60
            voiceLengthLabel.text = "\(minute):\(second)"
        }
    }

}
