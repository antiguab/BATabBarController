//
//  BATestUtil.h
//  BATabBarController
//
//  Created by Bryan Antigua on 5/12/16.
//  Copyright © 2016 Bryan Antigua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BATestUtil : NSObject

+(NSArray*)createValidTabBarItemsWithTitle;
+(NSArray*)createValidTabBarItemsWithoutTitle;
+(NSArray*)createInvalidTabBarItemsWithTitle;

+(NSArray*)createViewControllers;

@end
