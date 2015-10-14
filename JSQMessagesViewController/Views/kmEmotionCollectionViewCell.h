//
//  kmEmotionCollectionViewCell.h
//  JSQMessages
//
//  Created by Keye Myria on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kmEmotion.h"

#define kmEmotionCollectionViewCellIdentifier @"kmEmotionCollectionViewCellIdentifier"

@interface kmEmotionCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) kmEmotion* emotion;

@end
