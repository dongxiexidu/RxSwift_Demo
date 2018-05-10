//
//  TopicCell.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import Kingfisher

class TopicCell: UITableViewCell {
    
    

    @IBOutlet weak var profileImageV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatTimeLabel: UILabel!
    @IBOutlet weak var dingButton: UIButton!
    @IBOutlet weak var caiButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var sinaVImageView: UIImageView!
    @IBOutlet weak var text_label: UILabel!
    @IBOutlet weak var topCommentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    /** 图片模块中间图片 */
    lazy var pictureView: TopicPictureView = {
        let pictureView = Bundle.main.loadNibNamed("TopicPictureView", owner: self, options: nil)?.first as! TopicPictureView
        self.contentView.addSubview(pictureView)
        return pictureView
    }()
    
    /** 声音模块中间图片 */
    lazy var voiceView: TopicVoiceView = {
        let voiceView = Bundle.main.loadNibNamed("TopicVoiceView", owner: self, options: nil)?.first as! TopicVoiceView
        self.contentView.addSubview(voiceView)
        return voiceView
    }()
    
    /** 视频模块中间图片 */
    lazy var videoView: TopicVideoView = {
        let videoView = Bundle.main.loadNibNamed("TopicVideoView", owner: self, options: nil)?.first as! TopicVideoView
        self.contentView.addSubview(videoView)
        return videoView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundView = UIImageView.init(image: #imageLiteral(resourceName: "mainCellBackground"))
    }
    
    
    var model : TopicModel? {
        didSet{
            guard let model = model else {
                return
            }
            if let isSina_v = model.sina_v {
                sinaVImageView.isHidden = !isSina_v
            }else{
                sinaVImageView.isHidden = true
            }
            
            profileImageV.kf.setImage(with: URL.init(string: model.profile_image!))
            nameLabel.text = model.name
            text_label.text = model.text
            creatTimeLabel.text = model.create_at
            
            //底部
            setToolBut(toolBut: dingButton, numberBut: model.ding!, titleBut: "顶")
            setToolBut(toolBut: caiButton, numberBut: model.cai!, titleBut: "踩")
            setToolBut(toolBut: shareButton, numberBut: model.repost!, titleBut: "分享")
            setToolBut(toolBut: commentButton, numberBut: model.comment!, titleBut: "评论")
            
            if model.type == TopicType.picture {
                pictureView.isHidden = false
                pictureView.model = model
                if let frame = model.contentViewFrame {
                    pictureView.frame = frame
                }
                voiceView.isHidden = true
                videoView.isHidden =  true
                
                
            }else if model.type == TopicType.voice{
                voiceView.isHidden = false
                voiceView.model = model
                if let frame = model.contentViewFrame {
                    voiceView.frame = frame
                }
                pictureView.isHidden = true
                videoView.isHidden =  true
                
            }else if model.type == TopicType.video{
                videoView.isHidden =  false
                videoView.model = model
                if let frame = model.contentViewFrame {
                    videoView.frame = frame
                }
                
                pictureView.isHidden = true
                voiceView.isHidden = true
                
            }else if model.type == TopicType.word{
                pictureView.isHidden = true
                voiceView.isHidden = true
                videoView.isHidden =  true
                
            }
            
            if let comment = model.top_cmt?.first{
                topCommentView.isHidden = false
                contentLabel.text = (comment.user?.username)! + " : " + comment.content!
            }else{
                topCommentView.isHidden = true
            }
            
        }
    }

    
    func setToolBut(toolBut: UIButton,numberBut: String , titleBut:String){
        
        if Int(numberBut)! >= 10000{
            let str = String(format: "%.1f万", Double(numberBut)!/10000.0)
            toolBut.setTitle(str, for: .normal)
        }else if Int(numberBut)! > 0{
            toolBut.setTitle("\(Int(numberBut)!)", for: .normal)
        }else{
            toolBut.setTitle(titleBut, for: .normal)
        }
    }
    
//   override var frame: CGRect {
//        didSet{
//            var newFrame = frame
//            newFrame.size.height -= -kMargin
//            newFrame.origin.y += kMargin
//            super.frame = newFrame
//        }
//    }
    
}
