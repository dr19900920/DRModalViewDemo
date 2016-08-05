//
//  YRPShareView.swift
//  duobao
//
//  Created by dengrui on 16/7/16.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height

private let kShareViewItemW: CGFloat = 63.0
private let kShareViewMargin: CGFloat = 25.0
private let kShareViewItemMargin: CGFloat = (kScreenWidth - 2 * kShareViewMargin - 4 * kShareViewItemW) * 0.33

enum YRPShareViewType: Int {
    case Dismiss = 8090
    case WeChat = 8091
    case Circle = 8092
    case QQ = 8093
    case QZone = 8094
}

class YRPShareView: UIView {

    @IBOutlet weak var QZoneBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var shareView: UIView!
    /// QZone顶部约束
    @IBOutlet weak var QZoneTopMargin: NSLayoutConstraint!
    /// QZone右部约束
    @IBOutlet weak var QZoneRight: NSLayoutConstraint!
    /// QQ右部约束
    @IBOutlet weak var QQRightMargin: NSLayoutConstraint!
    /// 朋友圈中心约束
    @IBOutlet weak var circleCenter: NSLayoutConstraint!
    /// shareView底部约束
    @IBOutlet weak var shareViewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var shareViewHeightCons: NSLayoutConstraint!
    var params: Dictionary<String, AnyObject>?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if kScreenHeight == 667 || kScreenHeight == 736 {
            circleCenter.constant = -(kShareViewItemMargin + kShareViewItemW) * 0.5
            QQRightMargin.constant = kShareViewMargin + kShareViewItemMargin + kShareViewItemW
            QZoneTopMargin.constant = 23
            QZoneRight.constant = kShareViewMargin
            shareViewHeightCons.constant = 180
        } else {
            shareViewHeightCons.constant = 260
            QZoneRight.constant = kScreenWidth - kShareViewItemW - kShareViewMargin
        }
        dismissBtn.backgroundColor = UIColor(white: 0, alpha: 0.2)
        shareView.backgroundColor = UIColor(white: 1, alpha: 0.8)
    }

    class func showWithParams(params: Dictionary<String, AnyObject>) {
        let v = creatView()
        v.params = params
        v.dismissBtn.alpha = 0
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(v)
        v.ff_Fill(window!)
        v.layoutIfNeeded()
        v.shareViewBottomCons.constant = 0
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            v.dismissBtn.alpha = 1
            v.layoutIfNeeded()
            }) { (finish) -> Void in
                
        }
    }

    class func creatView() -> YRPShareView {
        return NSBundle.mainBundle().loadNibNamed("YRPShareView", owner: nil, options: nil).first as! YRPShareView
    }
    
    @IBAction func clickBtns(sender: AnyObject) {
        switch YRPShareViewType(rawValue: sender.tag)! {
        case .Dismiss:
            dismiss()
        case .WeChat:
            shareWithPlatform(22)
        case .Circle:
            shareWithPlatform(23)
        case .QQ:
            shareWithPlatform(24)
        case .QZone:
            shareWithPlatform(6)
        }
        
    }
    /**
     分享
     */
    private func shareWithPlatform(platformNum:UInt) {
//        let dict = NSMutableDictionary()
//        let text = params!["text"] as! String
//        let imageString = params!["image"] as! String
//        let urlString = params!["url"] as! String
//        let title = params!["title"] as! String
//        let url = NSURL(string: urlString)!
//        let data = NSData(contentsOfURL: NSURL(string: imageString)!)
//        let image = UIImage(data: data!)
//        dict.SSDKSetupShareParamsByText(text, images: image, url: url, title: title, type: SSDKContentType.WebPage)
        
//        ShareSDK.share(SSDKPlatformType(rawValue: platformNum)!, parameters: dict, onStateChanged: { (state, dict, entity, error) -> Void in
//            /**
//            分享状态未处理
//            */
//            switch state {
//            case .Success:
//                SVProgressHUD.showSuccessWithStatus("分享成功")
//            default:
//                SVProgressHUD.showErrorWithStatus("分享失败")
//            }
//        })
    }
    
    private func dismiss() {
        self.shareViewBottomCons.constant = -260
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.dismissBtn.alpha = 0
            self.layoutIfNeeded()
            }) { (finish) -> Void in
                self.removeFromSuperview()
        }
    }
}
