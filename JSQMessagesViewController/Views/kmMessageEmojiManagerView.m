//
//  kmMessageEmojiManager.m
//  JSQMessages
//
//  Created by dulian on 10/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMessageEmojiManagerView.h"


#define kmPageControlHeight 38
#define kmSectionBarHeight 36


@interface kmMessageEmojiManagerView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *emotionPageControl;


@property (nonatomic, strong) UIScrollView *emojiContainerView;

//@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSDictionary *classicEmojis;

@end


@implementation kmMessageEmojiManagerView

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
	
	self.emotionType = kmEmotionTypeClassic;
	
}

- (void)dealloc {
	
	self.emotionPageControl = nil;
	self.emojiContainerView = nil;
	self.classicEmojis = nil;
	
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self reloadData];
	}
}

- (void)reloadData {
	
	
	if ( kmEmotionTypeClassic == self.emotionType && _classicEmojiDir) {
		NSBundle *cmbundle = [NSBundle bundleWithPath:_classicEmojiDir];
		
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
				kmClassicEmojiView *cEmojiView = [[kmClassicEmojiView alloc] initWithFrame:frame keys:subarr dict:self.classicEmojis emojiPath:self.classicEmojiDir delPath:delePath atPageIndex:ps];
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
		
	}
	
}

- (void)setClassicEmojiDir:(NSString *)classicEmojiDir {
	if (_classicEmojiDir == classicEmojiDir	) {
		return;
	}
	_classicEmojiDir = classicEmojiDir;
	[self reloadData];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	CGFloat pageWidth = scrollView.frame.size.width;
	
	NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
	[self.emotionPageControl setCurrentPage:currentPage];
}


-(void)emojiView:(kmClassicEmojiView *)emojiView didSelectEmoji:(NSString *)emojiName isDelete:(BOOL)isdele {
	NSLog(@" emojiName - %@ ", emojiName);
	
	
}

@end
