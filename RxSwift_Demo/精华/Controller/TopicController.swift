//
//  TopicController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/30.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import RxDataSources
import HandyJSON
import Kingfisher


class TopicController: UITableViewController {

    let provider = MoyaProvider<ApiManager>()
    let disposeBag = DisposeBag()
    fileprivate let dataArr = Variable([TopicModel]())
    
    fileprivate var type : TopicType!
    
    var param: String {
        return (self.parent?.isKind(of: NewViewController.self))!  ? "newlist" : "list"
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }

        tableView.register(UINib.init(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        tableView.separatorStyle = .none
        loadNewTopics()
        bindingUI()
    }
    
    convenience init(type: TopicType){
        self.init()
        self.type = type
    }
    
    func bindingUI() {

//        dataArr
//            .asObservable()
//            .bind(to: tableView.rx.items(cellIdentifier: "TopicCell", cellType: TopicCell.self)) {
//                row, model, cell in
//                cell.model = model
//
//            }.addDisposableTo(disposeBag)
        
        dataArr.asDriver().drive(tableView.rx.items(cellIdentifier: "TopicCell", cellType: TopicCell.self)) {
            row, model, cell in
                cell.model = model
            
            }.addDisposableTo(disposeBag)
    }
}

extension TopicController {
    
    func loadNewTopics() {
        FMProgressHUD.showLoadingHUDAddedTo(view, animated: true)
        let types : String = String.init(format:"%zd",self.type.rawValue)
        provider.rx.request(.getTopicsList(a: param, type: types)).asObservable()
        .mapModel(TopicListModel.self)
            .subscribe(onNext: { [unowned self] (listModel) in
                FMProgressHUD.hideAllLoadingHUDsForView(self.view, animated: true)
                //print(topicModel)
                self.dataArr.value = listModel.list!
            })
        .addDisposableTo(disposeBag)
    }
}

extension TopicController {

    // 为什么走3次????
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var model = self.dataArr.value[indexPath.row]
        print(model.cellHeight!)
      //  print(model.contentViewFrame!)
        return model.cellHeight!
    }
}
