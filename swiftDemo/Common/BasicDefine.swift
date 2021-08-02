//
//  BasicDefine.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/8/1.
//

import Foundation
import UIKit

//MARK:- 常用字体宏定义
/// 系统普通字体
var gof_SystemFontWithSize: (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size);
}
/// 系统加粗字体
var gof_BoldFontWithSize: (CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: size);
}

/// 仅用于标题栏上，大标题字号
let kNavFont = gof_SystemFontWithSize(18);

/// 标题字号
let kTitleFont = gof_SystemFontWithSize(18);

/// 正文字号
let kBodyFont = gof_SystemFontWithSize(16);

/// 辅助字号
let kAssistFont = gof_SystemFontWithSize(14);

//MARK:- 常用颜色宏定义
/// 根据RGBA生成颜色(格式为：22,22,22,0.5)
var gof_RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

/// 根据RGB生成颜色(格式为：22,22,22)
var gof_RGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
}

/// 根据色值生成颜色(无透明度)(格式为0xffffff)
var gof_ColorWithHex: (Int) -> UIColor = {hex in
    let r: CGFloat = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
    let g: CGFloat = CGFloat(((hex & 0xFF00) >> 8)) / 255.0
    let b: CGFloat = CGFloat((hex & 0xFF)) / 255.0
    var color: UIColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    return color
}
/// 根据色值生成颜色(带透明度)(格式为0xffffff, 0.1)
var gof_AlphaColorWithHex: (Int, CGFloat) -> UIColor = {hex,a in
    let r: CGFloat = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
    let g: CGFloat = CGFloat(((hex & 0xFF00) >> 8)) / 255.0
    let b: CGFloat = CGFloat((hex & 0xFF)) / 255.0
    var color: UIColor = UIColor(red: r, green: g, blue: b, alpha: a)
    return color
}
let a = gof_AlphaColorWithHex(0xFF6666,0.7)
/// 黑色
let kBColor = gof_ColorWithHex(0x000000);
/// 白色
let kWColor = gof_ColorWithHex(0xffffff)
/// 无色
let kCColor = UIColor.clear;
let kG1Color = gof_ColorWithHex(0x323232);
let kG2Color = gof_ColorWithHex(0x646464);
let kG3Color = gof_ColorWithHex(0x969696);
let kG4Color = gof_ColorWithHex(0xc8c8c8); // 仅使用标题栏分割线
let kG5Color = gof_ColorWithHex(0xdcdcdc); // 主页面分割线
let kG6Color = gof_ColorWithHex(0xf0f0f0); // 仅用于背景灰
let kBgColor  = gof_ColorWithHex(0xf8f8f8); // 界面背景颜色
let kHolderTipColor = gof_ColorWithHex(0xafafaf); // 提示：输入框，这个提示语的颜色
let kButtonBlueColor = gof_ColorWithHex(0x41acff);

let kLightColor = gof_ColorWithHex(0x666666);
let kGrayTitleColor = gof_ColorWithHex(0x999999);
let kGrayTipColor = gof_ColorWithHex(0x757575);

let k323232Color = gof_ColorWithHex(0x323232);
let k646464Color = gof_ColorWithHex(0x646464);
let k969696Color = gof_ColorWithHex(0x969696);
let kf0f0f0Color = gof_ColorWithHex(0xf0f0f0);
let kfffc72cColor = gof_ColorWithHex(0xffc72c);

/// 三大色调
let kEssentialColor = gof_ColorWithHex(0x46a0f0);  // 主色调，蓝色
let kAssistOrangeColor = gof_ColorWithHex(0xff8c28);  // 辅色调，橙色
let kAssistGreenColor = gof_ColorWithHex(0x5abe00);  // 辅色调，绿色
//MARK:- 常用变量/方法定义
/**
 打印日志
 
 - parameter message: 日志消息内容
 */
func printLog<T>(message: T)
{
    #if DEBUG
        print(" \(message)");
    #endif
}

// MARK: - 线程队列
/// 主线程队列
let kMainThread = DispatchQueue.main
/// Global队列
let kGlobalThread = DispatchQueue.global()
// MARK: - 系统版本
/// 获取系统版本号
let kSystemVersion = Float(UIDevice.current.systemVersion);
/// 是否IOS7系统
let kIsIOS7OrLater = Int(UIDevice.current.systemVersion) ?? 0 >= 7 ? true : false;

/// 是否IOS8系统
let kIsIOS8OrLater = Int(UIDevice.current.systemVersion) ?? 0 >= 8 ? true : false;
/// 是否IOS9系统
let kIsIOS9OrLater = Int(UIDevice.current.systemVersion) ?? 0 >= 9 ? true : false;

// MARK: - 常用宽高
/// 屏幕Bounds
let kScreenBounds = UIScreen.main.bounds;
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height;
/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width;
/// 导航栏高度
let kNavBarHeight = 44.0;
/// 状态栏高度
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height;
/// Tab栏高度
let kTabBarHeight = 49.0;

//根据图片名称获取图片
let gof_ImageWithName: (String) -> UIImage? = {imageName in
    return UIImage(named: imageName);
}


///1. 获得当前窗口
var ZL_WINDOW: UIWindow? {
    get{
        if let app = UIApplication.shared.delegate as? AppDelegate {
            return app.window
        }
        return nil
    }
}
 
//2. iPhoneX系列
var iphoneX_Series: Bool {
    get {
        
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone{
            debugPrint("不是iPhone， 是 \(UIDevice.current.userInterfaceIdiom.rawValue)")
        }
        
        if #available(iOS 11.0, *) {
            if let bottom = ZL_WINDOW?.safeAreaInsets.bottom , bottom > 0 {
                return true
            }
        } else {
            debugPrint("iOS11 之前的版本")
        }
        return false
    }
}
