//
//  BAViewController.m
//  BATabBarController
//
//  Created by Bryan Antigua on 04/20/2016.
//  Copyright (c) 2016 Bryan Antigua. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "BAViewController.h"
#import "BATabBarController.h"
#import "UIColor+ColorWithHex.h"
#import "BATabBarItem.h"

@interface BAViewController ()

@property (nonatomic,assign) bool firstTime;
@property (nonatomic,strong) BATabBarController* vc;


@end

@implementation BAViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTime = YES;
}


- (void)viewDidLayoutSubviews {
    if(self.firstTime){
        UIViewController* vc1 = [[UIViewController alloc] init];
        NSMutableAttributedString * option1 = [[NSMutableAttributedString alloc] initWithString:@"Option1"];
        [option1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option1.length)];
        
        BATabBarItem* tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"] title:option1];
        vc1.view.backgroundColor = [UIColor redColor];
        
        NSMutableAttributedString * option2 = [[NSMutableAttributedString alloc] initWithString:@"Option2"];
        [option2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option2.length)];
        
        UIViewController* vc2 = [[UIViewController alloc] init];
        BATabBarItem* tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"] title:option2];
        vc2.view.backgroundColor = [UIColor greenColor];
        
        NSMutableAttributedString * option3 = [[NSMutableAttributedString alloc] initWithString:@"Option3"];
        [option3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option3.length)];
        
        UIViewController* vc3 = [[UIViewController alloc] init];
        BATabBarItem* tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"] title:option3];
        vc3.view.backgroundColor = [UIColor blueColor];
        
//========================================================================================================================================
//
//        UIViewController* vc1 = [[UIViewController alloc] init];
//        BATabBarItem* tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"]];
//        vc1.view.backgroundColor = [UIColor redColor];
//        
//        UIViewController* vc2 = [[UIViewController alloc] init];
//        BATabBarItem* tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"]];
//        vc2.view.backgroundColor = [UIColor greenColor];
//        UIViewController* vc3 = [[UIViewController alloc] init];
//        BATabBarItem* tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"]];
//        vc3.view.backgroundColor = [UIColor blueColor];
        
        
//========================================================================================================================================
        self.vc = [[BATabBarController alloc] init];
//        self.vc.tabBarBackgroundColor = [UIColor blackColor];
//        self.vc.tabBarItemStrokeColor = [UIColor blackColor];
//        self.vc.tabBarItemLineWidth = 1.0;
        
        self.vc.viewControllers = @[vc1,vc2,vc3];
        self.vc.tabBarItems = @[tabBarItem,tabBarItem2,tabBarItem3];
        [self.vc setSelectedViewController:vc2 animated:NO];

        self.vc.delegate = self;
        [self.view addSubview:self.vc.view];
        self.firstTime = NO;
        
    }
}

-(void)tabBarController:(BATabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"Delegate success: ");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
