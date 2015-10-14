//
//  kmEmojiCache.h
//  JSQMessages
//
//  Created by Keye Myria on 10/14/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface kmEmojiCache : NSObject
{
	
}


+ (instancetype)shareEmojiCache;


-(void)setObject:(id)object forKey:(NSString *)key;

- (NSAttributedString *)objectForKey:(NSString *)key;




@end
