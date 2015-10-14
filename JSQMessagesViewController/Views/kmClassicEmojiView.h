//
//  kmClassicEmojiView.h
//  JSQMessages
//
//  Created by Keye Myria on 10/6/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol kmClassicEmojiViewDelegate;


@interface kmClassicEmojiView : UIView {
	
}

@property (nonatomic, weak) id<kmClassicEmojiViewDelegate> emojiDelegate;

- (id)initWithFrame:(CGRect)frame keys:(NSArray*)keys dict:(NSDictionary*)tdict emojiPath:(NSString*)epath delPath:(NSString*)delpath atPageIndex:(NSInteger)pindex;


@end


@protocol kmClassicEmojiViewDelegate <NSObject>

@required

- (void)emojiView:(kmClassicEmojiView *)emojiView didSelectEmoji:(NSString*)emojiName isDelete:(BOOL)isdele;


@end