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

#import "BATabBarItem.h"
#import "Masonry.h"

static double const BAOutlineRadiusPadding = 5.0;
static double const BAOutlinePadding = 5.0;
static double const BATitleOffset = 5.0;
static double const BATabBarHeight = 49.0;

static double const BAIconPaddingNoText = -15.0;
static double const BAIconPaddingWithText = -25.0;


@interface  BATabBarItem()

@property (strong, nonatomic) CAShapeLayer *outerCircleLayer;

@end

@implementation BATabBarItem

#pragma mark - Lifecyle

- (id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    
    self = [self init];
    
    if (self) {
        [self customInitWithImage:image selectedImage:selectedImage];
    }
    
    return self;
    
    
}

- (id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage  title:(NSAttributedString*)title {
    
    self = [self init];
    
    if (self) {
        
        self.title = [[UILabel alloc] init];
        self.title.attributedText = title;
        self.title.adjustsFontSizeToFitWidth = YES;
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.numberOfLines = 0;
        
        [self customInitWithImage:image selectedImage:selectedImage];

    }
    
    return self;
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)orientationChanged:(NSNotification *)notification {
    if(self.outerCircleLayer){
        [self showOutline];
    }
}

- (void)updateConstraints {
    //tabbar item constraints
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.superview.mas_bottom);
        make.top.equalTo(self.superview.mas_top);
        make.height.equalTo(@(BATabBarHeight));
    }];
    
    //inner tabbar item constraints
    [self.innerTabBarItem mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.innerTabBarItem.superview.mas_top).offset(BAOutlinePadding);
        make.bottom.equalTo(self.innerTabBarItem.superview.mas_bottom).offset(-BAOutlinePadding);
        make.center.equalTo(self.innerTabBarItem.superview);
        make.height.equalTo(self.innerTabBarItem.mas_width);
    }];
    

    [self.badge mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(self.bounds.size.width / 2 + self.badge.bounds.size.width / 2);
        make.top.equalTo(self.mas_top).offset(BAOutlinePadding / 2);
        make.width.equalTo(@(self.badge.bounds.size.width));
        make.height.equalTo(@(self.badge.bounds.size.height));
    }];
    
    [super updateConstraints];
}


#pragma mark - Private

- (void)customInitWithImage:(UIImage*)unselectedImage selectedImage:(UIImage*)selectedImage {
    //since we're animating the layer, we need to redraw when we rotate the device
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    //create inner tab bar item
    self.innerTabBarItem = [[UIButton alloc] init];
    [self addSubview:self.innerTabBarItem];
    self.innerTabBarItem.userInteractionEnabled = NO;//allows for clicks to pass through to the button below
    self.innerTabBarItem.translatesAutoresizingMaskIntoConstraints = NO;
    
    //create selected icon
    self.selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
    self.selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.innerTabBarItem addSubview:self.selectedImageView];
    
    //create unselected icon
    self.unselectedImageView = [[UIImageView alloc] initWithImage:unselectedImage];
    self.unselectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.innerTabBarItem addSubview:self.unselectedImageView];
    
    [self addConstraintsToImageViews];
}

- (void)addConstraintsToImageViews {
    
    if (!self.title) {
        
        //selected images contraints
        [self.selectedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectedImageView.superview);
            make.width.equalTo(self.selectedImageView.superview.mas_width).offset(BAIconPaddingNoText);
            make.height.equalTo(self.selectedImageView.superview.mas_height).offset(BAIconPaddingNoText);
            
        }];
        
        //unselected images
        [self.unselectedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.unselectedImageView.superview);
            make.width.equalTo(self.unselectedImageView.superview.mas_width).offset(BAIconPaddingNoText);
            make.height.equalTo(self.unselectedImageView.superview.mas_height).offset(BAIconPaddingNoText);
            
        }];
        
    } else {
        
        [self.innerTabBarItem addSubview:self.title];

        //title constraints
        [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.title.superview.mas_centerX);
            make.bottom.equalTo(self.title.superview.superview.mas_bottom).offset(-BATitleOffset);
            make.top.equalTo(self.unselectedImageView.mas_bottom).offset(BATitleOffset);
        }];
        
        //selected images contraints
        [self.selectedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectedImageView.superview.mas_top).offset(BATitleOffset);
            make.centerX.equalTo(self.selectedImageView.superview.mas_centerX);
            make.width.equalTo(self.selectedImageView.superview.mas_width).offset(BAIconPaddingWithText);
            make.height.equalTo(self.selectedImageView.superview.mas_height).offset(BAIconPaddingWithText);
            
        }];
        
        //unselected images constraints
        //selected images contraints
        [self.unselectedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectedImageView.superview.mas_top).offset(BATitleOffset);
            make.centerX.equalTo(self.selectedImageView.superview.mas_centerX);
            make.width.equalTo(self.selectedImageView.superview.mas_width).offset(BAIconPaddingWithText);
            make.height.equalTo(self.selectedImageView.superview.mas_height).offset(BAIconPaddingWithText);
            
        }];
        
    }
}

#pragma mark - Accessors

- (void) setBadge:(BATabBarBadge *)badge {
    
    if (self.badge) {
        [self.badge removeFromSuperview];
    }
    
    self->_badge = badge;
    
    [self addSubview:badge];
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Public

- (void)showOutline {
    
    [self layoutIfNeeded];
    
    //redraws in case constraints have changed
    if (self.outerCircleLayer) {
        [self.outerCircleLayer removeFromSuperlayer];
        self.outerCircleLayer = nil;
    }
    
    self.outerCircleLayer = [CAShapeLayer layer];
    
    
    //path for the outline
    UIBezierPath *outerCircleBezierPath = [UIBezierPath bezierPath];
    
    double outlineRadius = self.title?CGRectGetWidth(self.unselectedImageView.frame)/2.0 + BAOutlineRadiusPadding : (CGRectGetWidth(self.unselectedImageView.frame) - BAIconPaddingNoText)/2;
    
    //path for the outline
    [outerCircleBezierPath addArcWithCenter:self.unselectedImageView.center radius:outlineRadius startAngle:M_PI/2 endAngle:M_PI clockwise:NO];
    [outerCircleBezierPath addArcWithCenter:self.unselectedImageView.center radius:outlineRadius startAngle:M_PI  endAngle:M_PI/2 clockwise:NO];
    
    //adding custom color and stroke
    self.outerCircleLayer.path = outerCircleBezierPath.CGPath;
    self.outerCircleLayer.strokeColor = self.strokeColor.CGColor;
    self.outerCircleLayer.fillColor = [UIColor clearColor].CGColor;
    self.outerCircleLayer.lineWidth = self.strokeWidth;
    [self.innerTabBarItem.layer addSublayer:self.outerCircleLayer];
    
    
    //fade in icon color
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    self.unselectedImageView.alpha = 0.0;
    [UIView commitAnimations];
    
}

- (void)hideOutline {
    
    //if showing then hide
    if (self.outerCircleLayer) {
        [self.outerCircleLayer removeFromSuperlayer];
        self.outerCircleLayer = nil;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        self.unselectedImageView.alpha = 1.0;
        [UIView commitAnimations];
        return;
    }
}

@end
