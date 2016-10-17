# HotShots

This example shows how to create screenshots of the app that can be used for the AppStore. This example is a simple iOS App that was create using the Xcode Tapped Application template. 
The screenshots of the app are created using normal unit tests. To run the test in all simualtors and languages a gradle build script is used using the [https://github.com/openbakery/gradle-xcodePlugin](Gradle Xcode Plugin)

Requirements:

* Xcode 7.+
* Java 1.8 

To generate the screenshots just execute:

```
./gradlew  takeScreenshots
```

With this command the project is compiled and the unit tests are executed and the screenshots are captured. The generated screenshots can be foudn in the `build/screenshots` directory. You should find screenshots in the english and german language, and also for the following devices: 

* iPad 
* iPad Pro
* iPhone 3.5inch
* iPhone 4inch
* iPhone 4.7inch
* iPhone 5.5inch

You can configure the languages and simulators that should be used in the build.gradle file. See also [https://github.com/openbakery/gradle-xcodePlugin](Gradle Xcode Plugin) project for more infos about the build.gradle file.


## Description

The Hotshots example project contains a Screenshots unit test targets that runs the unit tests in the Screenshot_iPad and Screenshot_iPhone test classes. In this test classes every unit tests generate a screenshot.

Here the test method from the Screenshot_iPad test class as example:

```
- (void)testSecondTabScreenshot {

	tabBarController.selectedIndex = 1;
	[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]];

	[self screenshotWithName:@"Screenshot-02"];

}
```

This test selected the second tab in the and then create a screenshot with the name "Screenshot-02.png". This screenshot is placed in a device specific folder e.g `de/iPad` or `de/iPad Pro`

The suffix _iPad or _iPhone of the unit test class indicates that these tests should only be executed in the proper simulator. If the suffix is removed, then unit tests run on every simulator.

## How to add this to my project

* Create a new unit test scheme in your project and name it 'Screenshots'.
* Copy the source file from the 'Screenshots' folder from this project to your project
* You will need to modifiy the 'Screenshot_iPad' and 'Screenshot_iPhone' to suite your project, but that should not be hard ;-)
* Copy the build.gradle, gradlew and gradle folder to your project.

