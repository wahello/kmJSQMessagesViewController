//
//  kmMoreMenuViewFlowLayout.m
//  JSQMessages
//
//  Created by dulian on 10/8/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMoreMenuViewFlowLayout.h"

#import "kmMessageEmotionManagerView.h"

@implementation kmMoreMenuViewFlowLayout


- (instancetype)init {
	self = [super init];
	if (self) {
		self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		self.itemSize = CGSizeMake(kmoreMenuItemWidth, kmoreMenuItemHeight);
		NSInteger count = [[UIScreen mainScreen] bounds].size.width/(kmoreMenuItemHeight + kmoreMiniLineSpacing);
		CGFloat spacing = [[UIScreen mainScreen] bounds].size.width/count - kmoreMenuItemWidth;
		self.minimumInteritemSpacing = spacing;
		self.sectionInset = UIEdgeInsetsMake(10, spacing/2, 0, spacing/2);
		self.collectionView.alwaysBounceVertical = YES;
	}
	return self;
}


@end
