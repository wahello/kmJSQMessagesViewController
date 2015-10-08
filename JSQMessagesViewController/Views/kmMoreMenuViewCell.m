//
//  kmMoreMenuViewCell.m
//  JSQMessages
//
//  Created by dulian on 10/8/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmMoreMenuViewCell.h"

@interface kmMoreMenuViewCell ()

@property (nonatomic, weak) UIImageView *menuImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation kmMoreMenuViewCell

- (void)setMoreMenuItem:(kmMoreMenuItem *)moreMenuItem {
	_moreMenuItem = moreMenuItem;
	self.menuImageView.image = moreMenuItem.normalIconImage;
	self.menuImageView.highlightedImage = moreMenuItem.highlightIconImage;
	self.titleLabel.text = moreMenuItem.title;
}

- (void)prepareForReuse {
	self.menuImageView.image = nil;
	self.titleLabel.text = nil;
	self.menuImageView.highlightedImage = nil;
}

- (void)configureView {
	if (!_menuImageView) {
		UIImageView *emImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kmMoreMenuItemWidth, kmMoreMenuItemWidth)];
		emImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
		[self.contentView addSubview:emImageView];
		self.menuImageView = emImageView;
	}
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_menuImageView.frame), kmMoreMenuItemWidth, kmMoreMenuItemHeight - kmMoreMenuItemWidth)];
		label.backgroundColor = [UIColor cyanColor];
		label.font = [UIFont systemFontOfSize:13];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		self.titleLabel = label;
	}
	self.backgroundColor = [UIColor redColor];
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
