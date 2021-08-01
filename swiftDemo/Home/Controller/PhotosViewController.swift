//
//  PhotosViewController.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/8/1.
//

import UIKit
import JXSegmentedView
import SnapKit
import Alamofire
import SwiftyJSON
import MJRefresh


class PhotosViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,JXSegmentedListContainerViewListDelegate {
    var count:NSInteger!
    var page:NSInteger!
    var listArray:NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        count = 10
        page = 1
        listArray = NSMutableArray()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        view.addSubview(collectView)
        collectView.snp.makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(0)
        }
        requestData(isPull: true)
    }
    
    func listView() -> UIView {
        return view
    }
    
    lazy var collectView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: kScreenWidth / 2 - 5, height: kScreenWidth / 2 - 5)
        layout.minimumLineSpacing=5;
        layout.minimumInteritemSpacing=5
//        layout.footerReferenceSize = CGSize(width: kScreenWidth, height: 50)
//        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 50)
        let collectView = UICollectionView.init(frame: CGRect(x: 0.0, y: 0.0, width: 0, height: 0), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.showsVerticalScrollIndicator = true
        collectView.backgroundColor = kBgColor
        collectView.register(PhotoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SwiftCollectionViewCell")
        // 顶部刷新
        let header = MJRefreshNormalHeader()
        // 底部刷新
        let footer = MJRefreshAutoNormalFooter()
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        collectView.mj_footer = footer
        collectView.mj_header = header
        return collectView
    }()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellString = "SwiftCollectionViewCell"
        
        let cell:PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellString, for: indexPath) as! PhotoCollectionViewCell
        let photoModel:PhotoInfoModel = listArray[indexPath.row] as! PhotoInfoModel
        cell.setModel(model: photoModel)
        return cell
    }
    
    // 顶部刷新
    @objc func headerRefresh(){
        page = 1
        requestData(isPull: true)
       }

    // 底部刷新
    @objc func footerRefresh(){
        page+=1
        requestData(isPull: false)
    }
    
    func requestData(isPull:Bool) -> Void {
        let formatUrl:String = String(format: "https://api.apiopen.top/getImages?page=%ld&count=%ld", arguments: [page,count])
        if isPull {
            listArray .removeAllObjects()
        }
        AF.request("https://api.apiopen.top/getImages").responseJSON{ [self] response in
//            debugPrint("Response: \(response)")
            switch response.result {
                        case .success:
                            let json = JSON(response.value!)
                            let results = json["result"]
                            for (_,subJson):(String,JSON) in results {
//                                var newsModel:NewsInfoModel!
                               let newsModel = PhotoInfoModel(jsonData: subJson)
                                listArray.add(newsModel)
                            }
                            endRefresh()
                            collectView.reloadData()
                        case .failure:
                            endRefresh()
                            print("failure")
                        }
        }
    }

    func endRefresh() -> Void {
        collectView.mj_header?.endRefreshing()
        collectView.mj_footer?.endRefreshing()
    }
}
