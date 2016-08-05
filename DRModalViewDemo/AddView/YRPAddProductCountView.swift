//
//  YRPAddProductCountView.swift
//  duobao
//
//  Created by dengrui on 16/7/16.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit

class YRPAddProductCountView: UIView {
    
    
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    @IBOutlet weak var countViewBottomCons: NSLayoutConstraint!
    private var count: String = "1"
    var maxCount: Int = 998
    var goodsId: Int = 0
    var periodNo: String!
    var clickIndiana: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dismissBtn.backgroundColor = UIColor(white: 0, alpha: 0.2)
        countTextField.addTarget(self, action: "textFieldEditChange:", forControlEvents: .EditingChanged)
        /// 监听键盘弹出的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @objc private func textFieldEditChange(textField: UITextField) {
        
        if Int(textField.text ?? "0") >= maxCount{
            count = String(maxCount)
        } else if textField.text == "0" || textField.text == "" {
            count = "1"
        } else {
            count = textField.text ?? ""
        }
        setCountLabels()
    }
    
    /// 键盘frame改变要调用的方法,改变选择du注弹窗的坐标
    @objc
    private func keyboardWillChangeFrame(noti: NSNotification){
        let curve = noti.userInfo![UIKeyboardAnimationCurveUserInfoKey]!.integerValue
        let rect = noti.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        /// 获取动画时长
        let duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        countViewBottomCons.constant = rect.size.height
        UIView.animateWithDuration(duration) {
            UIView.setAnimationCurve(UIViewAnimationCurve.init(rawValue: curve)!)
            self.layoutIfNeeded()
        }
        
    }
    
    func keyboardWillHide() {
        countViewBottomCons.constant = 0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layoutIfNeeded()
        })
    }
    
    class func countView() -> YRPAddProductCountView {
        return NSBundle.mainBundle().loadNibNamed("YRPAddProductCountView", owner: nil, options: nil).first as! YRPAddProductCountView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        countTextField.resignFirstResponder()
    }
    
    class func show(maxCount: Int, goodsId: Int, periodNo: String) {
        let v = countView()
        v.maxCount = maxCount
        v.goodsId = goodsId
        v.periodNo = periodNo
        v.dismissBtn.alpha = 0
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(v)
        v.ff_Fill(window!)
        v.layoutIfNeeded()
        v.countViewBottomCons.constant = 0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            v.dismissBtn.alpha = 1
            v.layoutIfNeeded()
            }) { (finish) -> Void in
                
        }
    }
    
    @IBAction func clickBtns(sender: AnyObject) {
        switch sender.tag {
        case 8080:
            count = "5"
        case 8081:
            count = "20"
        case 8082:
            count = "50"
        case 8083:
            count = "100"
        case 8084:
            /**
            减
            */
            if Int(count) == 1 {return}
            count = String(Int(count)! - 1)
        case 8085:
            /**
            加
            */
            if Int(count) == maxCount {return}
            count = String(Int(count)! + 1)
        case 8086:
            /**
            关闭
            */
            count = "0"
            dismiss()
        case 8087:
            /// 立即夺宝
            count = "0"
            dismiss()
        case 8088:
            /**
            点击背景
            */
            count = "0"
            dismiss()
        default:break
        }
        setCountLabels()
    }
    /**
     设置金钱数量
     */
    private func setCountLabels() {
        count = Int(count) <= maxCount ? count : String(maxCount)
        countTextField.text = count
        moneyLabel.attributedText = "共 \(count) 元".lightGrayCustomWithCount("\(count)")
    }
    
    private func dismiss() {
        self.countViewBottomCons.constant = -256
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.dismissBtn.alpha = 0
            self.layoutIfNeeded()
            }) { (finish) -> Void in
                self.removeFromSuperview()
        }
    }
}
