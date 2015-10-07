//
//  kmEmotionSectionBar.h
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "kmEmotionManager.h"

@protocol kmEmotionSectionBarDelegate;


@interface kmEmotionSectionBar : UIView
{
	
	
}

@property (nonatomic, weak) id<kmEmotionSectionBarDelegate> delegate;

@property (nonatomic, strong) NSArray *emotionManagers;


- (void)reloadData;

- (void)changeSendButtonBackgroundColor:(UIColor *)bgcolor titleColor:(UIColor*)titleColor;

@end


@protocol kmEmotionSectionBarDelegate <NSObject>


@required

@optional

- (void)didSendButtonClicked;
- (void)didSelectEmotionManager:(kmEmotionManager *)emotionManager atSection:(NSInteger)section;


@end