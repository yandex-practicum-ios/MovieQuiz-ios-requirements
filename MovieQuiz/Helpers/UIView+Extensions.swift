//
//  UIView+Extensions.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 14.04.2024.
//

import UIKit

class UILabelWithPadding: UILabel {
 
@IBInspectable var topInset: CGFloat = 15.0
@IBInspectable var bottomInset: CGFloat = 15.0
@IBInspectable var leftInset: CGFloat = 10.0
@IBInspectable var rightInset: CGFloat = 10.0
 
override func drawTextInRect(rect: CGRect) {
let insets = UIEdgeInsets(top: topInset, left: leftInset,
bottom: bottomInset, right: rightInset)
super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
}
 
override func intrinsicContentSize() -&amp;amp;gt; CGSize {
var intrinsicSuperViewContentSize = super.intrinsicContentSize()
intrinsicSuperViewContentSize.height += topInset + bottomInset
intrinsicSuperViewContentSize.width += leftInset + rightInset
return intrinsicSuperViewContentSize
}
 
}
