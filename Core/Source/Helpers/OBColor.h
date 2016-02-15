//
// Created by Rene Pirringer on 22.01.15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OBColor : NSObject

- (instancetype)initWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;
- (instancetype)initWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
- (instancetype)initWithString:(NSString *)colorString;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToColor:(OBColor *)color;

- (NSUInteger)hash;

- (NSString *)description;

@property(nonatomic, readonly) UIColor *uiColor;



@end