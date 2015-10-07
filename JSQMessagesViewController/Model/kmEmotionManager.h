//
//  kmEmotionManager.h
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "kmEmotion.h"

typedef NS_ENUM(NSInteger, kmEmotionType) {
	kmEmotionTypeClassic = 1,
	kmEmotionTypeGif= 2,
};

@interface kmEmotionManager : NSObject {
	
}

@property (nonatomic, assign) kmEmotionType emotionType;

@property (nonatomic, copy) NSString *emotionFilePrefix;
@property (nonatomic, copy) NSString *emotionFileSuffix;
@property (nonatomic, copy) NSString *emotionResourceDir;

@property (nonatomic, copy) NSString *emotionName;


@property (nonatomic, strong) NSMutableArray *emotions;

@end
