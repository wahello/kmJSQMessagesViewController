//
//  kmMoreMenuItem.m
//  JSQMessages
//
//  Created by Keye Myria on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMoreMenuItem.h"

@implementation kmMoreMenuItem

- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
								  title:(NSString *)title {
	self = [super init];
	if (self) {
		self.normalIconImage = normalIconImage;
		self.title = title;
	}
	return self;
}
- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
					 highlightIconImage:(UIImage *)highlightIconImage
								  title:(NSString *)title {
	self = [super init];
	if (self) {
		self.normalIconImage = normalIconImage;
		self.highlightIconImage = highlightIconImage;
		self.title = title;
	}
	return self;
}

- (void)dealloc {
	self.normalIconImage = nil;
	self.highlightIconImage = nil;
	self.title = nil;
}


@end
