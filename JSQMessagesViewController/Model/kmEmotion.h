//
//  XHEmotion.h
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kmEmotionImageViewSize 60
#define kmEmotionMinimumLineSpacing 12


@interface kmEmotion : NSObject


@property (nonatomic, strong) UIImage *emotionConverPhoto;

@property (nonatomic, copy) NSString *emotionPath;


@end
