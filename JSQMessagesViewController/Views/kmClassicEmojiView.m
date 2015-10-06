//
//  kmClassicEmojiView.m
//  JSQMessages
//
//  Created by dulian on 10/6/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmClassicEmojiView.h"

#define NumPerLine 7
#define Lines    3
#define FaceSize  30


#define EdgeDistance 20

#define EdgeInterVal 5



@interface kmClassicEmojiView ()

@property (nonatomic, strong) NSArray *partKeys;
@property (nonatomic, assign) NSInteger pageIndex;


@end

@implementation kmClassicEmojiView


- (id)initWithFrame:(CGRect)frame keys:(NSArray*)keys dict:(NSDictionary*)tdict emojiPath:(NSString*)epath delPath:(NSString*)delpath atPageIndex:(NSInteger)pindex {
	
	self = [super initWithFrame:frame];
	if (self) {
		
		self.tag = pindex;
		self.partKeys = keys;
		
		CGFloat horizontalInterval = (CGRectGetWidth(self.bounds)-NumPerLine*FaceSize -2*EdgeDistance)/(NumPerLine-1);
		
		CGFloat verticalInterval = (CGRectGetHeight(self.bounds) - 2*EdgeInterVal - 10 - Lines*FaceSize)/(Lines-1);
		
		for	( NSString *akey in keys ) {
			
			NSInteger index = [keys indexOfObject:akey];
			NSString *aval = [tdict objectForKey:akey];
			
			CGFloat ox = 0; CGFloat oy = 0;
			NSInteger mod = index % NumPerLine;
			NSInteger lno = index/NumPerLine;
			
			ox = mod * FaceSize + EdgeDistance + mod * horizontalInterval;
			oy = lno * FaceSize + lno * verticalInterval + EdgeInterVal + 10;
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			CGRect bframe = CGRectMake(ox, oy, FaceSize, FaceSize);
			button.frame = bframe;
			NSString *eimgname = [epath stringByAppendingPathComponent:aval];
			[button setBackgroundImage:[UIImage imageNamed:eimgname]
							  forState:UIControlStateNormal];
			[button addTarget:self action:@selector(faceClick:)
			 forControlEvents:(UIControlEventTouchUpInside)];
			button.tag = index;
			[self addSubview:button];
		}
		
		UIView* lv = [self viewWithTag:[keys count]-1];
		CGRect lframe = lv.frame;
		UIButton *dbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
		lframe.origin.x += horizontalInterval + FaceSize;
		dbtn.frame = lframe;
		
		[dbtn setBackgroundImage:[UIImage imageNamed:delpath] forState:(UIControlStateNormal)];
		dbtn.tag = [keys count];
		[dbtn addTarget:self action:@selector(faceClick:) forControlEvents:(UIControlEventTouchUpInside)];
		[self addSubview:dbtn];
		
	}
	return self;
}

- (void)faceClick:(UIButton*)button {
	
//	int stag = self.tag;
	int tag = button.tag;
	if ( tag < [self.partKeys count] ) {
		NSString *akey = [self.partKeys objectAtIndex:tag];
		NSLog(@" akey %@ ", akey);
		if ([self.emojiDelegate respondsToSelector:@selector(emojiView:didSelectEmoji:isDelete:)]) {
			[self.emojiDelegate emojiView:self didSelectEmoji:akey isDelete:NO];
		}
	} else {
		if ([self.emojiDelegate respondsToSelector:@selector(emojiView:didSelectEmoji:isDelete:)]) {
			[self.emojiDelegate emojiView:self didSelectEmoji:nil isDelete:YES];
		}
	}
}

@end
