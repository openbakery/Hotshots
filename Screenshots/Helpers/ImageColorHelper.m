//
// Created by Rene Pirringer on 22.01.15.
//

#import "ImageColorHelper.h"
#import "OBColor.h"


@implementation ImageColorHelper {

}


+ (BOOL)hasSingleColor:(UIImage *)image {
	CGImageRef imageRef = [image CGImage];
	NSUInteger width = CGImageGetWidth(imageRef);
	NSUInteger height = CGImageGetHeight(imageRef);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	unsigned char *rawData = (unsigned char *) calloc(height * width * 4, sizeof(unsigned char));
	NSUInteger bytesPerPixel = 4;
	NSUInteger bytesPerRow = bytesPerPixel * width;
	NSUInteger bitsPerComponent = 8;

	CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

	CGColorSpaceRelease(colorSpace);

	CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
	CGContextRelease(context);

	OBColor *firstColor = nil;
	BOOL hasMultipleColors = NO;
	for (int x = 0; x < width && !hasMultipleColors; x++) {
		for (int y = 0; y < height && !hasMultipleColors; y++) {
			NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
			if (!firstColor) {
				firstColor = [[OBColor alloc] initWithRed:rawData[byteIndex] green:rawData[byteIndex + 1] blue:rawData[byteIndex + 2] alpha:rawData[byteIndex + 3]];
			} else {
				OBColor *color = [[OBColor alloc] initWithRed:rawData[byteIndex] green:rawData[byteIndex + 1] blue:rawData[byteIndex + 2] alpha:rawData[byteIndex + 3]];
				if (![color isEqual:firstColor]) {
					hasMultipleColors = YES;
				}
			}
		}
	}

	free(rawData);
	return !hasMultipleColors;
}

+ (NSArray *)colorsForImage:(UIImage *)image {
	NSMutableSet *colorSet = [[NSMutableSet alloc] init];

	CGImageRef imageRef = [image CGImage];
	NSUInteger width = CGImageGetWidth(imageRef);
	NSUInteger height = CGImageGetHeight(imageRef);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	unsigned char *rawData = (unsigned char *) calloc(height * width * 4, sizeof(unsigned char));
	NSUInteger bytesPerPixel = 4;
	NSUInteger bytesPerRow = bytesPerPixel * width;
	NSUInteger bitsPerComponent = 8;

	CGContextRef context = CGBitmapContextCreate(rawData,	width, height, bitsPerComponent, bytesPerRow, colorSpace,	kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

	CGColorSpaceRelease(colorSpace);

	CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
	CGContextRelease(context);

	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
			OBColor *color = [[OBColor alloc] initWithRed:rawData[byteIndex] green:rawData[byteIndex + 1] blue:rawData[byteIndex + 2] alpha:rawData[byteIndex + 3]];
			[colorSet addObject:color];
		}
	}

	free(rawData);
	return [colorSet allObjects];

}



+ (NSArray *)colorsForImage1:(UIImage *)image {

	CGSize size = image.size;

	NSMutableSet *colorSet = [[NSMutableSet alloc] init];

	CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
	const UInt8 *data = CFDataGetBytePtr(pixelData);

	for (int x=0; x<size.width; x++) {
		for (int y=0; y<size.height; y++) {

			int pixelInfo = ((image.size.width * y) + x) * 4;
			OBColor *color = [[OBColor alloc] initWithRed:data[pixelInfo] green:data[pixelInfo + 1] blue:data[pixelInfo + 2] alpha:data[pixelInfo + 3]];

			[colorSet addObject:color];
		}
	}
	CFRelease(pixelData);

	return [colorSet allObjects];

}


/*
- (BOOL)isWallPixel:(UIImage *)image x:(NSInteger)x y:(NSInteger)y {

    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);

    int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png

    //UInt8 red = data[pixelInfo];         // If you need this info, enable it
    //UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    //UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
    CFRelease(pixelData);

    //UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info

    if (alpha) return YES;
    else return NO;

}
*/
@end