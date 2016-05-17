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

#import "BAViewController.h"
#import "BATabBarController.h"
#import "UIColor+ColorWithHex.h"
#import "BATabBarItem.h"

typedef NS_ENUM(NSInteger, BATabBarType) {
    BATabBarTypeWithText,
    BATabBarTypeNoText
};

@interface BAViewController ()

@property (nonatomic, assign) bool firstTime;
@property (nonatomic, assign) BATabBarType demoType;
@property (nonatomic, strong) BATabBarController* vc;

@end

@implementation BAViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTime = YES;
    
    //for easy swtiching between demos
    self.demoType = BATabBarTypeNoText;
}


- (void)viewDidLayoutSubviews {
    if(self.firstTime){
        
        BATabBarItem *tabBarItem, *tabBarItem2, *tabBarItem3;
        UIViewController *vc1 = [[UIViewController alloc] init];
        UIViewController *vc2 = [[UIViewController alloc] init];
        UIViewController *vc3 = [[UIViewController alloc] init];
        
        
        switch (self.demoType) {
            case BATabBarTypeWithText: {
                NSMutableAttributedString *option1 = [[NSMutableAttributedString alloc] initWithString:@"Option1"];
                [option1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option1.length)];
                
                tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"] title:option1];
                vc1.view.backgroundColor = [UIColor redColor];
                
                NSMutableAttributedString *option2 = [[NSMutableAttributedString alloc] initWithString:@"Option2"];
                [option2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option2.length)];
                
                tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"] title:option2];
                vc2.view.backgroundColor = [UIColor greenColor];
                
                NSMutableAttributedString * option3 = [[NSMutableAttributedString alloc] initWithString:@"Option3"];
                [option3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option3.length)];
                
                tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"] title:option3];
                vc3.view.backgroundColor = [UIColor blueColor];
                break;
            }
            case BATabBarTypeNoText: {
                tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"]];
                vc1.view.backgroundColor = [UIColor redColor];
                
                tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"]];
                vc2.view.backgroundColor = [UIColor greenColor];
                
                tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"]];
                vc3.view.backgroundColor = [UIColor blueColor];
                break;
            }
                
            default:
                //what are you doing here?
                break;
                
        }

        self.vc = [[BATabBarController alloc] init];
        
        //tab bar background color example
        //self.vc.tabBarBackgroundColor = [UIColor blackColor];
        
        //tab bar item stroke color example
        //self.vc.tabBarItemStrokeColor = [UIColor whiteColor];
        
        //Tab bar line width exampe
        //self.vc.tabBarItemLineWidth = 1.0;
        
        self.vc.viewControllers = @[vc1,vc2,vc3];
        self.vc.tabBarItems = @[tabBarItem,tabBarItem2,tabBarItem3];
        [self.vc setSelectedViewController:vc2 animated:NO];
        
        self.vc.delegate = self;
        [self.view addSubview:self.vc.view];
        self.firstTime = NO;
        
    }
}

- (void)tabBarController:(BATabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"Delegate success!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
