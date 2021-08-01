//
//  SinaNewsViewController.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/8/1.
//

import UIKit
import JXSegmentedView
import SnapKit
class HomeViewController: UIViewController {
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        //直接隐藏bar
        navigationController?.setNavigationBarHidden(true, animated: false)

        //1、初始化JXSegmentedView
        segmentedView = JXSegmentedView()

        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = getTitles()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = segmentedDataSource

        //3、配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        segmentedView.indicators = [indicator]

        //4、配置JXSegmentedView的属性
        view.addSubview(segmentedView)

        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)

        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.listContainer = listContainerView

        //布局子控件,
        segmentedView.snp.makeConstraints { (make) in
            //tab的宽度等于屏幕宽度
            make.width.equalToSuperview()
            //tab高度50
            make.height.equalTo(50)
            //tab的顶部,在安全区顶部
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        listContainerView.snp.makeConstraints { (mm) in
            //可以滑动的容器,在tab的下面,宽度屏幕宽,底部在安全区的最下边
            mm.top.equalTo(segmentedView.snp.bottom)
            mm.width.equalToSuperview()
            mm.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
 }

    @objc func reloadData() {
        segmentedDataSource.titles = getTitles()
        segmentedView.defaultSelectedIndex = 1
        segmentedView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func getTitles() -> [String] {
        let titles = ["网易", "腾讯","美图"]
      
        return titles
    }
}

extension HomeViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        //tab的总个数
        return segmentedDataSource.dataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        //当切换的时候,加载不同的页面
        if index == 0 {
            return SinaNewsViewController()
        }else if index == 1 {
            return TencentNewsViewController()
        }
        return PhotosViewController()
    }
}
