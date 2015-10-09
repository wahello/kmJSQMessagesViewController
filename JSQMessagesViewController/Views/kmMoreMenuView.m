//
//  kmMoreMenuView.m
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMoreMenuView.h"

#import "kmMessageEmotionManagerView.h"

static CGFloat const kmMenuPageControlHeight = 30;
static NSString *const kmoreCollectionViewCellIdentifier = @"kmoreCollectionViewCellIdentifier";

#define kmMoreMenuItemWidth 60
#define kmMoreMenuItemHeight 80

#define kmShareMenuPerRowItemCount ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 10 : 4)
#define kmShareMenuPerColumn 2


@interface kmMoreMenuItemView : UIView

@property (nonatomic, weak) UIButton *menuItemButton;

@property (nonatomic, weak) UILabel *menuItemTitleLabel;

@end

@implementation kmMoreMenuItemView

- (void)configureView {
	if (!_menuItemButton) {
		UIButton *miButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
		miButton.frame = CGRectMake(0, 0, kmMoreMenuItemWidth, kmMoreMenuItemWidth);
		miButton.backgroundColor = [UIColor clearColor];
		[self addSubview:miButton];
		self.menuItemButton = miButton;
	}
	
	if (!_menuItemTitleLabel) {
		UILabel *miLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuItemButton.frame), kmMoreMenuItemWidth, kmMoreMenuItemHeight - kmMoreMenuItemWidth)];
		miLabel.backgroundColor = [UIColor clearColor];
		miLabel.textColor = [UIColor blackColor];
		miLabel.font = [UIFont systemFontOfSize:13];
		miLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:miLabel];
		self.menuItemTitleLabel = miLabel;
	}
}

- (void)awakeFromNib {
	[self configureView];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self configureView];
	}
	return self;
}

@end


@interface kmMoreMenuView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *menuScrollView;

@property (nonatomic, weak) UIPageControl *menuPageControl;


@end

@implementation kmMoreMenuView

- (void)menuItemButtonAction:(UIButton*)sender {
	if ([self.delegate respondsToSelector:@selector(didSelecteShareMenuItem:atIndex:)]) {
		NSInteger index = sender.tag;
		if (index < self.shareMenuItems.count) {
			[self.delegate didSelecteShareMenuItem:[self.shareMenuItems objectAtIndex:index] atIndex:index];
		}
	}
}

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

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self reloadData];
	}
}


- (void)configureView {
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	if (!_menuScrollView) {
		CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds),
								  CGRectGetHeight(self.bounds) - kmMenuPageControlHeight);
		UIScrollView *mscrollview = [[UIScrollView alloc] initWithFrame:frame];
		mscrollview.delegate = self;
		mscrollview.canCancelContentTouches = NO;
		mscrollview.delaysContentTouches = YES;
		mscrollview.showsHorizontalScrollIndicator = NO;
		mscrollview.showsVerticalScrollIndicator = NO;
		[mscrollview setScrollsToTop:NO];
		mscrollview.pagingEnabled = YES;
		
		[self addSubview:mscrollview];
		self.menuScrollView = mscrollview;
	}
	
	if (!_menuPageControl) {
		CGRect frame = CGRectMake(0, CGRectGetMaxY(self.menuScrollView.frame),
								  CGRectGetWidth(self.bounds), kmMenuPageControlHeight);
		UIPageControl *mpc = [[UIPageControl alloc] initWithFrame:frame];
		mpc.backgroundColor = self.backgroundColor;
		mpc.hidesForSinglePage = YES;
		mpc.defersCurrentPageDisplay = YES;
		[self addSubview:mpc];
		self.menuPageControl = mpc;
	}
}

- (void)setShareMenuItems:(NSArray *)shareMenuItems {
	_shareMenuItems = shareMenuItems;
	if (shareMenuItems) {
		[self reloadData];
	}
}

- (void)reloadData {
	if (!_shareMenuItems.count) { return; }
	
	[[self.menuScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	CGFloat scw = [[UIScreen mainScreen] bounds].size.width;
	CGFloat paddingX = (scw - 60 * 4)/5.0;
	CGFloat paddingY = (scw > 320) ? 13:10;
	
	for (kmMoreMenuItem *anItem in self.shareMenuItems) {
		NSInteger index = [self.shareMenuItems indexOfObject:anItem];
		NSInteger page = index / (kmShareMenuPerRowItemCount * kmShareMenuPerColumn);
		CGRect miframe = [self getFrameWithPerRowItemCount:kmShareMenuPerRowItemCount
														perColumItemCount:kmShareMenuPerColumn
																itemWidth:kmoreMenuItemWidth
															   itemHeight:kmoreMenuItemHeight
																 paddingX:paddingX
																 paddingY:paddingY
																  atIndex:index
																   onPage:page];
		
		kmMoreMenuItemView *mmItemView = [[kmMoreMenuItemView alloc] initWithFrame:miframe];
		mmItemView.menuItemButton.tag = index;
		[mmItemView.menuItemButton addTarget:self action:@selector(menuItemButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
		[mmItemView.menuItemButton setImage:anItem.normalIconImage forState:(UIControlStateNormal)];
		[mmItemView.menuItemButton setImage:anItem.highlightIconImage forState:(UIControlStateHighlighted)];
		mmItemView.menuItemTitleLabel.text = anItem.title;

		[self.menuScrollView addSubview:mmItemView];
	}
	
	self.menuPageControl.numberOfPages = (self.shareMenuItems.count / (kmShareMenuPerRowItemCount * 2) + (self.shareMenuItems.count % (kmShareMenuPerRowItemCount * 2)?1:0));
	[self.menuScrollView setContentSize:CGSizeMake(self.menuPageControl.numberOfPages * CGRectGetWidth(self.bounds),
												   CGRectGetHeight(self.menuScrollView.bounds))];
	
}

- (void)dealloc {
	self.shareMenuItems = nil;
	self.menuScrollView.delegate = nil;
	self.menuScrollView = nil;
	self.menuPageControl = nil;
}

/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithPerRowItemCount:(NSInteger)perRowItemCount
					perColumItemCount:(NSInteger)perColumItemCount
							itemWidth:(CGFloat)itemWidth
						   itemHeight:(NSInteger)itemHeight
							 paddingX:(CGFloat)paddingX
							 paddingY:(CGFloat)paddingY
							  atIndex:(NSInteger)index
							   onPage:(NSInteger)page {
	CGRect itemFrame =
	CGRectMake((index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds)),
			   ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY,
			   itemWidth,
			   itemHeight);
	return itemFrame;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	CGFloat pageWidth = CGRectGetWidth(scrollView.bounds);
	NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
	[self.menuPageControl setCurrentPage:currentPage];
}


@end
