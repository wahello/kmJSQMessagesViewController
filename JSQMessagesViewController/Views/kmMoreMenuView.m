//
//  kmMoreMenuView.m
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMoreMenuView.h"

#import "kmMoreMenuViewCell.h"

#import "kmMoreMenuViewFlowLayout.h"
#import "kmMessageEmotionManagerView.h"

static NSString *const kmoreCollectionViewCellIdentifier = @"kmoreCollectionViewCellIdentifier";

@interface kmMoreMenuView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateLeftAlignedLayout>

@property (nonatomic, strong) UICollectionView *moCollectionView;

@end

@implementation kmMoreMenuView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self configureView];
	}
	return self;
}

- (void)awakeFromNib {
	[self configureView];
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//	if (newSuperview) {
//		[self reloadData];
//	}
//}

- (void)dealloc {
	self.shareMenuItems = nil;
}

- (void)configureView {
	
	if (!_moCollectionView) {
		CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
		UICollectionViewLeftAlignedLayout *layout = //[[UICollectionViewLeftAlignedLayout alloc] init];
													[[kmMoreMenuViewFlowLayout alloc] init];
		UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame
															  collectionViewLayout:layout];
		[collectionView registerClass:[kmMoreMenuViewCell class] forCellWithReuseIdentifier:kmoreCollectionViewCellIdentifier];
		
		collectionView.backgroundColor = [UIColor greenColor];
		collectionView.delegate = self;
		collectionView.dataSource = self;
		collectionView.pagingEnabled = YES;
		[collectionView setScrollEnabled:NO];
		collectionView.showsHorizontalScrollIndicator = NO;
		collectionView.showsVerticalScrollIndicator = NO;
		collectionView.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
		[self addSubview:collectionView];
		self.moCollectionView = collectionView;
	}
	
}

- (void)setShareMenuItems:(NSArray *)shareMenuItems {
	_shareMenuItems = shareMenuItems;
	if (shareMenuItems) {
		[self reloadData];
	}
}
- (void)reloadData {
	[self.moCollectionView reloadData];
}

#pragma mark -- UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.shareMenuItems.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	kmMoreMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kmoreCollectionViewCellIdentifier forIndexPath:indexPath];
	kmMoreMenuItem *anitem = [self.shareMenuItems objectAtIndex:indexPath.row];
	cell.moreMenuItem = anitem;
	
	return cell;
}


#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.delegate respondsToSelector:@selector(didSelecteShareMenuItem:atIndex:)]) {
		kmMoreMenuItem *aitem = [self.shareMenuItems objectAtIndex:indexPath.row];
		[self.delegate didSelecteShareMenuItem:aitem atIndex:indexPath.row];
	}
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//	CGSize size = CGSizeMake(kmoreMenuItemWidth, kmoreMenuItemHeight);
//	return size;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//	NSInteger count = [[UIScreen mainScreen] bounds].size.width/(kmoreMenuItemHeight + kmoreMiniLineSpacing);
//	CGFloat spacing = [[UIScreen mainScreen] bounds].size.width/count - kmoreMenuItemWidth;
//	return spacing;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//	
//	NSInteger count = [[UIScreen mainScreen] bounds].size.width/(kmoreMenuItemHeight + kmoreMiniLineSpacing);
//	CGFloat spacing = [[UIScreen mainScreen] bounds].size.width/count - kmoreMenuItemWidth;
////	self.minimumInteritemSpacing = spacing;
//	return UIEdgeInsetsMake(10, spacing/2, 0, spacing/2);
//}


@end
