//
// Created by Rene Pirringer on 22.01.15.
//

#import "OBColor.h"


@implementation OBColor {

	CGFloat _red;
	CGFloat _green;
	CGFloat _blue;
	CGFloat _alpha;
}


/**
* Creates an color instance with color values from 0-255
*
*/
- (instancetype)initWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha {
	self = [super init];
	if (self) {
		_red = red / 255.0f;
		_green = green / 255.0f;
		_blue = blue / 255.0f;
		_alpha = alpha / 255.0f;
	}
	return self;
}

/**
* Creates an color instance with color values from 0-255
* And with alpha set to 255
*/
- (instancetype)initWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue  {
	return [self initWithRed:red green:green blue:blue alpha:255];

}

- (instancetype)initWithString:(NSString *)colorString {
	NSInteger blue = 0;
	NSInteger green = 0;
	NSInteger red = 0;

	if ([colorString hasPrefix:@"#"]) {
		NSScanner *scanner = [NSScanner scannerWithString:colorString];
		[scanner setScanLocation:1]; // skip # character
		unsigned int fullColorValue;
		[scanner scanHexInt:&fullColorValue];

		blue = fullColorValue & 0xFF;
		green = (fullColorValue >> 8) & 0xFF;
		red = (fullColorValue >> 16) & 0xFF;
	}
	return [self initWithRed:red green:green blue:blue];

}





- (UIColor *)uiColor {
	return [UIColor colorWithRed:_red green:_green blue:_blue alpha:_alpha];
}


- (BOOL)isEqual:(id)other {
	if (other == self) {
		return YES;
	}
	if (!other || ![[other class] isEqual:[self class]]) {
		return NO;
	}

	return [self isEqualToColor:other];
}

- (BOOL)isEqualToColor:(OBColor *)color {
	if (self == color) {
		return YES;
	}
	if (color == nil) {
		return NO;
	}
	if (_red != color->_red) {
		return NO;
	}
	if (_green != color->_green) {
		return NO;
	}
	if (_blue != color->_blue) {
		return NO;
	}
	if (_alpha != color->_alpha) {
		return NO;
	}
	return YES;
}

- (NSUInteger)hash {
	NSUInteger hash = _red;
	hash = hash * 31u + _green;
	hash = hash * 31u + _blue;
	hash = hash * 31u + _alpha;
	return hash;
}


- (NSString *)description {
	NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
	[description appendFormat:@"rgba(%@, %@, %@, %@)", @(_red), @(_green), @(_blue), @(_alpha)];
	[description appendString:@">"];
	return description;
}


@end