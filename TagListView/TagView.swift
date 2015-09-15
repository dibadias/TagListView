//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class TagView: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    @IBInspectable var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            setTitleColor(textColor, forState: UIControlState.Normal)
        }
    }
    @IBInspectable var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    @IBInspectable var paddingXLeft: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingXLeft
        }
    }
    @IBInspectable var paddingXRight: CGFloat = 5 {
        didSet {
            titleEdgeInsets.right = paddingXRight
        }
    }
    @IBInspectable public var tagBackgroundColor: UIColor = UIColor.grayColor() {
        didSet {
            backgroundColor = tagBackgroundColor
        }
    }
    
    @IBInspectable public var tagSelectedBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            backgroundColor = selected ? tagSelectedBackgroundColor : tagBackgroundColor
        }
    }
    
    var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            titleLabel?.font = textFont
        }
    }
    
    override public var selected: Bool {
        didSet {
            if selected {
                backgroundColor = tagSelectedBackgroundColor
            } else {
                backgroundColor = tagBackgroundColor
            }
        }
    }
    
    /// Handles Tap (TouchUpInside)
    public var onTap: ((TagView) -> Void)?
    public var closeImage:String?
    
    // MARK: - init
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    init(title: String) {
        super.init(frame: CGRectZero)
        setTitle(title, forState: UIControlState.Normal)
        
//        setupView()
    }
    
    private func setupView() {
        frame.size = intrinsicContentSize()
    }
    
    // MARK: - layout
    
    override public func intrinsicContentSize() -> CGSize {
        var size = titleLabel?.text?.sizeWithAttributes([NSFontAttributeName: textFont]) ?? CGSizeZero

        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingXRight * 2

        if let image = closeImage {
            size.width += 30
            self.addSubview(imageCloseSymbol(size, imageString: image))
        }

        return size
    }

    func imageCloseSymbol(size: CGSize, imageString:String) -> UIView{
        
        let containerView = UIView(frame: CGRect(x: size.width-20, y: 0, width: 20, height: size.height))
        
        let imageCloseSymbol = UIImage(named: imageString)
    
        let imageViewClose = UIImageView(image: imageCloseSymbol)
        imageViewClose.frame = CGRect(x: containerView.frame.width/2-8, y: containerView.frame.height/2-8, width: 16, height: 16)
        
        containerView.addSubview(imageViewClose)
        
        return containerView;
        
    }
}
