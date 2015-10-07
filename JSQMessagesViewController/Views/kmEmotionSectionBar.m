//
//  kmEmotionSectionBar.m
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmotionSectionBar.h"

@interface kmEmotionSectionBar ()




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
	
}

- (void)configureView {
	
	
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self reloadData];
	}
}

- (void)reloadData {
	
}


@end
