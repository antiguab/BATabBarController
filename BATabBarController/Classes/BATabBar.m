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
#import "BATabBarItem.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"

static NSInteger const BAUniqueTag = 57690;

@interface BATabBar()

@property (strong, nonatomic) UIView *container;

@end

@implementation BATabBar

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

- (void)updateConstraints {
    
    //tab bar constraints
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.superview.mas_bottom);
        make.leading.equalTo(self.superview.mas_leading);
        make.trailing.equalTo(self.superview.mas_trailing);
        make.height.equalTo(@49);
    }];
    
    //container constraints
    [self.container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container.superview);
    }];
    
    
    //tabBarItem constraints
    for (int i = 0; i < self.tabBarItems.count; i++) {
        BATabBarItem* item = [self.tabBarItems objectAtIndex:i];
        [item mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(item.superview.mas_width).multipliedBy(1./self.tabBarItems.count);
            if(i == 0){
                make.leading.equalTo(item.superview);
                
            } else {
                BATabBarItem* prevItem = [self.tabBarItems objectAtIndex:i-1];
                make.leading.equalTo(prevItem.mas_trailing);
            }
        }];
    }
    
    [super updateConstraints];
}

#pragma mark - Custom Accessors

- (void)setTabBarItems:(NSArray<__kindof BATabBarItem *> *)tabBarItems {
    _tabBarItems = tabBarItems;
    [self updateTabBarItems:tabBarItems];
}

#pragma mark - Public

- (void)selectedTabItem:(NSUInteger)index animated:(BOOL)animated {
    BATabBarItem* newItem = [self.tabBarItems objectAtIndex:index];
    [self transitionToItem:newItem animated:animated];
    
}

#pragma mark - IBActions

- (void)didSelectItem:(id)sender {
    BATabBarItem* newItem = (BATabBarItem*)sender;
    if (newItem == self.currentTabBarItem) {
        return;//if it's the same tab, do nothing
    }
    
    //animate to new tab
    self.userInteractionEnabled = NO;
    [self.currentTabBarItem hideOutline];
    [self transitionToItem:newItem  animated:YES];
}

#pragma mark - Private

- (void) customInit {
    
    //set default properties
    self.barItemStrokeColor = [UIColor colorWithHex:0xF23555];
    self.backgroundColor = [UIColor colorWithHex:0x1C2129];
    self.barItemLineWidth = 2;
    
    //create container for animations
    self.container = [[UIView alloc] init];
    self.container.backgroundColor = [UIColor clearColor];
    self.container.userInteractionEnabled = NO;
    [self addSubview:self.container];
    
    
}

