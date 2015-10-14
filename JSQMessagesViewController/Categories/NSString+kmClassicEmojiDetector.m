//
//  NSString+kmClassicEmojiDetector.m
//  JSQMessages
//
//  Created by Keye Myria on 10/13/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "NSString+kmClassicEmojiDetector.h"

#import "kmEmojiCache.h"

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

- (NSAttributedString *)attributedStringForRegex:(NSString *)regex
								  emojiDirectory:(NSString *)emojiDirectory
							   emojiKeyValueFile:(NSString *)emojiKeyValueFile  attributes:(NSDictionary<NSString *, id>*)attr {

	if ([self length] == 0) {
		return [[NSAttributedString alloc] init];
	}
	kmEmojiCache *cache = [kmEmojiCache shareEmojiCache];
	NSAttributedString *attrStr = [cache objectForKey:self];
	if (attrStr) {
		return attrStr;
	}
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self  attributes:attr];
	
	NSError *error = nil;
	NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
	
	if (re) {
		NSArray *resultArr = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
		NSString *emojiBundledir = [[NSBundle mainBundle] pathForResource:emojiDirectory ofType:nil];
		NSString *emojiPath = [[emojiBundledir stringByAppendingPathComponent:emojiKeyValueFile] stringByAppendingPathExtension:@"plist"];
		
		NSDictionary *emojiDict = [NSDictionary dictionaryWithContentsOfFile:emojiPath];
		NSArray *emojiKeys = [emojiDict allKeys];
		
		NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArr.count];
		
		for (NSTextCheckingResult *amatch in resultArr) {
			
			NSRange mrange = [amatch range];
			NSString *oneEmoji = [self substringWithRange:mrange];
			
			if ( [emojiKeys containsObject:oneEmoji] ) {
				NSString *emfile = [emojiDict objectForKey:oneEmoji];
				NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
				textAttachment.bounds = CGRectMake(textAttachment.bounds.origin.x, textAttachment.bounds.origin.y - 5, 25, 25);
				NSString *emojiImgPath = [emojiBundledir stringByAppendingPathComponent:emfile];
				textAttachment.image = [UIImage imageNamed:emojiImgPath];
				NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
				
				NSMutableDictionary *imageDict = [NSMutableDictionary dictionaryWithCapacity:2];
				[imageDict setObject:imageStr forKey:@"image"];
				[imageDict setObject:[NSValue valueWithRange:mrange] forKey:@"range"];
				
				[imageArray addObject:imageDict];
			}
		}
		
		for (NSInteger ii = imageArray.count - 1; ii >= 0; ii --) {
			NSDictionary *adict = [imageArray objectAtIndex:ii];
			NSRange arange;
			[[adict objectForKey:@"range"] getValue:&arange];
			NSAttributedString *imageStr = [adict objectForKey:@"image"];
			[attributedString replaceCharactersInRange:arange withAttributedString:imageStr];
		}
	}
	[cache setObject:attributedString forKey:self];
	return attributedString;
}



@end
