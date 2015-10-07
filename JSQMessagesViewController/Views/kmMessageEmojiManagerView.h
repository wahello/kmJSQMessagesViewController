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


@protocol kmMessageEmojiManagerViewDelegate;


@interface kmMessageEmojiManagerView : UIView <kmClassicEmojiViewDelegate>
{
	
	
}

@property (nonatomic, weak) id<kmMessageEmojiManagerViewDelegate> emojiDelegate;

@property (nonatomic, copy) NSString *classicEmojiDir;

@property (nonatomic, assign) kmEmotionType emotionType;


@end


@protocol kmMessageEmojiManagerViewDelegate <NSObject>

@required


@optional





@end