- (void) updateTabBarItems:(NSArray*)tabBarItems {
    
    for (int i = 0; i < tabBarItems.count; i++) {
        BATabBarItem *tabBarItem = [tabBarItems objectAtIndex:i];
        [self addSubview:tabBarItem];
        tabBarItem.tag = BAUniqueTag + i;
        tabBarItem.strokeColor = self.barItemStrokeColor;
        tabBarItem.strokeWidth = self.barItemLineWidth;
        [tabBarItem                 addTarget:self
                                       action:@selector(didSelectItem:)
                             forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)transitionToItem:(BATabBarItem*)newItem animated:(BOOL)animated {
    
    CAShapeLayer *animatingTabTransitionLayer = [CAShapeLayer layer];
    self.currentTabBarItem.title.textColor = newItem.title.textColor;
    
    
    void (^completionBlock)(void) = ^{
        [animatingTabTransitionLayer removeFromSuperlayer];
        [animatingTabTransitionLayer removeAllAnimations];
        self.currentTabBarItem = newItem;
        self.currentTabBarItem.title.textColor = self.barItemStrokeColor;
        
        [self.currentTabBarItem showOutline];
        self.userInteractionEnabled = YES;
    };
    
    if (!animated) {
        completionBlock();
        return;
    }
    
    [self layoutIfNeeded];
    
    //layer for path transitioning from one tab to the next
    UIBezierPath *animatingTabTransitionBezierPath = [UIBezierPath bezierPath];
    animatingTabTransitionLayer.strokeColor = self.barItemStrokeColor.CGColor;
    animatingTabTransitionLayer.fillColor = [UIColor clearColor].CGColor;
    animatingTabTransitionLayer.lineWidth = self.barItemLineWidth;
    
    //determines direction in which we unwind
    bool clockwise = newItem.tag < self.currentTabBarItem.tag?true:false;
    
    //vars used to determine total length later
    double circumference, distanceBetweenTabs, totalLength;
    
    if (!self.currentTabBarItem.title) {
        
        //need to adjust when there is no text
        //first item's outline
        [animatingTabTransitionBezierPath addArcWithCenter:self.currentTabBarItem.center radius:CGRectGetWidth(self.currentTabBarItem.innerTabBarItem.frame)/2.0 startAngle:M_PI/2 endAngle:M_PI clockwise:clockwise];
        [animatingTabTransitionBezierPath addArcWithCenter:self.currentTabBarItem.center radius:CGRectGetWidth(self.currentTabBarItem.innerTabBarItem.frame)/2.0 startAngle:M_PI  endAngle:M_PI/2 clockwise:clockwise];
        
        //traveling from one item to the next
        CGPoint origin = [self.currentTabBarItem convertPoint:CGPointMake(CGRectGetMidX(self.currentTabBarItem.innerTabBarItem.frame), CGRectGetMaxY(self.currentTabBarItem.innerTabBarItem.frame)) toView:self.container];
        CGPoint destination = [newItem convertPoint:CGPointMake(CGRectGetMidX(newItem.innerTabBarItem.frame), CGRectGetMaxY(newItem.innerTabBarItem.frame)) toView:self.container];
        [animatingTabTransitionBezierPath moveToPoint:origin];
        [animatingTabTransitionBezierPath addLineToPoint:destination];
        
        //second item's outline
        clockwise = newItem.tag < self.currentTabBarItem.tag?true:false;
        [animatingTabTransitionBezierPath addArcWithCenter:newItem.center radius:CGRectGetWidth(newItem.innerTabBarItem.frame)/2.0 startAngle:M_PI/2 endAngle:M_PI clockwise:clockwise];
        [animatingTabTransitionBezierPath addArcWithCenter:newItem.center radius:CGRectGetWidth(newItem.innerTabBarItem.frame)/2.0 startAngle:M_PI  endAngle:M_PI/2 clockwise:clockwise];
        
        //determining total length to see where the animation will begin  and end
        circumference = 2*M_PI*CGRectGetWidth(newItem.innerTabBarItem.frame)/2.0;
        distanceBetweenTabs = fabs(origin.x - destination.x);
        totalLength = 2*circumference + distanceBetweenTabs;
        
    } else {
        
        //need to adjust when there is text
        //first item's outline
        [animatingTabTransitionBezierPath addArcWithCenter:[self.currentTabBarItem.selectedImageView.superview convertPoint:self.currentTabBarItem.selectedImageView.center toView:self] radius:CGRectGetWidth(self.currentTabBarItem.selectedImageView.frame)/2.0 + 5.0 startAngle:M_PI/2 endAngle:M_PI clockwise:clockwise];
        [animatingTabTransitionBezierPath addArcWithCenter:[self.currentTabBarItem.selectedImageView.superview  convertPoint:self.currentTabBarItem.selectedImageView.center toView:self] radius:CGRectGetWidth(self.currentTabBarItem.selectedImageView.frame)/2.0 + 5.0 startAngle:M_PI  endAngle:M_PI/2 clockwise:clockwise];
        
        //traveling from one item to the next
        CGPoint origin = [self.currentTabBarItem.selectedImageView.superview convertPoint:CGPointMake(CGRectGetMidX(self.currentTabBarItem.unselectedImageView.frame), CGRectGetMaxY(self.currentTabBarItem.unselectedImageView.frame)+5) toView:self.container];
        CGPoint destination = [newItem.unselectedImageView.superview convertPoint:CGPointMake(CGRectGetMidX(newItem.unselectedImageView.frame), CGRectGetMaxY(newItem.unselectedImageView.frame)+5) toView:self.container];
        [animatingTabTransitionBezierPath moveToPoint:origin];
        [animatingTabTransitionBezierPath addLineToPoint:destination];
        
        //second item's outline
        clockwise = newItem.tag < self.currentTabBarItem.tag?true:false;
        [animatingTabTransitionBezierPath addArcWithCenter:[newItem.selectedImageView.superview convertPoint:newItem.selectedImageView.center toView:self.container]  radius:CGRectGetWidth(newItem.selectedImageView.frame)/2.0 + 5.0 startAngle:M_PI/2 endAngle:M_PI clockwise:clockwise];
        [animatingTabTransitionBezierPath addArcWithCenter:[newItem.selectedImageView.superview convertPoint:newItem.selectedImageView.center toView:self.container] radius:CGRectGetWidth(newItem.selectedImageView.frame)/2.0 + 5.0 startAngle:M_PI  endAngle:M_PI/2 clockwise:clockwise];
        
        //determining total length to see where the animation will begin  and end
        circumference = 2*M_PI*(CGRectGetWidth(newItem.selectedImageView.frame)/2.0+5);
        distanceBetweenTabs = fabs(origin.x - destination.x);
        totalLength = 2*circumference + distanceBetweenTabs;
    }
    
    
    //leading and trailing animations
    animatingTabTransitionLayer.path = animatingTabTransitionBezierPath.CGPath;
    
    CABasicAnimation *leadingAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    leadingAnimation.duration = 0.7;
    leadingAnimation.fromValue = @0;
    leadingAnimation.toValue = @1;
    leadingAnimation.removedOnCompletion = NO;
    leadingAnimation.fillMode =kCAFillModeForwards;
    leadingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *trailingAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    trailingAnimation.duration = leadingAnimation.duration - 0.15;
    trailingAnimation.fromValue = @0;
    trailingAnimation.removedOnCompletion = NO;
    trailingAnimation.fillMode =kCAFillModeForwards;
    trailingAnimation.toValue = @((circumference+distanceBetweenTabs)/totalLength);
    trailingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [CATransaction begin];
    CAAnimationGroup *transitionAnimationGroup = [CAAnimationGroup animation];
    transitionAnimationGroup.animations  = @[leadingAnimation,trailingAnimation];
    transitionAnimationGroup.duration = leadingAnimation.duration;
    transitionAnimationGroup.removedOnCompletion = NO;
    transitionAnimationGroup.fillMode =kCAFillModeForwards;
    [CATransaction setCompletionBlock:completionBlock];
    [animatingTabTransitionLayer addAnimation:transitionAnimationGroup forKey:nil];
    [CATransaction commit];
    
    
    [self.container.layer addSublayer:animatingTabTransitionLayer];
    [self.delegate tabBar:self didSelectItemAtIndex:[self.tabBarItems indexOfObject:newItem]];
    
}

@end
