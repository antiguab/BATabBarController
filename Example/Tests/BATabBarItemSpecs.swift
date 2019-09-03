//The MIT License (MIT)
//
//Copyright (c) 2019 Bryan Antigua <antigua.b@gmail.com>
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

import Quick
import Nimble
import BATabBarController

class BATabBarItemSpecs: QuickSpec {
    override func spec() {
        
        var tabBarItem :BATabBarItem!
        var tabBarItemWithTitle :BATabBarItem!
        var badge :BATabBarBadge!
        
        var image1 :UIImage!
        var image2 :UIImage!
        
        describe("BATabBarItem Logical Tests") {
            context("Can be initialized") {
                beforeEach {
                    image1 = UIImage()
                    image2 = UIImage()
                    tabBarItem = BATabBarItem(image: image1, selectedImage: image2)
                    badge = BATabBarBadge(value: 2, badgeColor: .red)
                    let option1 = NSMutableAttributedString(string: "Option1")
                    option1.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: option1.length))
                    tabBarItemWithTitle = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!, title: option1)

                }
                
                afterEach {
                    tabBarItem = nil
                    tabBarItemWithTitle = nil
                    image1 = nil
                    image2 = nil
                }
                
                //(id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage
                it("should be created") {
                    expect(tabBarItem).toNot(beNil())
                    expect(tabBarItem).to(beAnInstanceOf(BATabBarItem.self))
                    }
                
                //(id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSAttributedString*)title
                it("should be created") {
                    expect(tabBarItemWithTitle).toNot(beNil())
                    expect(tabBarItemWithTitle).to(beAnInstanceOf(BATabBarItem.self))
                    }
                
                it("should attach the badge when the property is change") {
                    expect(tabBarItem.badge).to(beNil())
                    tabBarItem.badge = badge
                    expect(tabBarItem.badge).to(equal(badge))
                }
                
                it("should attach the badge when the property is change") {
                    expect(tabBarItem.badge).to(beNil())
                    tabBarItemWithTitle.badge = badge
                    expect(tabBarItemWithTitle.badge).to(equal(badge))
                }

            }
        }
    }
}
