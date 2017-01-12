//The MIT License (MIT)
//
//Copyright (c) 2016 Bryan Antigua <antigua.b@gmail.com>
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

#import <UIKit/UIKit.h>
#import "BATabBarItem.h"
#import "BATabBar.h"

@protocol BATabBarControllerDelegate;

@interface BATabBarController : UIViewController<BATabBarDelegate>


/**
 Custom tab bar
 */
@property (nonatomic, strong) BATabBar* tabBar;

/**
 View controllers associated with the tabs
 */
@property (strong, nonatomic) NSArray<__kindof UIViewController *> *viewControllers;


/**
 Delegate for adding actions to tab clicks
 */
@property (weak, nonatomic) id<BATabBarControllerDelegate> delegate;

/**
 Items that are displayed in the tab bar
 */
@property (strong, nonatomic) NSArray<__kindof BATabBarItem *> *tabBarItems;

/**
 Tab Bar Color
 */
@property (strong, nonatomic) UIColor* tabBarBackgroundColor;

/**
 TabBarItem's stroke color
 */
@property (strong, nonatomic) UIColor* tabBarItemStrokeColor;

/**
 TabBarItem's line width
 */
@property (assign, nonatomic) CGFloat tabBarItemLineWidth;

/**
 Currently selected view controller
 */
@property (strong, nonatomic) UIViewController* selectedViewController;


/**
 Hides the bar when pushed
 */
@property (nonatomic) BOOL hidesBottomBarWhenPushed;

/**
 Set the view controller that will initally be in the selected state, and animates to that state if desired
 
 @param viewController
 View controller in the viewcontrollers array to be selected
 @param animated
 Used to determine if we should animate to this tab
 */
- (void)setSelectedViewController:(UIViewController*)viewController animated:(BOOL)animated;

@end


@protocol BATabBarControllerDelegate <NSObject>

/**
 Delegate method used to add external actions to a tab click
 
 @param tabBarController
 Tab bar controller housing all tabs, views, and controllers
 @param viewController
 Specific view controller chosen
 */
- (void)tabBarController:(BATabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end
