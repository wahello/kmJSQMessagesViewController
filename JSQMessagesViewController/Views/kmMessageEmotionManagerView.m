//
//  kmMessageEmojiManager.m
//  JSQMessages
//
//  Created by Keye Myria on 10/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMessageEmotionManagerView.h"

#import "kmEmotionCollectionViewFlowLayout.h"
#import "kmEmotionCollectionViewCell.h"


#define kmPageControlHeight 38
#define kmSectionBarHeight 36


@interface kmMessageEmotionManagerView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIPageControl *emotionPageControl;

@property (nonatomic, strong) UICollectionView *emotionCollectionView;

@property (nonatomic, strong) UIScrollView *emojiContainerView;

@property (nonatomic, weak) kmEmotionSectionBar *emotionSectionBar;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSDictionary *classicEmojis;

@end


@implementation kmMessageEmotionManagerView

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

- (void)configureView {
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.selectedIndex = 0;
	if (!_emotionCollectionView) {
		UICollectionView *ecv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) collectionViewLayout:[[kmEmotionCollectionViewFlowLayout alloc] init]];
		[ecv registerClass:[kmEmotionCollectionViewCell class] forCellWithReuseIdentifier:kmEmotionCollectionViewCellIdentifier];
		ecv.backgroundColor = self.backgroundColor;
		
		ecv.showsHorizontalScrollIndicator = NO;
		ecv.showsVerticalScrollIndicator = NO;
		[ecv setScrollsToTop:NO];
		ecv.pagingEnabled = YES;
		ecv.delegate = self;
		ecv.dataSource = self;
		[self addSubview:ecv];
		self.emotionCollectionView = ecv;
	}
	
	if (!_emotionPageControl) {
		UIPageControl *epageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bounds) - kmPageControlHeight - kmSectionBarHeight, CGRectGetWidth(self.bounds), kmPageControlHeight)];
		epageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.678 alpha:1.000];
		epageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.471 alpha:1.000];
		epageControl.backgroundColor = self.backgroundColor;
		epageControl.hidesForSinglePage = YES;
		epageControl.defersCurrentPageDisplay = YES;
		[self addSubview:epageControl];
		self.emotionPageControl = epageControl;
	}
	if (!_emotionSectionBar) {
		kmEmotionSectionBar *esb = [[kmEmotionSectionBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionPageControl.frame), CGRectGetWidth(self.bounds), kmSectionBarHeight)];
		esb.delegate = self;
		esb.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		esb.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
		[self addSubview:esb];
		self.emotionSectionBar = esb;
	}
}

- (void)dealloc {
	self.emotionPageControl = nil;
	self.emojiContainerView = nil;
	self.emotionCollectionView.dataSource = nil;
	self.emotionCollectionView.delegate = nil;
	self.emotionCollectionView = nil;
	self.classicEmojis = nil;
}

