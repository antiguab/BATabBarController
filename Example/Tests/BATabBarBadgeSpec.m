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
//#import "UIColor+ColorWithHex.h"
//#import "BATestUtil.h"


SpecBegin(BATabBarBadge)


describe(@"BATabBarBadge", ^{
    __block BATabBarBadge *tabBarBadge;
    __block BATabBarBadge *tabBarBadge2;

    
    beforeEach(^{
        tabBarBadge = [[BATabBarBadge alloc] initWithValue:@4 backgroundColor:[UIColor redColor]];
        tabBarBadge2 = [[BATabBarBadge alloc] initWithValue:@4 backgroundColor:[UIColor redColor] strokeColor:[UIColor blueColor] width:2];
    });
    
    
    //(id)init
    it(@"should be created", ^{
        expect(tabBarBadge).toNot.beNil();
        expect(tabBarBadge).to.beInstanceOf([BATabBarBadge class]);
    });
    
    //(void) customInits
    it(@"should have a badgeColor property of red", ^{
        expect(tabBarBadge.badgeColor).to.equal([UIColor redColor]);
    });
    
    it(@"should have a badgeValue value of @4", ^{
        expect(tabBarBadge.badgeValue).to.equal(@4);
    });
    
    it(@"should have a badgeColor property of red", ^{
        expect(tabBarBadge2.badgeColor).to.equal([UIColor redColor]);
    });
    
    it(@"should have a badgeValue propert of @4", ^{
        expect(tabBarBadge2.badgeValue).to.equal(@4);
    });
    
    it(@"should have a badgeStrokeColor property of blue", ^{
        expect(tabBarBadge2.badgeStrokeColor).to.equal([UIColor blueColor]);
    });
    
    it(@"should have a badgeStrokeWidth of 2", ^{
        expect(tabBarBadge2.badgeStrokeWidth).to.equal(2);
    });
    
    
});

SpecEnd

