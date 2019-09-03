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
import BATabBarController

class ViewController: UIViewController {
    
    enum DemoTypes {
        case BATabBarWithText
        case BATabBarNoText
    }
    
    var  demotype = DemoTypes.BATabBarNoText
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let testController = BATabBarController()
        var tabBarItem, tabBarItem2, tabBarItem3: BATabBarItem
        
        switch (self.demotype) {
        case .BATabBarWithText:
            let option1 = NSMutableAttributedString(string: "Feed")
            option1.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option1.length))
            tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!, title: option1)
            tabBarItem2 = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!, title: option1)
            tabBarItem3 = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!, title: option1)

        case .BATabBarNoText:
            tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!)
            tabBarItem2 = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!)
            tabBarItem3 = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!)
        }
        

        let badge = BATabBarBadge(value:20, badgeColor: .red)
        tabBarItem2.badge = badge


        let vc1 = UIViewController()
        vc1.view.backgroundColor = .gray
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .black
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        
        testController.delegate = self
        testController.viewControllers = [vc1, vc2, vc3]
        testController.tabBarItems = [tabBarItem,tabBarItem2,tabBarItem3]
        
        
        //OPTIONAL SETTINGS
        
        //initial view controller
//        testController.initialViewController = vc2
        
        //tab bar background color example
        //testController.tabBarBackgroundColor = .black
        
        //tab bar item stroke color example
//        testController.tabBarItemStrokeColor = .blue
        
        //Tab bar line width example
        //testController.tabBarItemLineWidth = 9.0
        
        //Hides the tab bar when true
        //testController.hidesBottomBarWhenPushed = true
        
        self.view.addSubview(testController.view)
    }
    
}

extension ViewController: BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
        print("Delegate success!");
    }
}
