//The MIT License (MIT)
//
//Copyright (c) 2019 Bryan Antigua <antigua.b@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit
import SnapKit

protocol BATabBarDelegate: AnyObject {
     func tabBar(_ tabBar: BATabBar, didSelectItemAt index: Int)
}

class BATabBar: UIView {
    
    enum BATabBarProperties {
        //Standard Tool bar Height
        static let TabBarHeight = 49
        
        //Tab Bar Padding
        static let TabBarPadding = 5
    }

    //Helps when figuring out the order of the tab item without resorting to it's superview
    private let BAUniqueTag: Int = 57690

    //Currently selected Tab
    var currentTabBarItem: BATabBarItem?
    
    //Color of the outline when selected and during animations
    var barItemStrokeColor = UIColor.colorWithHex(0xF23555)
    
    //Width of the outline when selected and during animations
    var barItemLineWidth: CGFloat = 2.0
    
    //Duration of the animations
    var animationDuration: CGFloat = 0.7
    
    //State of constraints
    private var constraintsLoaded = false
    
    //Delegate used to add external action to a tab bar click
    var delegate: BATabBarDelegate?

    //Container for "traversing" from one item to another
    var animationContainer: UIView?
    
    //Container for the tab bar - this is so the toolbar stays the standard height on iphoneX
    var tabBarContainer: UIView?
    
    //Constraint to change height based on safe area insets.Not sure why `updateConstraints` creates two height const instead of replacing. Usng a var here to update manually instead
    var heightConstraint: Constraint?


    //All tabs in the tab bar
    var tabBarItems: [BATabBarItem] = [] {
        didSet {
            updateTabBarItems(tabBarItems)
        }
    }
    
    override func updateConstraints() {
        if(!constraintsLoaded) {
            
            heightConstraint?.deactivate()
            self.snp.makeConstraints { make in
                heightConstraint = make.height.equalTo(BATabBarProperties.TabBarHeight + Int(self.safeAreaInsets.bottom)).constraint
                make.leading.trailing.bottom.equalToSuperview()
            }
            
            //tool bar container constraints
            tabBarContainer?.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(BATabBarProperties.TabBarPadding)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(BATabBarProperties.TabBarHeight)
            }
            
            //container constraints
            animationContainer?.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            //tabBarItem constraints
            for i in 0..<tabBarItems.count {
                let item = tabBarItems[i]
                item.snp.makeConstraints { make in
                    make.width.equalToSuperview().multipliedBy(1/Double(tabBarItems.count))
                    if(i == 0){
                        make.leading.equalToSuperview()
                    } else {
                        let prevItem = tabBarItems[i - 1]
                        make.leading.equalTo(prevItem.snp.trailing)
                    }
                }
            }

            constraintsLoaded = true
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        //tab bar constraints will change depending on orientation
       
        heightConstraint?.deactivate()
        self.snp.makeConstraints { make in
            //SafeAreaInsets seems to set after a couple loops. Not sure why.
            heightConstraint = make.height.equalTo(BATabBarProperties.TabBarHeight + Int(self.safeAreaInsets.bottom)).constraint
        }
    }
    
    // MARK: - Lifecycle
    convenience init() {
        self.init(frame: CGRect.zero)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInit()
    }

    //MARK - IBAction
    @objc func didSelectItem(_ sender: BATabBarItem) {
        let newItem = sender
        if newItem == self.currentTabBarItem {
            return //if it's the same tab, do nothing
        }
        
        isUserInteractionEnabled = false
        currentTabBarItem?.hideOutline()
        transitionToItem(newItem, true)
    }
    
