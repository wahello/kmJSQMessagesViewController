//
//  kmFileMediaItem.h
//  JSQMessages
//
//  Created by Keye Myria on 10/14/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMediaItem.h"



@interface kmFileMediaItem : JSQMediaItem<JSQMessageMediaData, NSCoding, NSCopying>


@property (nonatomic, copy) NSString *fileURL;


@property (nonatomic, copy) NSString *filePath;


@property (nonatomic, copy) UIImage *standImage;

- (instancetype)initWithImage:(UIImage *)image fileURL:(NSString *)fileUrl filePath:(NSString *)filePath;


@end
