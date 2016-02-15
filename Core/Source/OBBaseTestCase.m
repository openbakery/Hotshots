//
//
// Created by rene on 08.01.14.
// Copyright 2014 . All rights reserved.
//
// 
//


#import "OBBaseTestCase.h"
#import "OBImageColorHelper.h"
#import "OBFileHelper.h"


@implementation OBBaseTestCase {
	NSFileManager *_fileManager;
}



- (void)setUp {
	[super setUp];
	_fileManager = [NSFileManager defaultManager];


}

- (void)copyResourceWithName:(NSString *)name toDirectoryPath:(NSString *)path {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];


	NSString *extension = [name pathExtension];
	NSString *basename = name;
	if ([extension length] > 0) {
		NSInteger endIndex = [name length] - [extension length] - 1;
		basename = [name substringToIndex:endIndex];
	}

	NSString *fromPath = [bundle pathForResource:basename ofType:extension];

	NSString *toPath = [path stringByAppendingPathComponent:name];
	NSError *error;

	if ([_fileManager fileExistsAtPath:toPath]) {
		[_fileManager removeItemAtPath:toPath error:nil];
	}
	[_fileManager copyItemAtPath:fromPath toPath:toPath error:&error];

	if (error) {
		NSLog(@"%@", error);
	}

}


- (UIImage *)screenshotImage {

	UIScreen *screen = [UIScreen mainScreen];
	CGRect rect = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);

	UIGraphicsBeginImageContextWithOptions(rect.size, YES, screen.scale);

	UIView *view = [screen snapshotViewAfterScreenUpdates:YES];
	[view drawViewHierarchyInRect:rect afterScreenUpdates:YES];

	UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();
	return result;

}

- (NSString *)screenshotWithName:(NSString *)name {


	UIImage *image = nil;

	for (int i=0; i<5; i++) {
		// make sure that the image is not black
		image = [self screenshotImage];
		if (![OBImageColorHelper hasSingleColor:image]) {
			// we have more then one color so the screenshot must be good!
			break;
		}
		NSLog(@"We have a black screenshot, so take the screenshot again!");
	}

	NSArray *languages =[NSLocale preferredLanguages];
	NSString * language = @"en";
	if ([languages count]) {
		language = [languages objectAtIndex:0];
	}

	NSString * device;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		if (image.size.height == 1366.0f) {
			device = @"iPad Pro";
		} else {
			device = @"iPad";
		}
	} else {
		if (image.size.height == 480.0f) {
			device = @"iPhone-3.5inch";
		} else if (image.size.height == 568.0f) {
			device = @"iPhone-4inch";
		} else if (image.size.height == 667.0f) {
			device = @"iPhone-4.7inch";
		} else if (image.size.height == 736.0f) {
			device = @"iPhone-5.5inch";
		}
	}

	NSString *filename = [NSString stringWithFormat:@"%@-%@-%@.png", device, language,  name ];
	
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];
	NSString *documentPath = [environment objectForKey:@"OUTPUT_PATH"];
	BOOL isDirectory = NO;
	if (![_fileManager fileExistsAtPath:documentPath isDirectory:&isDirectory] && !isDirectory) {
		documentPath = nil;
	}
	
	if (!documentPath) {
		documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	}
	
	NSString *destinationPath = [[documentPath stringByAppendingPathComponent:language] stringByAppendingPathComponent:device];
	[_fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];


	NSString *uniqueFilename = [OBFileHelper uniqueFileNameForFile:filename atDestinationPath:destinationPath];
	NSString *imagePath = [destinationPath stringByAppendingPathComponent:uniqueFilename];

	NSData *data = UIImagePNGRepresentation(image);
	if ([data writeToFile:imagePath atomically:YES]) {
		NSLog(@"Screenshot saved to %@", imagePath);
		return imagePath;
	}
	return nil;
}


+ (id)defaultTestSuite
{
	NSString *className = NSStringFromClass(self);
	if ([className hasSuffix:@"_iPhone"] && UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
	{
		return [[XCTestSuite alloc] initWithName:className];
	}
	if ([className hasSuffix:@"_iPad"] && UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
	{
		return [[XCTestSuite alloc] initWithName:className];
	}
	return [super defaultTestSuite];
}



@end