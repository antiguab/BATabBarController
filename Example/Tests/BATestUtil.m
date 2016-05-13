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

#import "BATabBar.h"
#import "UIColor+ColorWithHex.h"
#import "BATabBarController.h"
#import "BATestUtil.h"

@implementation BATestUtil

+(NSArray*)createValidTabBarItemsWithTitle {
    NSMutableAttributedString * option1 = [[NSMutableAttributedString alloc] initWithString:@"Option1"];
    [option1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option1.length)];
    BATabBarItem* tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"] title:option1];
    
    NSMutableAttributedString * option2 = [[NSMutableAttributedString alloc] initWithString:@"Option2"];
    [option2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option2.length)];
    BATabBarItem* tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"] title:option2];
    
    NSMutableAttributedString * option3 = [[NSMutableAttributedString alloc] initWithString:@"Option3"];
    [option3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option3.length)];
    BATabBarItem* tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"] title:option3];
    
    return @[tabBarItem,tabBarItem2,tabBarItem3];
}

+(NSArray*)createValidTabBarItemsWithoutTitle {
    
    BATabBarItem* tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"]];
    
    BATabBarItem* tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"]];
    
    BATabBarItem* tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"]];
    
    return @[tabBarItem,tabBarItem2,tabBarItem3];
}

+(NSArray*) createInvalidTabBarItemsWithTitle {
    
    BATabBarItem* tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"]];
    
    NSMutableAttributedString * option2 = [[NSMutableAttributedString alloc] initWithString:@"Option2"];
    [option2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option2.length)];
    BATabBarItem* tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"] selectedImage:[UIImage imageNamed:@"icon2_selected"] title:option2];
    
    NSMutableAttributedString * option3 = [[NSMutableAttributedString alloc] initWithString:@"Option3"];
    [option3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA8A8A8] range:NSMakeRange(0,option3.length)];
    BATabBarItem* tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"] selectedImage:[UIImage imageNamed:@"icon3_selected"] title:option3];
    
    return @[tabBarItem,tabBarItem2,tabBarItem3];
}

+(NSArray*) createViewControllers {
    
    UIViewController* vc1 = [[UIViewController alloc] init];
    UIViewController* vc2 = [[UIViewController alloc] init];
    UIViewController* vc3 = [[UIViewController alloc] init];
    
   return@[vc1,vc2,vc3];
    
}

@end