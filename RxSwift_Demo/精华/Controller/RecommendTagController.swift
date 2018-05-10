//
//  RecommendTagController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import RxDataSources
import HandyJSON
import Kingfisher


class RecommendTagController: UITableViewController {

    let provider = MoyaProvider<ApiManager>()
    let dispose = DisposeBag()
    let dataArr = Variable([RecommendTag]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        tableView.register(UINib.init(nibName: "RecommendTagCell", bundle: nil), forCellReuseIdentifier: "recommendTag")
        loadData()
        bindingUI()
    }
    
    func loadData() {
    
        FMProgressHUD.showLoadingHUDAddedTo(view, animated: true)
        provider.rx.request(.getRecommendTag).asObservable()
            .mapArrayModel(RecommendTag.self)
            .subscribe(onNext: {[unowned self] (modelArray) in
                FMProgressHUD.hideAllLoadingHUDsForView(self.view, animated: true)
                self.dataArr.value = modelArray
               
        }).addDisposableTo(dispose)
    }

    func bindingUI() {

        dataArr
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "recommendTag", cellType: RecommendTagCell.self)) {
                row, model, cell in
                cell.theme_nameLabel.text = model.theme_name
                cell.sub_numLabel.text = model.sub_number
                cell.image_listImageView.kf.setImage(with: URL.init(string: model.image_list!))
        }.addDisposableTo(dispose)
    }
}
