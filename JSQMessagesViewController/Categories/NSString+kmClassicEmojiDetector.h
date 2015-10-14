//
//  NSString+kmClassicEmojiDetector.h
//  JSQMessages
//
//  Created by Keye Myria on 10/13/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (kmClassicEmojiDetector)


- (BOOL)detectEmojiAtBackspaceLocation:(NSInteger*)plocation selectedRange:(NSRange)plrange emojiDirectory:(NSString *)emdir emojiKeysFile:(NSString*)keyFile;


@end
