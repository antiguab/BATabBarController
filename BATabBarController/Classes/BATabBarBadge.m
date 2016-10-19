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

#import "BATabBarBadge.h"

static double const BABadgeHeight = 18.0;
static double const BABadgePadding = 5.0;

@interface BATabBarBadge()
@property (nonatomic, retain) NSAttributedString *attributedValue;
@property (nonatomic, assign) CGFloat calculatedAttributedWidth;
@end

@implementation BATabBarBadge

#pragma mark - Initialization

- (instancetype) initWithValue:(NSNumber*)badgeValue backgroundColor:(UIColor*)backgroundColor strokeColor:(UIColor*)strokeColor width:(CGFloat)width {
    self = [super initWithFrame:CGRectMake(0, 0, BABadgeHeight, BABadgeHeight)];
    if (self) {
        self.badgeColor = backgroundColor;
        self.badgeStrokeColor = strokeColor;
        self.badgeStrokeWidth = width;
        self.userInteractionEnabled = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.badgeValue = badgeValue;
    }
    return self;
}


- (instancetype) initWithValue:(NSNumber*)badgeValue backgroundColor:(UIColor*)backgroundColor {
    return [self initWithValue:badgeValue backgroundColor:backgroundColor strokeColor:nil width:0];
}

#pragma mark - Accessors

- (void) setBadgeValue:(NSNumber *)badgeValue {
    self->_badgeValue = badgeValue;
    [self updateBadge];
}

- (void) setBadgeValueColor:(UIColor *)badgeValueColor {
    self->_badgeValueColor = badgeValueColor;
    [self updateBadge];
}

#pragma mark - UIView

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.badgeValue == nil)return;
    
    CGRect bounds = self.bounds;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:32.0];
    
    if (self.badgeStrokeColor && self.badgeStrokeWidth > 0) {
        [self.badgeStrokeColor setStroke];
        [circlePath setLineWidth:self.badgeStrokeWidth];
        [circlePath stroke];
    }
    
    if (self.badgeColor) {
        [self.badgeColor setFill];
        [circlePath fill];
    }
    
    [self.attributedValue drawInRect:CGRectMake(BABadgePadding, 0, _calculatedAttributedWidth, BABadgeHeight)];
}

#pragma mark - Internal

- (void) updateBadge {
    UIFont *font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    
    NSString *title = [NSString stringWithFormat:@"%@", self.badgeValue];
    
    NSDictionary *attributes =
    @{NSFontAttributeName: font,
      NSForegroundColorAttributeName: self.badgeValueColor ?: [UIColor whiteColor]};
    
    self.attributedValue = [[NSAttributedString alloc] initWithString:title
                                                           attributes:attributes];
    
    CGRect paragraphRect =
    [self.attributedValue boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 context:nil];
    
    self.calculatedAttributedWidth = paragraphRect.size.width;
    
    CGRect frame = self.frame;
    frame.size.width = paragraphRect.size.width + 2 * BABadgePadding;
    self.frame = frame;
    
    [self setNeedsLayout];
}


@end
