//
//  MainViewController.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/7/19.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addAllChildVC()
        modifyTabbar()
    }
    
    func addAllChildVC() -> Void {
        addChildVcWithImg(childVC: HomeViewController(), childTitle: "首页", imageName: "home", selectImageName: "home", index: 0)
        addChildVcWithImg(childVC: FindViewController(), childTitle: "发现", imageName: "home", selectImageName: "home", index: 0)
        addChildVcWithImg(childVC: MessageViewController(), childTitle: "消息", imageName: "home", selectImageName: "home", index: 0)
        addChildVcWithImg(childVC: MeViewController(), childTitle: "我的", imageName: "home", selectImageName: "home", index: 0)
    }
    
    private func addChildVcWithImg(childVC:UIViewController,childTitle:String,imageName:String,selectImageName:String,index:Int) {
        let navigation = UINavigationController(rootViewController: childVC)
        childVC.title = childTitle
        childVC.tabBarItem.tag = index
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChild(navigation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func modifyTabbar() -> Void {
        //设置选中字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.init(red: 247/255.0, green: 195/255.0, blue: 55/255.0, alpha: 1)], for: UIControl.State.selected)
        //设置未选中状态下字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State.normal)
        
        
        //因为tabbar有默认的渲染色，所以要先去掉，否则颜色并不是我们想要的颜色
        UITabBar.appearance().isTranslucent = false
        //之后再设置tabbar的背景色
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.8876147866, green: 0.9399324059, blue: 0.969196856, alpha: 1)
        //下面这个方法可以取消掉htabbar上的灰色线 两个都要写上，缺一不可
        UITabBar.appearance().shadowImage = UIImage.init()
        UITabBar.appearance().backgroundImage = UIImage.init()
    }
    
    /// 这个方法用于设置自定义tabbar
    func loadCustomTabbar() -> Void {
        //先隐藏原生tabbar
        self.tabBar.isHidden = true
        //自定义tabbar
        let lblBG = UILabel.init(frame: CGRect.init(x: 0, y: self.view.frame.height - self.tabBar.frame.height, width: self.view.frame.width, height: self.tabBar.frame.height))
        lblBG.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        self.view.addSubview(lblBG)
        
    }
    /// 修改原生tabbar
}
