//
//  NSBundle+kmClassEmoji.m
//  JSQMessages
//
//  Created by dulian on 10/5/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "NSBundle+kmClassEmoji.h"

@implementation NSBundle (kmClassEmoji)


+ (NSBundle *)km_classicEmojiBundle {
	NSString *ceb = [[NSBundle mainBundle] pathForResource:@"classicEmoji" ofType:@"bundle"];
	return [NSBundle bundleWithPath:ceb];
}


@end
