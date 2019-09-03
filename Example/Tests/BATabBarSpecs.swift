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

class BATabBarSpecs: QuickSpec {
    override func spec() {
        
        var tabBarBadge :BATabBarBadge!
        var tabBarBadge2 :BATabBarBadge!
        
        describe("BATabBarLogical Tests") {
            context("Can be initialized") {
                beforeEach {
                    tabBarBadge = BATabBarBadge(value:4, badgeColor: .red)
                    tabBarBadge2 = BATabBarBadge(value: 4, badgeColor: .red, strokeColor: .blue, strokeWidth: 2)
                }
                
                afterEach {
                    tabBarBadge = nil
                    tabBarBadge2 = nil
                }
                
                //(id)init
                it("should be created") {
                    expect(tabBarBadge).toNot(beNil())
                    expect(tabBarBadge).to(beAnInstanceOf(BATabBarBadge.self))
                }
                
                //(void) customInits
                it("should have a badgeColor property of red") {
                    expect(tabBarBadge.badgeColor).to(equal(.red))
                }
                
                it("should have a badgeValue value of 4"){
                    expect(tabBarBadge.value).to(equal(4))
                }
                
                it("should have a badgeColor property of red") {
                    expect(tabBarBadge2.badgeColor).to(equal(.red))
                }
                
                it("should have a badgeValue propert of 4") {
                    expect(tabBarBadge2.value).to(equal(4))
                }
                
            }
        }
    }
}
