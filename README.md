# HotShots

This example shows how to create the screenshots for the AppStore using normal unit test. The screenshots are created for all devices and all languages. (Here en and de).

Requirements:
* Xcode 7.+
* Java 1.8 

To generate all screenshots just execute:

```
./gradlew allScreenshots
```

There gradle uses my gradle xcode plugin to compile the project and run the unit tests in all simulators and languages (see build.gradle)

You will find the generated screenshots in the `build/screenshots` directory


## Description

The Hotshots example project contains a Screenshots unit test targets that runs the unit tests in the Screenshot_iPad and Screenshot_iPhone test classes. In this test classes every unit tests generate a screenshot.

e.g.
```
- (void)testSecondTabScreenshot {

	tabBarController.selectedIndex = 1;
	[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]];

	[self screenshotWithName:@"Screenshot-02"];

}
```

This test selected the second tab in the and then create a screenshot with the name "Screenshot-02.png". This screenshot is placed in a device specific folder e.g `de/iPad` or `de/iPad Pro`

## How to add this to my project

* Create a new unit test scheme in your project and name it 'Screenshots'.
* Copy the source file from the 'Screenshots' folder from this project to your project
* You will need to modifiy the 'Screenshot_iPad' and 'Screenshot_iPhone' to suite your project, but that should not be hard ;-)
* Copy the build.gradle, gradlew and gradle folder to your project.

