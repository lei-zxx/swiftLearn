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
import ESPullToRefresh

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var listArray:NSMutableArray!
    var count:NSInteger!
    var page:NSInteger!
    var isPull:Bool!
    
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
        isPull = true
        createUI()
        requestData(isPull: true)
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
        self.title = "新闻"
        listTableView = UITableView()
        listTableView.delegate = self
        listTableView.dataSource = self
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(0)
        }
        listTableView.es.addPullToRefresh {
            [unowned self] in
            page = 1
            requestData(isPull: true)
        }
        
        listTableView.es.addInfiniteScrolling {
            [unowned self] in
            page+=1
            requestData(isPull: false)
            listTableView.es.stopLoadingMore()
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
            listTableView.es.noticeNoMoreData()
        }
    }
   
    func requestData(isPull:Bool) -> Void {
        listArray = NSMutableArray()
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
        listTableView.es.stopPullToRefresh()
        listTableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: true)
    }
}

