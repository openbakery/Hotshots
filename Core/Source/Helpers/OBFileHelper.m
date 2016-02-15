//
// Created by rene on 21.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <MobileCoreServices/MobileCoreServices.h>
#import "OBFileHelper.h"


@implementation OBFileHelper
{

}



+ (NSString *)uniqueFileNameForFile:(NSString *)fileName atDestinationPath:(NSString *)path {

	NSString *resultFileName = [path stringByAppendingPathComponent:fileName];
	NSFileManager *fileManager = [NSFileManager defaultManager];

	int i=1;
	while ([fileManager fileExistsAtPath:resultFileName] || [fileManager fileExistsAtPath:[resultFileName stringByAppendingPathExtension:@"download"]]) {
		NSString *extension = [fileName pathExtension];
		if ([extension length] > 0) {
			NSInteger endIndex = [fileName length]- [extension length] - 1;
			NSString *basename = [NSString stringWithFormat: @"%@-%d", [fileName substringToIndex:endIndex], i];
			resultFileName = [[path stringByAppendingPathComponent:basename] stringByAppendingPathExtension:extension];
		} else {
			resultFileName = [path stringByAppendingPathComponent:[NSString stringWithFormat: @"%@-%d", fileName, i]];
		}

		i++;
	}
	return [resultFileName lastPathComponent];
}





+ (void)excludePathFromBackup:(NSString *)path {
	NSURL *fileURL;
	fileURL = [NSURL fileURLWithPath:path];
	[fileURL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

@end