//
//  kmEmotionManager.m
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmotionManager.h"

@interface kmEmotionManager ()


@end


@implementation kmEmotionManager


- (void)dealloc {
	[self.emotions removeAllObjects];
	self.emotions = nil;
}


@end
