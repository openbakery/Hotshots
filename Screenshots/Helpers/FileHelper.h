//
// Created by rene on 21.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface FileHelper : NSObject



/**
* Method to get a unique filename at the specific destination. A number is added at the end of the file name
* if a file with the same name exists at the destination.
* e.g file-1.txt
*
*/
+ (NSString *)uniqueFileNameForFile:(NSString *)fileName atDestinationPath:(NSString *)path;


/**
* marks that this path should not be included in backups
*/
+ (void)excludePathFromBackup:(NSString *)path;

@end