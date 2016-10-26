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

@interface BATabBarBadge : UIView

/**
 Badge value for this tab. Setting to nil will always hide it
 */
@property (nonatomic, strong) NSNumber *badgeValue;

/**
 Badge value / title text color
 */
@property (nonatomic, strong) UIColor *badgeValueColor;

/**
 Optional badge background color. Set to nil to not draw a background
 */
@property (nonatomic, strong) UIColor *badgeColor;

/**
 Badge stroke color. Set to nil to not draw a stroke
 */
@property (nonatomic, strong) UIColor *badgeStrokeColor;

/**
 Badge stroke width. Will be ignored if `badgeStrokeColor` is nil
 */
@property (nonatomic, assign) CGFloat badgeStrokeWidth;

- (instancetype) initWithValue:(NSNumber*)badgeValue backgroundColor:(UIColor*)backgroundColor strokeColor:(UIColor*)strokeColor width:(CGFloat)width;

- (instancetype) initWithValue:(NSNumber*)badgeValue backgroundColor:(UIColor*)backgroundColor;


@end
