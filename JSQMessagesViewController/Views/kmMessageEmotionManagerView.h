//
//  kmMessageEmojiManager.h
//  JSQMessages
//
//  Created by dulian on 10/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "kmClassicEmojiView.h"

#import "kmEmotionManager.h"

#import "kmEmotionSectionBar.h"

#define kmoreMenuItemWidth 60
#define kmoreMenuItemHeight 80

#define kmoreMiniLineSpacing 10

#define kmEmotionPerRowItemCount (((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) ? 10 : 4)

@protocol kmMessageEmotionManagerViewDelegate;
@protocol kmMessageEmotionManagerViewDatasource;


@interface kmMessageEmotionManagerView : UIView <kmClassicEmojiViewDelegate, kmEmotionSectionBarDelegate>
{
	
	
}

@property (nonatomic, weak) id<kmMessageEmotionManagerViewDatasource> emotionDatasource;

@property (nonatomic, weak) id<kmMessageEmotionManagerViewDelegate> emotionDelegate;

@property (nonatomic, strong) NSString *classicEmojiDir;

- (void)reloadData;


@end



/////////
@protocol kmMessageEmotionManagerViewDelegate <NSObject>

@required

@optional

- (void)didSelectEmotion:(kmEmotion*)emotion atIndexPath:(NSIndexPath *)indexPath;

- (void)didSelectedEmoji:(NSString *)emojiName isDele:(BOOL)isdele;

- (NSString*)textThatInputed;

- (void)emojiSendButtonClicked;

@end

@protocol kmMessageEmotionManagerViewDatasource <NSObject>

@required

- (kmEmotionManager *)emotionManagerForColumn:(NSInteger)columnIndex;

- (NSArray *)emotionManagersAtManager;

- (NSInteger)numberOfEmotionManagers;


@optional

@end