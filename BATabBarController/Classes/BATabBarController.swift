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

public protocol BATabBarControllerDelegate: AnyObject {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController)
}

public class BATabBarController:  UIViewController {
    
    //Delegate for adding actions to tab clicks
    public var delegate: BATabBarControllerDelegate?
    
    //Custom tab bar
    var tabBar: BATabBar?
  
    //View controllers associated with the tabs
    public var viewControllers: [UIViewController] = []  {
        didSet {
            var i = Int(viewControllers.count) - 1
            while i >= 0 {
                let vc = viewControllers[i]
                if let vcView = vc.view, let tabBar = tabBar {
                    self.view.insertSubview(vcView, belowSubview: tabBar)
                }
                i -= 1
            }
        }
    }

    //Items that are displayed in the tab bar
    public var tabBarItems: [BATabBarItem] = [] {
        didSet {
            for i in 1..<tabBarItems.count {
                let item1: BATabBarItem? = tabBarItems[i - 1]
                let item2: BATabBarItem? = tabBarItems[i]
                if (item1?.title != nil && item2?.title == nil) || (item1?.title == nil && item2?.title != nil) {
                    let myException = NSException(name: NSExceptionName("BATabBarControllerException"), reason: "Tabs must have all text or no text", userInfo: nil)
                    print("Error: \(myException)")
                    return
                }
            }
            if let tabBar = tabBar {
                tabBar.tabBarItems = tabBarItems
            }
        }
    }
    
    //Tab Bar Color
    public var tabBarBackgroundColor: UIColor? {
        didSet {
            tabBar?.backgroundColor = tabBarBackgroundColor
        }
    }
    
    //Tab Bar Animation duration
    var tabBarAnimationDuration: CGFloat = 0.0 {
        didSet {
            tabBar?.animationDuration = tabBarAnimationDuration
        }
    }
    
    //TabBarItem's stroke color
    public var tabBarItemStrokeColor: UIColor = .black {
        didSet {
            for i in 0..<tabBarItems.count {
                let item = tabBarItems[i]
                item.strokeColor = tabBarItemStrokeColor
            }
        
            tabBar?.barItemStrokeColor = tabBarItemStrokeColor
        }
    }
    
    //TabBarItem's line width
    public var tabBarItemLineWidth: CGFloat = 0.0 {
        didSet {
            for i in 0..<tabBarItems.count {
                let item = tabBarItems[i]
                item.strokeWidth = tabBarItemLineWidth
            }
            tabBar?.barItemLineWidth = tabBarItemLineWidth
        }
    }
    
    //initial selected view controller
    public var initialViewController: UIViewController?
    

    //Currently selected view controller
    public var selectedViewController: UIViewController? {
        didSet {            
            if let tabBar = tabBar, let delegate = delegate, let selectedViewController = selectedViewController, let selectedViewControllerView = selectedViewController.view {
                view.insertSubview(selectedViewControllerView, belowSubview: tabBar)
                delegate.tabBarController(self, didSelect: selectedViewController)
            }
        }
    }
    
    override public var hidesBottomBarWhenPushed: Bool {
        didSet {
            tabBar?.isHidden = hidesBottomBarWhenPushed
        }
    }
    
    // MARK: - Lifecycle
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = false
        
        // init tab bar
        tabBar = BATabBar()
        if let tabBar = tabBar {
            tabBar.delegate = self
            view.addSubview(tabBar)
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        //make sure we always have a selected tab
        if (selectedViewController == nil) {
            selectedViewController = initialViewController ??  viewControllers[0]
            if let tabBar = tabBar, let selectedViewController = selectedViewController {
                tabBar.selectedTabItem((viewControllers as NSArray).index(of: selectedViewController), animated: false)
            }
        }
    }
    
    public func setSelectedViewController(_ viewController: UIViewController?, animated: Bool) {
        selectedViewController = viewController
        if let viewController = viewController, let tabBar = tabBar {
            let index = (viewControllers as NSArray).index(of: viewController)
            tabBar.selectedTabItem(index, animated: animated)
        }
    }
}

extension BATabBarController: BATabBarDelegate {
    func tabBar(_ tabBar: BATabBar, didSelectItemAt index: Int) {
        selectedViewController = viewControllers[index]
    }
}
