//
//  PhotoCollectionViewCell.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/8/1.
//

import UIKit
import SnapKit
class PhotoCollectionViewCell: UICollectionViewCell {
    var pictureImageView:UIImageView! //图像
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    func createUI() -> Void {
        pictureImageView = UIImageView()
        pictureImageView.backgroundColor = kfffc72cColor
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.layer.masksToBounds = true
        contentView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    public func setModel(model:PhotoInfoModel) -> Void {
      let url = URL(string: model.img!)
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(with: url?.absoluteURL, placeholder: nil, options: nil) { (result) in
            switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    let randomNumber:Int = Int(arc4random() % 100) + 1
                    let formatUrl:String = String(format: "%@?%ld", arguments: [MEI_TU_URL,randomNumber])
                    print(formatUrl)
                    let pUrl = URL(string: formatUrl)
                    self.pictureImageView.kf.setImage(with:pUrl?.absoluteURL)

                    print("Job failed: \(error.localizedDescription)")
                }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
