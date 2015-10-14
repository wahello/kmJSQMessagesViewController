//
//  kmEmotionSectionBar.m
//  JSQMessages
//
//  Created by Keye Myria on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmotionSectionBar.h"

#define kmSendButtonWidth  45


@interface kmEmotionSectionBar ()



@property (nonatomic, weak) UIScrollView *sectionBarScrollView;
@property (nonatomic, strong) NSMutableArray *sbuttons;

@property (nonatomic, weak) UIButton *sendButton;

@end

@implementation kmEmotionSectionBar

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self configureView];
	}
	return self;
}


- (void)dealloc {
	self.emotionManagers = nil;
	[self.sbuttons removeAllObjects];
	self.sbuttons = nil;
}

- (void)configureView {
	
	if (!_sectionBarScrollView) {
		UIScrollView *scv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
		[scv setScrollsToTop:NO];
		
		scv.showsHorizontalScrollIndicator = NO;
		scv.showsVerticalScrollIndicator = NO;
		scv.pagingEnabled = NO;
		[self addSubview:scv];
		_sectionBarScrollView = scv;
	}
	
	if (!_sendButton) {
		UIButton *sendBtn = [self createButton:@selector(sendButtonAction:)];
		CGRect frame = sendBtn.frame;
		frame.origin.x = CGRectGetWidth(self.bounds) - kmSendButtonWidth;
		sendBtn.frame = frame;
		
		[sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
		[sendBtn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
		[self addSubview:sendBtn];
		_sendButton = sendBtn;
	}
	
	if (!_sbuttons) {
		NSMutableArray *tarr = [[NSMutableArray alloc] init];
		self.sbuttons = tarr;
	}
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self reloadData];
	}
}

- (UIButton *)createButton:(SEL)selector {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake( 0, 0, kmSendButtonWidth, CGRectGetHeight(self.bounds));
	[button addTarget:self action:selector forControlEvents:(UIControlEventTouchUpInside)];
	return button;
}

- (UIButton *)createButton {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake( 0, 0, kmSendButtonWidth, CGRectGetHeight(self.bounds));
	[button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	return button;
}

- (void)reloadData {
	if (self.emotionManagers.count == 0) {
		return;
	}
	[self.sectionBarScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[self.sbuttons removeAllObjects];
	CGFloat lastX = 0;
	for (kmEmotionManager *emgr in self.emotionManagers) {
		NSInteger index = [self.emotionManagers indexOfObject:emgr];
		UIButton *sbtn = [self createButton];
		sbtn.tag = index;
		
		[sbtn setTitle:emgr.emotionName forState:(UIControlStateNormal)];
		[sbtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
		[sbtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
		
		sbtn.titleLabel.font = [UIFont systemFontOfSize:14];
		
		CGRect frame = sbtn.frame;
		frame.origin.x = lastX;
						//index * CGRectGetWidth(frame);
		sbtn.frame = frame;
		lastX = frame.origin.x + frame.size.width;
		[self.sectionBarScrollView addSubview:sbtn];
		[self.sbuttons addObject:sbtn];
	}
	[self.sectionBarScrollView setContentSize:CGSizeMake(lastX, CGRectGetHeight(self.bounds))];
}

- (void)changeSendButtonBackgroundColor:(UIColor *)bgcolor titleColor:(UIColor *)titleColor {
	_sendButton.backgroundColor = bgcolor;
	[_sendButton setTitleColor:titleColor forState:(UIControlStateNormal)];
}

#pragma mark -- actions

- (void)sendButtonAction:(UIButton*)sender {
	if ([self.delegate respondsToSelector:@selector(didSendButtonClicked)]) {
		[self.delegate didSendButtonClicked];
	}
}

- (void)sectionButtonClicked:(UIButton *)sender {
	
	if ([self.delegate respondsToSelector:@selector(didSelectEmotionManager:atSection:)]) {
		NSInteger section = sender.tag;
		if (section < self.emotionManagers.count) {
			[self.delegate didSelectEmotionManager:[self.emotionManagers objectAtIndex:section] atSection:section];
		}
	}
	
	for (UIButton *tbtn in self.sbuttons) {
		[tbtn setBackgroundColor:[UIColor whiteColor]];
		[tbtn setSelected:NO];
		
		if ( tbtn.tag == sender.tag ) {
			tbtn.selected = YES;
			[tbtn setBackgroundColor:[UIColor lightGrayColor]];
		}
	}
}


@end
