//
// Created by Rene Pirringer on 08.05.15.
// Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BaseTestCase.h"

static const double waitTime = 0.5;


@interface Screenshot_iPhone : BaseTestCase

@end


@implementation Screenshot_iPhone {
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