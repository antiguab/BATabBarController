# BATabBarController

[![CI Status](http://img.shields.io/travis/antiguab/BATabBarController.svg?style=flat)](https://travis-ci.org/antiguab/BATabBarController)
[![Version](https://img.shields.io/cocoapods/v/BATabBarController.svg?style=flat)](http://cocoapods.org/pods/BATabBarController)
[![License](https://img.shields.io/cocoapods/l/BATabBarController.svg?style=flat)](http://cocoapods.org/pods/BATabBarController)
[![Platform](https://img.shields.io/cocoapods/p/BATabBarController.svg?style=flat)](http://cocoapods.org/pods/BATabBarController)

## Overview
<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/gif1.gif" width="450px" />
<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/gif2.gif" width="450px" />


The standard TabBarController is very limited in terms of animations when you make a selection. This cocoapod allows you to use one with a sleek animation with customizable properties!

<br/>

## Requirements
* iOS 8+ iPhone, iPad and iPod Touch devices

<br/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<br/>

## Getting Started
### Installation

BATabBarController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "BATabBarController"
```

## Usage
### Default with No Text in Tab Bar

The example below create the default `BATabBarController` tab bar (default properties) without text.

```objc
UIViewController *vc1 = [[UIViewController alloc] init];
UIViewController *vc2 = [[UIViewController alloc] init];
UIViewController *vc3 = [[UIViewController alloc] init];

BATabBarItem *tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"]      
                                                 selectedImage:[UIImage imageNamed:@"icon1_selected"]];
BATabBarItem *tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"]      
                                                  selectedImage:[UIImage imageNamed:@"icon2_selected"]];
BATabBarItem *tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"]      
                                                  selectedImage:[UIImage imageNamed:@"icon1_selected"]];

BATabBarController *baTabBarController = [[BATabBarController alloc] init];
baTabBarController.viewControllers = @[vc1,vc2,vc3];
baTabBarController.tabBarItems = @[tabBarItem,tabBarItem2,tabBarItem3];                                                        baTabBarController.delegate = self;
[self.view addSubview:baTabBarController.view];
```

This creates the following:

<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example1.png" width="50%" />

### Default with Text in Tab Bar

The example below create the default `BATabBarController` tab bar (default properties) with text.

```objc
UIViewController *vc1 = [[UIViewController alloc] init];
UIViewController *vc2 = [[UIViewController alloc] init];
UIViewController *vc3 = [[UIViewController alloc] init];

NSMutableAttributedString *option1 = [[NSMutableAttributedString alloc] initWithString:@"Option1"];
[option1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xF0F2F6] range:NSMakeRange(0,option1.length)];
BATabBarItem *tabBarItem = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon1_unselected"]    
                                                 selectedImage:[UIImage imageNamed:@"icon1_selected"]
                                                         title:option1];

NSMutableAttributedString *option2 = [[NSMutableAttributedString alloc] initWithString:@"Option2"];
[option2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xF0F2F6] range:NSMakeRange(0,option2.length)];
BATabBarItem *tabBarItem2 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon2_unselected"]
                                                  selectedImage:[UIImage imageNamed:@"icon2_selected"]
                                                          title:option2];

NSMutableAttributedString * option3 = [[NSMutableAttributedString alloc] initWithString:@"Option3"];
[option3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xF0F2F6] range:NSMakeRange(0,option3.length)];
BATabBarItem *tabBarItem3 = [[BATabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon3_unselected"]
                                                  selectedImage:[UIImage imageNamed:@"icon3_selected"]
                                                          title:option3];

BATabBarController *baTabBarController = [[BATabBarController alloc] init];
baTabBarController.viewControllers = @[vc1,vc2,vc3];
baTabBarController.tabBarItems = @[tabBarItem,tabBarItem2,tabBarItem3];                                                        baTabBarController.delegate = self;
[self.view addSubview:baTabBarController.view];
```

This creates the following:

<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example2.png" width="50%" />


### Badges

Badges can be created with the `BATabBarBadge` class. After creating a badge you can simply assign it to the `.badge` property of a `BATabBarItem`:

``` Objective-c
BATabBarBadge *badge = [[BATabBarBadge alloc] initWithValue:@8 backgroundColor:[UIColor redColor]];
tabBarItem.badge = badge;

BATabBarBadge *badge3 = [[BATabBarBadge alloc] initWithValue:@8234 backgroundColor:[UIColor redColor]];
tabBarItem3.badge = badge3;
```

This creates the following:

<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example6.png" width="50%" />


##Methods
###Set Selected View Controller
You can change the currently selected tab bar item programatically by using the method below. To avoid
the animation pass `false` in the second parameter:
`setSelectedViewController:(UIViewController*)viewController animated:(BOOL)animated`

### BATabBarControllerDelegate
If you'd like to add external actions when a tab item is selected, you can use:
`tabBarController:(BATabBarController *)tabBarControllerdidSelectViewController:(UIViewController *)viewController`

### Properties
#### Tab Bar Color
To change the color of the tab bar, you can change the `tabBarBackgroundColor` property of the `BATabBarController` instance.

```objc
baTabBarController.tabBarBackgroundColor = [UIColor blackColor];
```

result:
<br/>
<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example3.png" width="50%" />


#### Tab Bar Item Stroke Color
To change the color of the stroke in the animation, you can change the `tabBarItemStrokeColor` property of the `BATabBarController` instance.

```objc
baTabBarController.tabBarItemStrokeColor = [UIColor blueColor];
```
result:
<br/>
<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example4.png" width="50%" />


#### Tab Bar Item Line Width
To change the size of the stroke in the animation, you can change the `tabBarItemLineWidth` property of the `BATabBarController` instance.

```objc
baTabBarController.tabBarItemLineWidth = 1.0;
```

result:
<br/>
<img src="https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/example5.png" width="50%" />

## ChangeLog
#### Version 0.1.3 (10.23.2016)
- Added ability to have badge icons (thanks to @terhechte)

#### Version 0.1.2 (06.21.2016)
- Platform version supports 8.0+

#### Version 0.1.1 (05.20.2016)
- Platform version supports 8.1+

#### Version 0.1.0 (05.18.2016)
- Initial release

#### Further informations
-  N/A

#### Known issues

## Author

Bryan Antigua, antigua.B@gmail.com - [bryanantigua.com](bryanantigua.com)

## License

`BATabBarController` is available under the MIT license. See the LICENSE file for more info.
