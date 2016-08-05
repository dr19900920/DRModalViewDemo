//
//  String.swift
//  duobao
//
//  Created by dengrui on 16/7/18.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit


extension String {

    /**
     设置属性字符串 浅灰/红
     */
    func lightGrayCustomWithCount(countStr: String) -> NSMutableAttributedString {
        let str = self as NSString
        let range = str.rangeOfString(countStr)
        let attr = NSMutableAttributedString(string: self)
        attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, str.length))
        attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: range)
        return attr
    }


}

/**
 *  正则校验
 */
struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
            options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let matches = regex.matchesInString(input,
            options: [],
            range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

infix operator =~ {
associativity none
precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}