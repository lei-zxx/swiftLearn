//
//  HomeViewController.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/7/17.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import MJRefresh
import JXSegmentedView

class SinaNewsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,JXSegmentedListContainerViewListDelegate {
    var listArray:NSMutableArray!
    var count:NSInteger!
    var page:NSInteger!
    
    func listView() -> UIView {
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsTableViewCell = NewsTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "newCell")
        let newsModel:NewsInfoModel = listArray[indexPath.row] as! NewsInfoModel
        cell.setModel(model: newsModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsModel:NewsInfoModel = listArray[indexPath.row] as! NewsInfoModel
        let webVC:WebViewViewController = WebViewViewController()
        webVC.webUrl = newsModel.path
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    var listTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        count = 10
        listArray = NSMutableArray()
        createUI()
        requestData(isPull: true)
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
        self.title = "新闻"
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        listTableView = UITableView()
        listTableView.delegate = self
        listTableView.dataSource = self
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(0)
        }
        
        // 顶部刷新
           let header = MJRefreshNormalHeader()
        // 底部刷新
           let footer = MJRefreshAutoNormalFooter()
        
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        listTableView.mj_footer = footer
        listTableView.mj_header = header
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
        let formatUrl:String = String(format: "https://api.apiopen.top/getWangYiNews?page=%ld&count=%ld", arguments: [page,count])
        if isPull {
            listArray .removeAllObjects()
        }
        AF.request(formatUrl).responseJSON{ [self] response in
//            debugPrint("Response: \(response)")
            switch response.result {
                        case .success:
                            let json = JSON(response.value!)
                            let results = json["result"]
                            for (_,subJson):(String,JSON) in results {
//                                var newsModel:NewsInfoModel!
                               let newsModel = NewsInfoModel(jsonData: subJson)
                                listArray.add(newsModel)
                            }
                            endRefresh()
                            listTableView.reloadData()
                        case .failure:
                            endRefresh()
                            print("failure")
                        }
        }
    }

    func endRefresh() -> Void {
        listTableView.mj_header?.endRefreshing()
        listTableView.mj_footer?.endRefreshing()
    }
}

