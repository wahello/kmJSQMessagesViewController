//
//  kmEmotionCollectionViewCell.m
//  JSQMessages
//
//  Created by dulian on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmEmotionCollectionViewCell.h"

@interface kmEmotionCollectionViewCell ()

@property (nonatomic, weak) UIImageView *emotionImageView;


@end

@implementation kmEmotionCollectionViewCell

- (void)setEmotion:(kmEmotion *)emotion {
	_emotion = emotion;
	
	self.emotionImageView.image = emotion.emotionConverPhoto;
}

- (void)configureView {
	if (!_emotionImageView) {
		UIImageView *eiv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kmEmotionImageViewSize, kmEmotionImageViewSize)];
		eiv.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
		[self.contentView addSubview:eiv];
		self.emotionImageView = eiv;
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

- (void)dealloc {
	self.emotion = nil;
}

@end
