//
//  Screenshot_iPad.m
//  Screenshot_iPad
//
//  Created by Rene Pirringer on 07.05.15.
//  Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OBBaseTestCase.h"


static const double waitTime = 1.0;


@interface Screenshot_iPad : OBBaseTestCase

@end

@implementation Screenshot_iPad {
	UITabBarController *tabBarController;
}

- (void)setUp {
	[super setUp];
	UIApplication *application = [UIApplication sharedApplication];

	tabBarController = (UITabBarController *)application.delegate.window.rootViewController;
}


- (void)testFirstTabScreenshot {

	[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]];

	[self screenshotWithName:@"Screenshot-01"];

}




- (void)testSecondTabScreenshot {

	tabBarController.selectedIndex = 1;
	[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]];

	[self screenshotWithName:@"Screenshot-02"];

}

@end
