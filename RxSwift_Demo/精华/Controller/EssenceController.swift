//
//  EssenceController.swift
//  RxSwift_Demo
//
//  Created by fashion on 2017/9/27.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class EssenceController: UIViewController {

    var scrollView = UIScrollView()
    //标签栏
    var titlesView = UIView()
    var titleButton = UIButton()
    
    //选中的button
    var selectedTitleButton = UIButton()
    
    //红色标签栏
    var titleBottomView = UIView()
    
    //存放按钮的数组
    lazy var titleButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        setupChildController()
        setupScrollView()
        setupTitlesView()
    }
    fileprivate func setupChildController() {
        // 全部 控制器
        let allController = TopicController.init(type: TopicType.all)
        allController.title = "全部"
        self.addChildViewController(allController)
        
        // 声音 控制器
        let videoController = TopicController.init(type: TopicType.video)
        videoController.title = "视频"
        self.addChildViewController(videoController)
        
        // 声音 控制器
        let voiceController = TopicController.init(type: TopicType.voice)
        voiceController.title = "声音"
        self.addChildViewController(voiceController)
        
        // 图片 控制器
        let pictureController = TopicController.init(type: TopicType.picture)
        pictureController.title = "图片"
        self.addChildViewController(pictureController)
        
        // 段子 控制器
        let wordController = TopicController.init(type: TopicType.word)
        wordController.title = "段子"
        self.addChildViewController(wordController)
    }
    
    //创建scrollView 将子控制的Tabview添加到scrollView上
    func setupScrollView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.frame = self.view.bounds
        scrollView.backgroundColor = XYScrollColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize.init(width: CGFloat(childViewControllers.count) * screen_width, height: 0)
        self.view.addSubview(scrollView)
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func setupTitlesView(){
        
        // 标签栏整体
        titlesView.backgroundColor = XYColor
        titlesView.frame = CGRect.init(x: 0, y: XYNavBarMaxY, width: screen_width, height: XYTitlesViewH)
        self.view.addSubview(titlesView)
        
        // 标签栏内部的标签按钮
        let count = childViewControllers.count
        let titleButtonH:CGFloat = titlesView.m_height
        let titleButtonW:CGFloat = titlesView.m_width / CGFloat(count)
        for i in 0..<count {
            let titleButton = UIButton()
            // frame
            titleButton.m_y = 0;
            titleButton.m_height = titleButtonH
            titleButton.m_width = titleButtonW
            titleButton.m_x = CGFloat(i) * titleButton.m_width
            
            titleButton.setTitleColor(UIColor.darkGray, for:.normal)
            titleButton.setTitleColor(UIColor.red, for:.selected)
            titleButton.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
            //文字
            titleButton.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            titleButton.setTitle(childViewControllers[i].title!, for:.normal)
            
            titlesView.addSubview(titleButton)
            
            //添加到数组中
            titleButtons.append(titleButton)
            self.titleButton = titleButton
        }
        // 标签栏底部的指示器控件
        titleBottomView.backgroundColor = titleButtons.last?.titleColor(for: .selected)
        titleBottomView.m_height = 2
        titleBottomView.m_y = titlesView.m_height - titleBottomView.m_height
        titlesView.addSubview(titleBottomView)
        
        // 默认点击最前面的按钮
        let firstTitleButton = titleButtons.first
        firstTitleButton!.titleLabel!.sizeToFit()
        titleBottomView.m_width = firstTitleButton!.titleLabel!.m_width;
        titleBottomView.m_centerX = firstTitleButton!.m_centerX;
        titleClick(titlebut: firstTitleButton!)
    }
    
    
    //按钮点击
    @objc func titleClick(titlebut: UIButton){
        // 控制按钮状态
        selectedTitleButton.isSelected = false
        titlebut.isSelected = true
        self.selectedTitleButton = titlebut
        // 底部控件的位置和尺寸
        UIView.animate(withDuration: 0.25) { () -> Void in
            self.titleBottomView.m_width = titlebut.titleLabel!.m_width
            self.titleBottomView.m_centerX = titlebut.m_centerX
        }
        
        // 让scrollView滚动到对应的位置
        var offset = self.scrollView.contentOffset
        offset.x = screen_width * CGFloat(titleButtons.index(of: titlebut)!)
        self.scrollView.setContentOffset(offset, animated: true)
    }

    
    fileprivate func setupNav() {
        self.navigationItem.titleView = UIImageView.init(image: #imageLiteral(resourceName: "MainTitle"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "MainTagSubIcon", highlightedImage: "MainTagSubIconClick", target: self, action: #selector(tagClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "MainTagSubIcon", highlightedImage: "MainTagSubIconClick", target: self, action: #selector(rightTagClick))
    }
    
    // 点击左上角推荐标签按钮
    @objc fileprivate func tagClick() {
        self.navigationController?.pushViewController(RecommendTagController(), animated: true)
    }
    // 点击右上角推荐标签按钮
    @objc fileprivate func rightTagClick() {
        let sb = UIStoryboard.init(name: "AdvertScollViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AdvertScollViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension EssenceController : UIScrollViewDelegate{

    /**
     当滚动动画完毕的时候调用
     */
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        // 取出对应的子控制器
        let index = scrollView.contentOffset.x / scrollView.m_width;
        let willShowChildVc = childViewControllers[Int(index)] as? UITableViewController
        
        // 添加子控制器的view到scrollView身上
        willShowChildVc!.view.frame = scrollView.bounds;
        //设置内边距
        let top = XYNavBarMaxY + XYTitlesViewH
        let bottom:CGFloat = 44.0
        willShowChildVc!.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        willShowChildVc!.tableView.scrollIndicatorInsets = willShowChildVc!.tableView.contentInset;
        scrollView.addSubview(willShowChildVc!.view)
    }
    /**
     * 当减速完毕的时候调用
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        //scrollView移动的位置获取相对于点击的按钮
        let index = scrollView.contentOffset.x / scrollView.m_width;
        titleClick(titlebut: titleButtons[Int(index)])
    }

}

