//
//  Test.swift
//  RCA
//
//  Created by Ashok Gupta on 22/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

final class ConcealingTitleView: UIView {
    private let label = UILabel()
    private var contentOffset: CGFloat = 0 {
        didSet {
            label.frame.origin.y = titleVerticalPositionAdjusted(by: contentOffset)
        }
    }
    var text: String = "" {
        didSet {
            label.text = text
            label.textColor = UIColor.black
           // label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            label.font = UIFont(name: "OpenSans-SemiBold", size: 17)
            setNeedsLayout()
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        clipsToBounds = true
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        sizeToFit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if #available(iOS 11.0, *) {
            return super.sizeThatFits(size)
        } else {
            let height = (typedSuperview() as? UINavigationBar)?.bounds.height ?? 0.0
            let labelSize = label.sizeThatFits(CGSize(width: size.width, height: height))
            return CGSize(width: min(labelSize.width, size.width), height: height)
        }
    }
    
    private func layoutSubviews_10() {
        guard let navBar = typedSuperview() as? UINavigationBar else { return }
        let center = convert(navBar.center, from: navBar)
        let size = label.sizeThatFits(bounds.size)
        let x = max(bounds.minX, center.x - size.width * 0.5)
        let y: CGFloat
        
        if contentOffset == 0 {
            y = bounds.maxY
        } else {
            y = titleVerticalPositionAdjusted(by: contentOffset)
        }
        
        label.frame = CGRect(x: x, y: y, width: min(size.width, bounds.width), height: size.height)
    }
    
    private func layoutSubviews_11() {
        let size = label.sizeThatFits(bounds.size)
        let x: CGFloat
        let y: CGFloat
        
        x = bounds.midX - size.width * 0.5
        
        if contentOffset == 0 {
            y = bounds.maxY
        } else {
            y = titleVerticalPositionAdjusted(by: contentOffset)
        }
        
        label.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11.0, *) {
            layoutSubviews_11()
        } else {
            layoutSubviews_10()
        }
    }
    
    // MARK:
    
    /// Using the UIScrollViewDelegate it moves the inner UILabel to move up and down following the scroll offset.
    ///
    /// - Parameters:
    ///   - scrollView: The scroll-view object in which the scrolling occurred.
    ///   - threshold: The minimum distance that must be scrolled before the title view will begin scrolling up into view
    func scrollViewDidScroll(_ scrollView: UIScrollView, threshold: CGFloat = 0) {
        contentOffset = scrollView.contentOffset.y - threshold
    }
    
    // MARK: Private
    
    private func titleVerticalPositionAdjusted(by yOffset: CGFloat) -> CGFloat {
        let midY = bounds.midY - label.bounds.height * 0.5
        return max(bounds.maxY - yOffset, midY).rounded()
    }
}

private extension UIView {
    func typedSuperview<T: UIView>() -> T? {
        var parent = superview
        
        while parent != nil {
            if let view = parent as? T {
                return view
            } else {
                parent = parent?.superview
            }
        }
        
        return nil
    }
}
