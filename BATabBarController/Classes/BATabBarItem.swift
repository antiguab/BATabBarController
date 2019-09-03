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

import Foundation

public class BATabBarItem: UIButton {
    
    enum BATabBarItemProperties {
        static let OutlineRadiusPadding: Double = 5.0
        static let OutlinePadding: Double = 5.0
        static let TitleOffset: Double = 0.0
        static let TabBarHeight: Double = 49.0
        static let IconPaddingNoText: Double = -15.0
        static let IconPaddingWithText: Double = -20.0
    }

    private var constraintsLoaded = false
    
    
    var outerCircleLayer: CAShapeLayer?
    
    //UIView that houses the selected/unselected icons
    var innerTabBarItem: UIView?
    
    //Width of the outline when a tab is selected
    var strokeWidth: CGFloat = 0.0
    
    //Color of the outline and text when a tab is selected
    var strokeColor: UIColor?
    
    //Tab title
    var title: UILabel?
    
    //Image view for an unselected tab
    var unselectedImageView: UIImageView?
    
    //Image view for a selected tab
    var selectedImageView: UIImageView?
    
    //An optional badge to display in the top right corner
    public var badge: BATabBarBadge? {
        willSet {
            if let badge = badge {
                badge.removeFromSuperview()
            }
        }
        
        didSet {
            if let badge = badge {
                self.addSubview(badge)
                setNeedsUpdateConstraints()
            }
        }
    }
    
    convenience public init(image: UIImage, selectedImage: UIImage) {
        self.init()
        customInit(unselectedImage: image, selectedImage: selectedImage)
    }
    
    convenience public init(image: UIImage, selectedImage: UIImage, title: NSAttributedString) {
        self.init()
        
        self.title = UILabel()
        if let titleLabel = self.title {
            titleLabel.attributedText = title
            titleLabel.font = titleLabel.font.withSize(10)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
        }
        
        customInit(unselectedImage: image, selectedImage: selectedImage)
    }
    
    override public func updateConstraints() {
        if(!constraintsLoaded) {
                        
            //tabbar item constraints
            self.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(BATabBarItemProperties.TabBarHeight)
            }
            
            //inner tabbar item constraints
            if let innerTabBarItem = innerTabBarItem {
                innerTabBarItem.translatesAutoresizingMaskIntoConstraints = false
                innerTabBarItem.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(BATabBarItemProperties.OutlinePadding)
                    make.bottom.equalToSuperview().offset(-BATabBarItemProperties.OutlinePadding)
                    make.center.equalToSuperview()
                    make.height.equalTo(innerTabBarItem.snp.width)
                }
            }
            
            //add contraints to images
            addConstraintsToImageViews()
            
            //badge constraints
            if let badge = badge {
                badge.snp.makeConstraints { make in
                    make.centerX.equalTo(self.snp.centerX).offset(Int(badge.bounds.size.width / 2))
                    make.top.equalTo(self.snp.top).offset(-BATabBarItemProperties.OutlinePadding / 2)
                    make.width.equalTo(Int(badge.bounds.size.width))
                    make.height.equalTo(Int(badge.bounds.size.height))
                    
                }
            }
            
