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

#import "BATabBarController.h"
#import "BATabBar.h"
#import "BATabBarItem.h"
#import "Masonry.h"


@implementation BATabBarController


#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    
    if (self) {
        
        //default values
        _hidesBottomBarWhenPushed = NO;

        // init tab bar
        self.tabBar = [[BATabBar alloc] init];
        self.tabBar.delegate = self;
        [self.view addSubview:self.tabBar];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    //make sure we always have a selected tab 
    if (!self.selectedViewController) {
        self.selectedViewController = [self.viewControllers objectAtIndex:0];
        [self.tabBar selectedTabItem:0 animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors

- (void)setTabBarItems:(NSArray<__kindof BATabBarItem *> *)tabBarItems {
    
    bool same = YES;
    
    for(int i = 1; i < tabBarItems.count; i++) {
        BATabBarItem* item1 = tabBarItems[i-1];
        BATabBarItem* item2 = tabBarItems[i];
        if ((item1.title && !item2.title) || (!item1.title && item2.title)) {
            same = NO;
            
            NSException* myException = [NSException
                                        exceptionWithName:@"BATabBarControllerException"
                                        reason:@"Tabs must have all text or no text"
                                        userInfo:nil];
            NSLog(@"%@",myException);
            @throw myException;
            return;
        }
    }
    
    _tabBarItems = tabBarItems;
    self.tabBar.tabBarItems = tabBarItems;
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    _hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    self.tabBar.hidden = hidesBottomBarWhenPushed;
}

- (void)setTabBarBackgroundColor:(UIColor *)tabBarBackgroundColor {
    _tabBarBackgroundColor = tabBarBackgroundColor;
    self.tabBar.backgroundColor = tabBarBackgroundColor;
}

- (void)setTabBarItemStrokeColor:(UIColor *)tabBarItemStrokeColor {
    _tabBarItemStrokeColor = tabBarItemStrokeColor;
    for (int i = 0; i < self.tabBarItems.count; i++) {
        BATabBarItem *item = [self.tabBarItems objectAtIndex:i];
        item.strokeColor = tabBarItemStrokeColor;
    }
    self.tabBar.barItemStrokeColor = tabBarItemStrokeColor;
}

- (void)setTabBarItemLineWidth:(CGFloat)tabBarItemLineWidth {
    _tabBarItemLineWidth = tabBarItemLineWidth;
    for (int i = 0; i < self.tabBarItems.count; i++) {
        BATabBarItem *item = [self.tabBarItems objectAtIndex:i];
        item.strokeWidth = tabBarItemLineWidth;
    }
    self.tabBar.barItemLineWidth = tabBarItemLineWidth;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    for(int i = (int)viewControllers.count-1; i >= 0; i--) {
        UIViewController* vc = [viewControllers objectAtIndex:i];
        [self.view insertSubview:vc.view belowSubview:self.tabBar];
    }
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    _selectedViewController = selectedViewController;
    [self.view insertSubview:selectedViewController.view belowSubview:self.tabBar];
    [self.delegate tabBarController:self didSelectViewController:selectedViewController];
}

#pragma mark - Public

- (void)setSelectedViewController:(UIViewController*)viewController animated:(BOOL)animated {
    self.selectedViewController = viewController;
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    [self.tabBar selectedTabItem:index animated:animated];
}

#pragma mark - BATabBarDelegate

- (void)tabBar:(BATabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index {
    self.selectedViewController = [self.viewControllers objectAtIndex:index];
}

@end
