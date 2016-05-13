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
#import "BATestUtil.h"


SpecBegin(BATabBarItem)

describe(@"BATabBarItem", ^{
    __block BATabBarItem *tabBarItem;
    __block BATabBarItem *tabBarItemWithTitle;
    
    __block UIImage *image1;
    __block UIImage *image2;
    
    
    
    beforeEach(^{
        image1 = [[UIImage alloc] init];
        image2 = [[UIImage alloc] init];
        tabBarItem = [[BATabBarItem alloc] initWithImage:image1 selectedImage:image2];
        NSMutableAttributedString * option1 = [[NSMutableAttributedString alloc] initWithString:@"Option1"];
        [option1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,option1.length)];
        tabBarItemWithTitle = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"] selectedImage:[UIImage imageNamed:@"icon1_selected"] title:option1];
        
    });
    
    
    //(id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage
    it(@"should be created", ^{
        expect(tabBarItem).toNot.beNil();
        expect(tabBarItem).to.beInstanceOf([BATabBarItem class]);
    });
    
    //(id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage  title:(NSAttributedString*)title
    it(@"should be created", ^{
        expect(tabBarItemWithTitle).toNot.beNil();
        expect(tabBarItemWithTitle).to.beInstanceOf([BATabBarItem class]);
        expect(tabBarItemWithTitle.title).toNot.beNil();
        expect(tabBarItemWithTitle.title).to.beInstanceOf([UILabel class]);
    });
    
    //(void)customInitWithImage:(UIImage*)unselectedImage selectedImage:(UIImage*)selectedImage {
    it(@"should have created an inner tab bar item", ^{
        expect(tabBarItem.innerTabBarItem).toNot.beNil();
        expect(tabBarItem.innerTabBarItem).to.beInstanceOf([UIButton class]);
        expect(tabBarItem.innerTabBarItem.isUserInteractionEnabled).to.beFalsy();
    });
    
    it(@"should have created a selected icon View", ^{
        expect(tabBarItem.selectedImageView).toNot.beNil();
        expect(tabBarItem.selectedImageView).to.beInstanceOf([UIImageView class]);
        expect(tabBarItem.selectedImageView.contentMode).to.equal(UIViewContentModeScaleAspectFit);
    });
    
    it(@"should have created a unselected icon View", ^{
        expect(tabBarItem.unselectedImageView).toNot.beNil();
        expect(tabBarItem.unselectedImageView).to.beInstanceOf([UIImageView class]);
        expect(tabBarItem.unselectedImageView.contentMode).to.equal(UIViewContentModeScaleAspectFit);
    });
    

    afterEach(^{
        tabBarItem = nil;
        tabBarItemWithTitle = nil;
        image1 = nil;
        image2 = nil;
    });
});

SpecEnd