            constraintsLoaded = true
        }
        
        super.updateConstraints()
    }
    
    //MARK - Private
    func customInit(unselectedImage: UIImage?, selectedImage: UIImage?) {
        translatesAutoresizingMaskIntoConstraints = false

        //create inner tab bar item
        innerTabBarItem = UIButton()
        selectedImageView = UIImageView(image: selectedImage)
        unselectedImageView = UIImageView(image: unselectedImage)

        
        if let innerTabBarItem = innerTabBarItem, let selectedImageView = selectedImageView, let unselectedImageView = unselectedImageView {
            innerTabBarItem.isUserInteractionEnabled = false //allows for clicks to pass through to the button below
            innerTabBarItem.translatesAutoresizingMaskIntoConstraints = false
            addSubview(innerTabBarItem)

            
            //create selected icon
            selectedImageView.contentMode = .scaleAspectFit
            selectedImageView.translatesAutoresizingMaskIntoConstraints = false
            innerTabBarItem.addSubview(selectedImageView)
            
            //create unselected icon
            unselectedImageView.contentMode = .scaleAspectFit
            unselectedImageView.translatesAutoresizingMaskIntoConstraints = false
            innerTabBarItem.addSubview(unselectedImageView)
        }
        
    }
    
    func addConstraintsToImageViews() {
        if let title = title {
            innerTabBarItem?.addSubview(title)

            //title constraints
            if let superview = title.superview, let unselectedImageView = unselectedImageView {
                title.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(superview.superview!.snp.bottom).offset(-BATabBarItemProperties.TitleOffset)
                    make.top.equalTo(unselectedImageView.snp.bottom).offset(BATabBarItemProperties.TitleOffset)
                }
            }
            
            //selected images contraints
            if let selectedImageView = selectedImageView {
                selectedImageView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(BATabBarItemProperties.TitleOffset)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(BATabBarItemProperties.IconPaddingWithText)
                    make.height.equalToSuperview().offset(BATabBarItemProperties.IconPaddingWithText)
                }
            }
            
            //unselected images constraints
            if let unselectedImageView = unselectedImageView {
                unselectedImageView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(BATabBarItemProperties.TitleOffset)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(BATabBarItemProperties.IconPaddingWithText)
                    make.height.equalToSuperview().offset(BATabBarItemProperties.IconPaddingWithText)
                }
            }
        } else {
            //selected images contraints
            if let selectedImageView = selectedImageView {
                selectedImageView.snp.makeConstraints { make in
                    
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().offset(BATabBarItemProperties.IconPaddingNoText)
                    make.height.equalToSuperview().offset(BATabBarItemProperties.IconPaddingNoText)
                }
            }
            
            if let unselectedImageView = unselectedImageView {
                unselectedImageView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().offset(BATabBarItemProperties.IconPaddingNoText)
                    make.height.equalToSuperview().offset(BATabBarItemProperties.IconPaddingNoText)
                }
            }
        }
    }
    
    func showOutline() {
        //redraws in case constraints have changed
        outerCircleLayer?.removeFromSuperlayer()
        outerCircleLayer = CAShapeLayer()

        //path for the outline
        let outerCircleBezierPath: UIBezierPath! = UIBezierPath()
        if let unselectedImageView = unselectedImageView {
            let outlineRadius: Double

            if(title != nil) {
                outlineRadius = Double(unselectedImageView.frame.width) / 2.0 + Double(BATabBarItemProperties.OutlineRadiusPadding)
            } else {
                outlineRadius = Double((unselectedImageView.frame.width - CGFloat(BATabBarItemProperties.IconPaddingNoText))) / 2.0
            }
            outerCircleBezierPath.addArc(withCenter: unselectedImageView.center, radius: CGFloat(outlineRadius), startAngle: .pi / 2, endAngle: .pi, clockwise: false)
            outerCircleBezierPath.addArc(withCenter: unselectedImageView.center, radius: CGFloat(outlineRadius), startAngle: .pi, endAngle: .pi / 2, clockwise: false)
        }
    
        //adding custom color and stroke
        if let outerCircleLayer = outerCircleLayer {
            outerCircleLayer.path = outerCircleBezierPath.cgPath
            outerCircleLayer.strokeColor = strokeColor?.cgColor
            outerCircleLayer.fillColor = UIColor.clear.cgColor
            outerCircleLayer.lineWidth = strokeWidth
            innerTabBarItem?.layer.addSublayer(outerCircleLayer)
        }


        //fade in icon color
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        unselectedImageView?.alpha = 0.0
        UIView.commitAnimations()
    }
    
    func hideOutline() {
        //if showing then hide
        if let outerCircleLayer = outerCircleLayer {
            outerCircleLayer.removeFromSuperlayer()
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.1)
            unselectedImageView?.alpha = 1.0
            UIView.commitAnimations()
        }
    }
}
