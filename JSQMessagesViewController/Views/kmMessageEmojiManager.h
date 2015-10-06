//
//  kmMessageEmojiManager.h
//  JSQMessages
//
//  Created by dulian on 10/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "kmClassicEmojiView.h"


typedef NS_ENUM(NSInteger, kmEmotionType) {
	kmEmotionTypeClassic = 1,
	kmEmotionTypeGif= 2,
};


@protocol kmMessageEmojiManagerDelegate;


@interface kmMessageEmojiManager : UIView <kmClassicEmojiViewDelegate>
{
	
	
}

@property (nonatomic, weak) id<kmMessageEmojiManagerDelegate> emojiDelegate;

@property (nonatomic, copy) NSString *classicEmojiDir;

@property (nonatomic, assign) kmEmotionType emotionType;


@end


@protocol kmMessageEmojiManagerDelegate <NSObject>

@required


@optional





@end