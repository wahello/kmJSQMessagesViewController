//
//  kmEmojiCache.m
//  JSQMessages
//
//  Created by Keye Myria on 10/14/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmojiCache.h"

@interface kmEmojiCache ()

@property (nonatomic, strong) NSCache *cache;

@end


@implementation kmEmojiCache

+ (instancetype)shareEmojiCache {
	static id _ecache = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_ecache = [[kmEmojiCache alloc] init];
	});
	return _ecache;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		NSCache *tcache = [NSCache new];
		tcache.name = @"kmMessageClassicEmoji.cache";
		tcache.countLimit = 200;
		self.cache = tcache;
	}
	return self;
}

-(void)setObject:(id)object forKey:(NSString *)key {
	[self.cache setObject:object forKey:key];
}

- (NSAttributedString *)objectForKey:(NSString *)key {
	return [self.cache objectForKey:key];
}



@end
