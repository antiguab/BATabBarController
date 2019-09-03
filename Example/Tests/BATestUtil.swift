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

import BATabBarController
import Foundation

class BATestUtil {
    static func createValidTabBarItemsWithTitle() -> [BATabBarItem] {
        let option1 = NSMutableAttributedString(string: "Feed")
        option1.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option1.length))
        let tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!, title: option1)
        let tabBarItem2  = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!, title: option1)
        let tabBarItem3  = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!, title: option1)
        return [tabBarItem, tabBarItem2, tabBarItem3]
    }
    
    static func createValidTabBarItemsWithoutTitle() -> [BATabBarItem] {
        let tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!)
        let tabBarItem2  = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!)
        let tabBarItem3  = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!)
        return [tabBarItem, tabBarItem2, tabBarItem3]
    }
    
    static func createViewControllers() -> [UIViewController] {
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        
        return [vc1, vc2, vc3]
    }
}
