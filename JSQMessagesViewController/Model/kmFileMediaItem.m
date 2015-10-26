//
//  kmFileMediaItem.m
//  JSQMessages
//
//  Created by Keye Myria on 10/14/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "kmFileMediaItem.h"


#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"


@interface kmFileMediaItem ()

@property (strong, nonatomic) UIImageView *cachedStandImageView;

@end


@implementation kmFileMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image fileURL:(NSString *)fileUrl filePath:(NSString *)filePath{
	self = [super init];
	if (self) {
		_standImage = [image copy];
		_fileURL = fileUrl;
		_filePath = filePath;
	}
	return self;
}

- (void)dealloc {
	
	_cachedStandImageView = nil;
}

- (void)clearCachedMediaViews {
	[super clearCachedMediaViews];
	_cachedStandImageView = nil;
}

#pragma mark -- setters

- (void)setFileURL:(NSString *)fileURL {
	_fileURL = [fileURL copy];
	_cachedStandImageView = nil;
}

- (void)setFilePath:(NSString *)filePath {
	_filePath = filePath;
	_cachedStandImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing {
	[super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
	_cachedStandImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView {
	if ( nil == self.filePath) {
		return nil;
	}
	
	if (self.cachedStandImageView == nil) {
		CGSize size = [self mediaViewDisplaySize];
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:self.standImage];
		imageView.frame = CGRectMake(0, 0, size.width, size.height);
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		[JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
		self.cachedStandImageView = imageView;
	}
	
	return self.cachedStandImageView;
}

- (NSUInteger)hash {
	return self.hash ^ self.filePath.hash;
}

- (NSString *) description {
	return  [NSString stringWithFormat:@"<%@: fileURL:%@ filePath:%@ appliesMediaViewMaskAsOutgoing=%@>", [self class], self.fileURL, self.filePath, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		_standImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(standImage))];
		_fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
		_filePath = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(filePath))];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(standImage))];
	[aCoder encodeObject:self.filePath forKey:NSStringFromSelector(@selector(filePath))];
	[aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(fileURL))];
}

- (instancetype)copyWithZone:(NSZone *)zone {
	kmFileMediaItem *copy = [[[self class] allocWithZone:zone] initWithImage:self.standImage fileURL:self.fileURL filePath:self.filePath];
	copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
	return copy;
}

@end
