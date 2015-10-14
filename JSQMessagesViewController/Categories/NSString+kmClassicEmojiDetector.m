//
//  NSString+kmClassicEmojiDetector.m
//  JSQMessages
//
//  Created by Keye Myria on 10/13/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "NSString+kmClassicEmojiDetector.h"

@implementation NSString (kmClassicEmojiDetector)


/*
 @param :
 ploc : NSNotFound
 
 @return YES : for ignore, let the system handle if in delegate of textview,
 or handle it yourself
 NO  : do not ignore, handle it
 */

- (BOOL)detectEmojiAtBackspaceLocation:(NSInteger*)plocation selectedRange:(NSRange)plrange emojiDirectory:(NSString *)emdir emojiKeysFile:(NSString*)keyFile {
	BOOL res = YES;
	NSInteger rloc = NSNotFound;
	
	NSInteger slen = [self length];
	
	if ( plrange.length > 0 || (slen > 0 && plrange.location < slen) ) {
		res = YES;
	} else if (slen > 0) {
		
		NSString *lastChar = [self substringFromIndex:slen -1];
		if ( [lastChar isEqualToString:@"]"] ) {
			NSRange lrange1 = [self rangeOfString:@"[" options:NSBackwardsSearch];
			
			if (lrange1.location != NSNotFound) {
				NSString *lastEmoji = [self substringWithRange:NSMakeRange(lrange1.location, slen -lrange1.location)];
				NSString *emojiBundledir = [[NSBundle mainBundle] pathForResource:emdir ofType:nil];
				NSString *keyArrPath = [[emojiBundledir stringByAppendingPathComponent:keyFile] stringByAppendingPathExtension:@"plist"];
				NSArray *emojiArr = [NSArray arrayWithContentsOfFile:keyArrPath];
				if ( [emojiArr containsObject:lastEmoji]) {
					res = NO;
					rloc = lrange1.location;
				} else {
					res = YES;
					rloc = slen -1;
				}
			} else {
				res = YES;
				rloc = slen - 1;
			}
		}
		else {
			res = YES;
			rloc = slen -1;
		}
		
	}
	*plocation = rloc;
	return  res;
}




@end
