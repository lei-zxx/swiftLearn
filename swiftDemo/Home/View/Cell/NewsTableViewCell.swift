//
//  NewsTableViewCell.swift
//  swiftDemo
//
//  Created by edz on 2021/7/29.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    var pictureImageView:UIImageView! //图像
    var titleLabel:UILabel! //标题
    var timeLabel:UILabel! //时间
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() -> Void {
        pictureImageView = UIImageView()
        pictureImageView.layer.cornerRadius = 5
        pictureImageView.layer.masksToBounds = true
        titleLabel = UILabel()
        titleLabel.font.withSize(14)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        titleLabel.textAlignment = NSTextAlignment.center
        timeLabel = UILabel()
        timeLabel.font.withSize(10)
        timeLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contentView.addSubview(pictureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        
        pictureImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(80)
            make.left.equalTo(15)
            make.centerY.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { (make) ->Void in
            make.left.equalTo(pictureImageView.snp_rightMargin).offset(15)
            make.top.equalTo(pictureImageView)
            make.bottom.equalTo(-40)
            make.right.equalTo(-15)
        }
        
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(pictureImageView)
            make.height.equalTo(20)
            make.right.equalTo(-15)
        }
    }
  public func setModel(model:NewsInfoModel) -> Void {
    titleLabel.text = model.title
    timeLabel.text = model.passtime
    let url = URL(string: model.image!)
    pictureImageView.kf.setImage(with:url?.absoluteURL)
  }
}
