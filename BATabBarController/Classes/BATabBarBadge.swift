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

public class BATabBarBadge: UIView {

    enum BABadgeProperties {
        static let  BABadgeHeight: CGFloat = 18.0
        static let BABadgePadding: CGFloat = 5.0
    }
    
    //Badge value for this tab. Setting to nil will always hide it
    public var value: NSNumber? {
        didSet {
            self.updateBadge()
        }
    }
    
    //Badge value text color
    public var textColor: UIColor? 
    
    //Optional badge background color. Set to nil to not draw a background
    public var badgeColor: UIColor?
    
    //Badge stroke color. Set to nil to not draw a stroke
    var strokeColor: UIColor?
    
    //Badge stroke width. Will be ignored if `badgeStrokeColor` is nil
    var strokeWidth: CGFloat?
 
    var attributedValue: NSAttributedString?
    var calculatedAttributedWidth: CGFloat?
    
    //Mark - Lifecycle
    public convenience init(value: NSNumber, badgeColor: UIColor, strokeColor: UIColor?, strokeWidth: CGFloat ) {
        self.init(frame:CGRect(x:0, y: 0, width: BABadgeProperties.BABadgeHeight, height: BABadgeProperties.BABadgeHeight))
        self.badgeColor = badgeColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.value = value
        self.backgroundColor = .clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        updateBadge() //DidSet doeesn't run in init methods
    }
    
    public convenience init(value: NSNumber, badgeColor: UIColor) {
        self.init(value: value, badgeColor: badgeColor, strokeColor: nil, strokeWidth: 0)
    }
    
    //MARK - UIView
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if value == nil {
            return
        }
        
        let bounds: CGRect = self.bounds
        
        let circlePath = UIBezierPath(roundedRect: bounds, cornerRadius: 32.0)
        
        if strokeColor != nil && strokeWidth! > 0 {
            strokeColor?.setStroke()
            circlePath.lineWidth = strokeWidth!
            circlePath.stroke()
        }
        
        if badgeColor != nil {
            badgeColor?.setFill()
            circlePath.fill()
        }
        
        attributedValue?.draw(in: CGRect(x: BABadgeProperties.BABadgePadding, y: 0, width: calculatedAttributedWidth!, height: BABadgeProperties.BABadgeHeight))
    }
    
    //MARK - Private
    func updateBadge() {
        let font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        
        let title = "\(String(describing: value!))"
        
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor ?? .white
        ]
        
        attributedValue = NSAttributedString(string: title, attributes: attributes)
        
        let paragraphRect: CGRect = attributedValue!.boundingRect(with: CGSize(width: 300.0, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        calculatedAttributedWidth = paragraphRect.size.width
        
        var frame: CGRect = self.frame
        frame.size.width = paragraphRect.size.width + 2 * BABadgeProperties.BABadgePadding
        self.frame = frame
        
        setNeedsLayout()
    }
}