    // MARK: - Public
    func selectedTabItem(_ index: Int, animated: Bool) {
        isUserInteractionEnabled = false
        currentTabBarItem?.hideOutline()
        
        let newItem = tabBarItems[index]
        transitionToItem(newItem, animated)
    }

    
    // MARK: - Private
    func customInit() {
        //set default color
        backgroundColor = UIColor.colorWithHex(0x1C2129)
        
        tabBarContainer = UIView()
        animationContainer = UIView()

        if let tabBarContainer = tabBarContainer, let animationContainer = animationContainer {
            tabBarContainer.backgroundColor = .clear
            addSubview(tabBarContainer)
            
            animationContainer.backgroundColor = .clear
            animationContainer.isUserInteractionEnabled = false
            tabBarContainer.addSubview(animationContainer)
            
            tabBarContainer.translatesAutoresizingMaskIntoConstraints = false
            animationContainer.translatesAutoresizingMaskIntoConstraints = false
        }


        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func updateTabBarItems(_ tabBarItems: [BATabBarItem]) {
        for i in 0..<tabBarItems.count {
            let tabBarItem = tabBarItems[i]
            if let toolBarContainer = tabBarContainer {
                toolBarContainer.addSubview(tabBarItem)
            }
            tabBarItem.tag = Int(BAUniqueTag) + i
            tabBarItem.strokeColor = barItemStrokeColor
            tabBarItem.strokeWidth = barItemLineWidth
            tabBarItem.addTarget(self, action: #selector(didSelectItem(_:)), for: .touchUpInside)
            
            //this is to avoid users pressing down on multiple tab items at once
            tabBarItem.addTarget(self, action: #selector(disableAllButtonsBut(_:)), for: .touchDown)

        }
    }
    
    @objc func disableAllButtonsBut(_ sender: BATabBarItem){
        for i in 0..<tabBarItems.count {
            let tabBarItem = tabBarItems[i]
            if(tabBarItem != sender) {
                tabBarItem.isUserInteractionEnabled = false
            }
        }
    }
    
    func enableAllButtons(){
        for i in 0..<tabBarItems.count {
            tabBarItems[i].isUserInteractionEnabled = true
        }
    }
    
    func transitionToItem(_ newItem: BATabBarItem, _ animated: Bool) {
        let animatingTabTransitionLayer = CAShapeLayer()
        
        currentTabBarItem?.title?.textColor = newItem.title?.textColor
        
        let completionBlock: (() -> Void) = {
            animatingTabTransitionLayer.removeFromSuperlayer()
            animatingTabTransitionLayer.removeAllAnimations()
            self.currentTabBarItem = newItem
            self.currentTabBarItem?.title?.textColor = self.barItemStrokeColor
            self.currentTabBarItem?.showOutline()
            self.isUserInteractionEnabled = true
            self.enableAllButtons()
        }
        
        if(!animated){
            completionBlock()
            return
        }
        
        layoutIfNeeded()
        
        //layer for path transitioning from one tab to the next
        let animatingTabTransitionBezierPath = UIBezierPath()
        animatingTabTransitionLayer.strokeColor = barItemStrokeColor.cgColor
        animatingTabTransitionLayer.fillColor = UIColor.clear.cgColor
        animatingTabTransitionLayer.lineWidth = barItemLineWidth
        
        
        //vars used to determine total length later
        var circumference :CGFloat = 0
        var distanceBetweenTabs :CGFloat = 0
        var totalLength :CGFloat = 0
        
        if  let currentTabBarItem = currentTabBarItem {
            var clockwise = newItem.tag < currentTabBarItem.tag ? true: false

            //Animation When there is no title
            if(currentTabBarItem.title == nil) {
                if let currentInnerTabBarFrame = currentTabBarItem.innerTabBarItem?.frame,
                   let newInnerTabBarFrame = newItem.innerTabBarItem?.frame {
                    //first item's outline
                    animatingTabTransitionBezierPath.addArc(withCenter: currentTabBarItem.center, radius: currentInnerTabBarFrame.width / 2.0, startAngle: .pi / 2, endAngle: .pi, clockwise: clockwise)
                    animatingTabTransitionBezierPath.addArc(withCenter: currentTabBarItem.center, radius: currentInnerTabBarFrame.width / 2.0, startAngle: .pi, endAngle: .pi / 2, clockwise: clockwise)
                    
                    //traveling from one item to the next
                    let origin = currentTabBarItem.convert(CGPoint(x: currentInnerTabBarFrame.midX, y: currentInnerTabBarFrame.maxY), to: animationContainer)
                    let destination = newItem.convert(CGPoint(x: newInnerTabBarFrame.midX, y: newInnerTabBarFrame.maxY), to: animationContainer)
                    animatingTabTransitionBezierPath.move(to: origin)
                    animatingTabTransitionBezierPath.addLine(to: destination)
                    
                    //second item's outline
                    clockwise = newItem.tag < currentTabBarItem.tag ? true : false
                    animatingTabTransitionBezierPath.addArc(withCenter: newItem.center, radius: newInnerTabBarFrame.width / 2.0, startAngle: .pi / 2, endAngle: .pi, clockwise: clockwise)
                    animatingTabTransitionBezierPath.addArc(withCenter: newItem.center, radius: newInnerTabBarFrame.width / 2.0, startAngle: .pi, endAngle: .pi / 2, clockwise: clockwise)
                    
                    //determining total length to see where the animation will begin  and end
                    circumference = 2 * .pi * newInnerTabBarFrame.width / 2.0
                    distanceBetweenTabs = abs(origin.x - destination.x)
                    totalLength = 2 * circumference + distanceBetweenTabs
                }
            } else {
                
                //Animation When there is a title
                if let currentTabBarItemSelectedImage = currentTabBarItem.selectedImageView,
                   let curentTabBarItemUnselectedImage = currentTabBarItem.unselectedImageView,
                    let currentTabBarItemSelectedImageSuperview = currentTabBarItem.selectedImageView?.superview,
                    let newTabBarItemSelectedImage = newItem.selectedImageView,
                    let newTabBarItemUnselectedImage = newItem.unselectedImageView,
                    let newTabBarItemSelectedImageSuperview = newItem.selectedImageView?.superview,
                    let newTabBarItemUnselectedImageSuperview = newItem.unselectedImageView?.superview
                    
                {
                    //need to adjust when there is text
                    //first item's outline
                    animatingTabTransitionBezierPath.addArc(withCenter: currentTabBarItemSelectedImageSuperview.convert(currentTabBarItemSelectedImage.center, to: animationContainer), radius: currentTabBarItemSelectedImage.frame.width / 2.0 + 5.0, startAngle: .pi / 2, endAngle: .pi, clockwise: clockwise)
                    animatingTabTransitionBezierPath.addArc(withCenter: currentTabBarItemSelectedImageSuperview.convert(currentTabBarItemSelectedImage.center, to: animationContainer), radius: currentTabBarItemSelectedImage.frame.width / 2.0 + 5.0, startAngle: .pi, endAngle: .pi / 2, clockwise: clockwise)
                    
                    //traveling from one item to the next
                    let origin = currentTabBarItemSelectedImageSuperview.convert(CGPoint(x: curentTabBarItemUnselectedImage.frame.midX, y: curentTabBarItemUnselectedImage.frame.maxY + 5), to: animationContainer)
                    let destination = newTabBarItemUnselectedImageSuperview.convert(CGPoint(x: newTabBarItemUnselectedImage.frame.midX, y: newTabBarItemUnselectedImage.frame.maxY + 5), to: animationContainer)
                    animatingTabTransitionBezierPath.move(to: origin)
                    animatingTabTransitionBezierPath.addLine(to: destination)
                    
                    
                    //second item's outline
                    clockwise = newItem.tag < currentTabBarItem.tag ? true : false
                    animatingTabTransitionBezierPath.addArc(withCenter: newTabBarItemSelectedImageSuperview.convert(newTabBarItemSelectedImage.center, to: animationContainer), radius: newTabBarItemSelectedImage.frame.width / 2.0 + 5.0, startAngle: .pi / 2, endAngle: .pi, clockwise: clockwise)
                    animatingTabTransitionBezierPath.addArc(withCenter: newTabBarItemSelectedImageSuperview.convert(newTabBarItemSelectedImage.center, to: animationContainer), radius: newTabBarItemSelectedImage.frame.width / 2.0 + 5.0, startAngle: .pi, endAngle: .pi / 2, clockwise: clockwise)
                    
                    //determining total length to see where the animation will begin  and end
                    circumference = 2 * .pi * (newTabBarItemSelectedImage.frame.width / 2.0 + 5)
                    distanceBetweenTabs = abs(origin.x - destination.x)
                    totalLength = 2 * circumference + distanceBetweenTabs
                }
            
            }
        
            //leading and trailing animations
            animatingTabTransitionLayer.path = animatingTabTransitionBezierPath.cgPath

            let leadingAnimation = CABasicAnimation(keyPath: "strokeEnd")
            leadingAnimation.duration = CFTimeInterval(animationDuration)
            leadingAnimation.fromValue = NSNumber(value: 0)
            leadingAnimation.toValue = NSNumber(value: 1)
            leadingAnimation.isRemovedOnCompletion = false
            leadingAnimation.fillMode = .forwards
            leadingAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

            let trailingAnimation = CABasicAnimation(keyPath: "strokeStart")
            trailingAnimation.duration = leadingAnimation.duration - 0.15
            trailingAnimation.fromValue = NSNumber(value: 0)
            trailingAnimation.isRemovedOnCompletion = false
            trailingAnimation.fillMode = .forwards
            trailingAnimation.toValue = (circumference + distanceBetweenTabs) / totalLength
            trailingAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)

            CATransaction.begin()
            let transitionAnimationGroup = CAAnimationGroup()
            transitionAnimationGroup.animations = [leadingAnimation, trailingAnimation]
            transitionAnimationGroup.duration = leadingAnimation.duration
            transitionAnimationGroup.isRemovedOnCompletion = false
            transitionAnimationGroup.fillMode = .forwards
            CATransaction.setCompletionBlock(completionBlock)
            animatingTabTransitionLayer.add(transitionAnimationGroup, forKey: nil)
            CATransaction.commit()


            animationContainer?.layer.addSublayer(animatingTabTransitionLayer)
            
            if let delegate = delegate, let index =  tabBarItems.firstIndex(of: newItem) {
                delegate.tabBar(self, didSelectItemAt: index)
            }

        }
    }
    
}
