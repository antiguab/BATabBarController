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

class BATabBarControllerSpecs: QuickSpec {
    override func spec() {
        
        var controller :BATabBarController!
        
        describe("BATabBarController Logical Tests") {
            context("Can be initialized") {
                beforeEach {
                    controller = BATabBarController()
                    let viewController = BATestUtil.createViewControllers()
                    let tabBarItems = BATestUtil.createValidTabBarItemsWithTitle()
                    controller.viewControllers = viewController
                    controller.tabBarItems = tabBarItems
                }
                
                afterEach {
                    controller = nil
                }
                
                it("should be created") {
                    expect(controller).toNot(beNil())
                    expect(controller).to(beAnInstanceOf(BATabBarController.self))
                }
                
                it("should have a viewController Property") {
                    
                    let viewControllers = BATestUtil.createViewControllers()
                    controller.viewControllers = viewControllers
                    
                    expect(controller.viewControllers).to(equal(viewControllers))
                }
                
                it("should have a tabBarItems Property") {
                    let tabBarItems = BATestUtil.createValidTabBarItemsWithTitle()
                    controller.tabBarItems = tabBarItems
                    expect(controller.tabBarItems).to(equal(tabBarItems))
                }
                
                
                it("should select the first view controller if it loads without a selection and view appears") {
                    
                    expect(controller.selectedViewController).to(beNil())
                    controller.viewDidAppear(true)
                    
                    let firstController = controller.viewControllers[0]
                    expect(controller.selectedViewController).to(equal(firstController))
                }
                
                
                it("should keep the selected view controller when view appears") {
                    
                    expect(controller.selectedViewController).to(beNil())
                    
                    controller.selectedViewController = controller.viewControllers[1]
                    controller.viewDidAppear(true)
                    
                    let selectedController = controller.viewControllers[1]
                    expect(controller.selectedViewController).to(equal(selectedController))
                }
            }
        }
    }
}



