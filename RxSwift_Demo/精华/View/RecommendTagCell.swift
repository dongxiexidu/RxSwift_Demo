//
//  RecommendTagCell.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class RecommendTagCell: UITableViewCell {

    @IBOutlet weak var image_listImageView: UIImageView!
    @IBOutlet weak var theme_nameLabel: UILabel!
    @IBOutlet weak var sub_numLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
