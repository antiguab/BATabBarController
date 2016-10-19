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
#import "BATabBarBadge.h"


@interface BATabBarItem : UIButton

/**
UIView that houses the selected/unselected icons
 */
@property (nonatomic, strong) UIView *innerTabBarItem;

/**
 Width of the outline when a tab is selected
 */
@property (nonatomic, assign) CGFloat strokeWidth;

/**
 Color of the outline and text when a tab is selected
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 Tab title
 */
@property (nonatomic, strong) UILabel *title;

/**
 Image view for an unselected tab
 */
@property (nonatomic,strong) UIImageView *unselectedImageView;

/**
 Image view for a selected tab
 */
@property (nonatomic,strong) UIImageView *selectedImageView;

/**
 An optional badge to display in the top right corner
 */
@property (strong, nonatomic) BATabBarBadge *badge;

/**
 Custom init
 
 @param image
 UIImage of the unselected state
 @param selectedImage
 UIImage of the selected state
 @param title
 tile of the tab
 @return a BATabBarItem with the associated images and title

 */
- (id)initWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage title:(NSAttributedString*)title;

/**
 Custom init
 
 @param image
 UIImage of the unselected state
 @param selectedImage
 UIImage of the selected state
 @return a BATabBarItem with the associated images
*/
- (id)initWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage;

/**
 Hides the outline as a tab transitions to unselected
 */
- (void)hideOutline;

/**
 Shows the outline as a tab transitions to unselected
 */
- (void)showOutline;
@end
