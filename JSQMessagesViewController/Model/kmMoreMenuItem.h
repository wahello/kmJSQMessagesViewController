//
//  kmMoreMenuItem.h
//  JSQMessages
//
//  Created by Keye Myria on 10/7/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface kmMoreMenuItem : NSObject


@property (nonatomic, strong) UIImage *normalIconImage;

@property (nonatomic, strong) UIImage *highlightIconImage;


@property (nonatomic, copy) NSString *title;


- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
								  title:(NSString *)title;
- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
					 highlightIconImage:(UIImage *)highlightIconImage
								  title:(NSString *)title;


@end
