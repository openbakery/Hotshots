//
// Created by Rene Pirringer on 22.01.15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OBImageColorHelper : NSObject

+ (BOOL)hasSingleColor:(UIImage *)image;
+ (NSArray *)colorsForImage:(UIImage *)image;
@end