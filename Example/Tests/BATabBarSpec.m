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
#import "BATestUtil.h"


SpecBegin(BATabBar)


describe(@"BATabBar", ^{
    __block BATabBar *tabBar;
    
    beforeEach(^{
        tabBar = [[BATabBar alloc] init];
    });
    
    
    //(id)init
    it(@"should be created", ^{
        expect(tabBar).toNot.beNil();
        expect(tabBar).to.beInstanceOf([BATabBar class]);
    });
    
    //(void) customInit
    it(@"should have a default backgroundColor Property", ^{
        expect(tabBar.backgroundColor).to.equal([UIColor colorWithHex:0x1C2129]);
    });
    
    it(@"should have a default barItemStrokeColor Property", ^{
        expect(tabBar.barItemStrokeColor).to.equal([UIColor colorWithHex:0xF23555]);
    });
    
    it(@"should have a default barItemLineWidth Property", ^{
        expect(tabBar.barItemLineWidth).to.equal(2);
    });
    
    it(@"should have a new barItemStrokeColor Property", ^{
        tabBar.barItemStrokeColor = [UIColor whiteColor];
        expect(tabBar.barItemStrokeColor).to.equal([UIColor whiteColor]);
    });
    
    it(@"should have a new barItemLineWidth Property", ^{
        tabBar.barItemLineWidth = 5;
        expect(tabBar.barItemLineWidth).to.equal(5);
    });
    
    //(void) updateTabBarItems:(NSArray*)tabBarItems
    it(@"should set tab bar items properties when items area assinged to tabBar", ^{
        NSArray* tabBarItems = [BATestUtil createValidTabBarItemsWithTitle];
        
        tabBar.tabBarItems = tabBarItems;
        for(int i = 0; i < tabBarItems.count; i++){
            BATabBarItem* item = [tabBarItems objectAtIndex:i];
            expect(item.strokeColor).to.equal(tabBar.barItemStrokeColor);
            expect(item.strokeWidth).to.equal(tabBar.barItemLineWidth);
        }
    });
    
    //(void)setTabBarItems:(NSArray<__kindof BATabBarItem *> *)tabBarItems
    it(@"should set tab bar items in tabBar", ^{
        
        NSArray* tabBarItems = [BATestUtil createValidTabBarItemsWithTitle];
        tabBar.tabBarItems = tabBarItems;
        expect(tabBar.tabBarItems).to.equal(tabBarItems);
    });
    
    afterEach(^{
        tabBar = nil;
    });
});

SpecEnd