- (void)reloadData {

	NSInteger numberOfEmotionManagers = [self.emotionDatasource numberOfEmotionManagers];
	if (numberOfEmotionManagers == 0) {
		return;
	}
	self.emotionSectionBar.emotionManagers = [self.emotionDatasource emotionManagersAtManager];
	[self.emotionSectionBar reloadData];
	
	kmEmotionManager *emtionManager = [self.emotionDatasource emotionManagerForColumn:self.selectedIndex];
	
	if ( kmEmotionTypeClassic == emtionManager.emotionType) {
		NSString *classicEmojiDir = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:emtionManager.emotionResourceDir];
		NSBundle *cmbundle = [NSBundle bundleWithPath:classicEmojiDir];
		
		NSString *cemojiPlist = [cmbundle pathForResource:@"classicEmoji" ofType:@"plist"];
		NSDictionary *emojis = [NSDictionary dictionaryWithContentsOfFile:cemojiPlist];
		self.classicEmojis = emojis;
		
		NSString *plistArrPath = [cmbundle pathForResource:@"classicEmojiKeys" ofType:@"plist"];
		NSArray *allKeys = [NSArray arrayWithContentsOfFile:plistArrPath];
		NSInteger ps = [allKeys count]/20;
		
		if (!_emojiContainerView) {
			
			CGRect frame = CGRectMake(0, 0,
										  CGRectGetWidth(self.bounds),
										  CGRectGetHeight(self.bounds) - kmPageControlHeight - kmSectionBarHeight);
			UIScrollView *escv = [[UIScrollView alloc] initWithFrame:frame];
			escv.backgroundColor = //[UIColor redColor];
									self.backgroundColor;
			
			for (NSInteger ii = 0; ii < ps; ii ++) {
				
				frame = CGRectMake(ii * CGRectGetWidth(self.bounds),
								   0.0f, CGRectGetWidth(self.bounds),
								   CGRectGetHeight(escv.bounds));
				
				NSArray *subarr = [allKeys subarrayWithRange:NSMakeRange(ii * 20, 20)];
				NSString *delePath = [[cmbundle bundlePath] stringByAppendingPathComponent:@"DeleteEmoticonBtn_ios7"];
				kmClassicEmojiView *cEmojiView = [[kmClassicEmojiView alloc] initWithFrame:frame keys:subarr dict:self.classicEmojis emojiPath:classicEmojiDir delPath:delePath atPageIndex:ps];
				cEmojiView.backgroundColor = self.backgroundColor;
											//[UIColor greenColor];
				cEmojiView.emojiDelegate = self;
				[escv addSubview:cEmojiView];
			}
			escv.delegate = self;
			escv.scrollEnabled = YES;
			escv.pagingEnabled = YES;
			escv.showsHorizontalScrollIndicator = NO;
			escv.showsVerticalScrollIndicator = NO;
			
			[escv setContentSize:CGSizeMake(ps*CGRectGetWidth(self.bounds), CGRectGetHeight(escv.bounds))];
			
			[self addSubview:escv];
			_emojiContainerView = escv;
			
		}
		self.emotionPageControl.numberOfPages = ps;
		
		self.emotionCollectionView.hidden = YES;
		self.emojiContainerView.hidden = NO;
		
		NSString *inputedText = [self.emotionDelegate textThatInputed];
		if (!inputedText || [inputedText length] == 0) {
			[self.emotionSectionBar changeSendButtonBackgroundColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor]];
		} else {
			[self.emotionSectionBar changeSendButtonBackgroundColor:[UIColor blueColor] titleColor:[UIColor whiteColor]];
		}
		
	} else {
		self.emojiContainerView.hidden = YES;
		self.emotionCollectionView.hidden = NO;
		
		NSInteger numberOfEmotions = emtionManager.emotions.count;
		self.emotionPageControl.numberOfPages = numberOfEmotions/(kmEmotionPerRowItemCount*2) + (numberOfEmotions%(kmEmotionPerRowItemCount *2)?1:0);
		[self.emotionCollectionView reloadData];
	}
	
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self reloadData];
	}
}

-(void)emojiView:(kmClassicEmojiView *)emojiView didSelectEmoji:(NSString *)emojiName isDelete:(BOOL)isdele {
	NSLog(@" emojiName - %@ ", emojiName);
	if ([self.emotionDelegate respondsToSelector:@selector(didSelectedEmoji:isDele:)]) {
		[self.emotionDelegate didSelectedEmoji:emojiName isDele:isdele];
		[self reloadData];
	}
}

#pragma mark -- kmEmotionSectionBar Delegate

- (void)didSelectEmotionManager:(kmEmotionManager *)emotionManager atSection:(NSInteger)section {
	NSLog(@" - section --- %d", section);
	self.selectedIndex = section;
	self.emotionPageControl.currentPage = 0;
	[self reloadData];
}

- (void)didSendButtonClicked {
	if ([self.emotionDelegate respondsToSelector:@selector(emojiSendButtonClicked)]) {
		[self.emotionDelegate emojiSendButtonClicked];
		[self reloadData];
	}
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	CGFloat pageWidth = scrollView.frame.size.width;
	
	NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
	[self.emotionPageControl setCurrentPage:currentPage];
}


#pragma UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	kmEmotionManager *emgr = [self.emotionDatasource emotionManagerForColumn:section];
	NSInteger count = emgr.emotions.count;
	if (emgr.emotionType == kmEmotionTypeClassic) {
		return 0;
	}
	return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	kmEmotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kmEmotionCollectionViewCellIdentifier forIndexPath:indexPath];
	kmEmotionManager *emgr = [self.emotionDatasource emotionManagerForColumn:self.selectedIndex];
	cell.emotion = emgr.emotions[indexPath.row];
	return cell;
}

#pragma UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.emotionDelegate respondsToSelector:@selector(didSelectEmotion:atIndexPath:)]) {
		kmEmotionManager *emgr = [self.emotionDatasource emotionManagerForColumn:indexPath.section];
		[self.emotionDelegate didSelectEmotion:emgr.emotions[indexPath.row] atIndexPath:indexPath];
	}
}


@end
