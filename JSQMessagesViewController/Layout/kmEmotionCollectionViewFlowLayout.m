//
//  kmEmotionCollectionViewFlowLayout.m
//  JSQMessages
//
//  Created by Keye Myria on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmotionCollectionViewFlowLayout.h"

#import "kmEmotion.h"


@implementation kmEmotionCollectionViewFlowLayout

- (instancetype)init {
	self = [super init];
	if (self) {
		self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		self.itemSize = CGSizeMake(kmEmotionImageViewSize, kmEmotionImageViewSize);
		int count = [[UIScreen mainScreen] bounds].size.width/(kmEmotionImageViewSize + kmEmotionMinimumLineSpacing);
		CGFloat spacing = [[UIScreen mainScreen] bounds].size.width/count - kmEmotionImageViewSize;
		self.minimumInteritemSpacing = spacing;
		self.sectionInset = UIEdgeInsetsMake(10, spacing/2, 0, spacing/2);
		self.collectionView.alwaysBounceVertical = YES;
	}
	return self;
}


@end
