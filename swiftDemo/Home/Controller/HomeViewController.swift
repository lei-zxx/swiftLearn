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

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var listArray:NSMutableArray!
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
    
    var listTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        requestData()
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
    }
   
    func requestData() -> Void {
        listArray = NSMutableArray()
        AF.request("https://api.apiopen.top/getWangYiNews").responseJSON{ [self] response in
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
                            listTableView.reloadData()
                        case .failure:
                            print("failure")
                        }
        }
    }

}

