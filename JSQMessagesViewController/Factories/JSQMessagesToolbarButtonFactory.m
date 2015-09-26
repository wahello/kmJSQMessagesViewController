//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "NSBundle+JSQMessages.h"


@implementation JSQMessagesToolbarButtonFactory

+ (UIButton *)defaultAccessoryButtonItem
{
    UIImage *accessoryImage = [UIImage jsq_defaultAccessoryImage];
    UIImage *normalImage = [accessoryImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    UIImage *highlightedImage = [accessoryImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];

    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, accessoryImage.size.width, 32.0f)];
    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];

    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];

    return accessoryButton;
}

+ (UIButton *)defaultEmotionButtonItem {
	UIImage *normalImage = [UIImage jsq_emotionImage];
	UIImage *highlightedImage = [UIImage jsq_emotionHighligthImage];
	UIImage *selectedImage = [UIImage jsq_keyboardImage];
	
	UIButton *emotionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width, normalImage.size.height)];
	[emotionButton setImage:normalImage forState:(UIControlStateNormal)];
	[emotionButton setImage:highlightedImage forState:(UIControlStateHighlighted)];
	[emotionButton setImage:selectedImage forState:(UIControlStateSelected)];
	
	emotionButton.contentMode = UIViewContentModeScaleAspectFit;
	emotionButton.backgroundColor = [UIColor clearColor];
	emotionButton.tintColor = [UIColor lightGrayColor];
	
	return emotionButton;
}

+ (UIButton*)defaultVoiceButtonItem {
	UIImage *normalImage = [UIImage jsq_inputVoiceImage];
	UIImage *highlightedImage = [UIImage jsq_inputVoiceHighligthImage];
	UIImage *selectedImage = [UIImage jsq_keyboardImage];
	
	UIButton *voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width, normalImage.size.height)];
	[voiceButton setImage:normalImage forState:(UIControlStateNormal)];
	[voiceButton setImage:highlightedImage forState:(UIControlStateHighlighted)];
	[voiceButton setImage:selectedImage forState:(UIControlStateSelected)];
	
	voiceButton.contentMode = UIViewContentModeScaleAspectFit;
	voiceButton.backgroundColor = [UIColor clearColor];
	voiceButton.tintColor = [UIColor lightGrayColor];
	
	return voiceButton;
}

+ (UIButton*)defaultKeyboardButtonItem {
	UIImage *normalImage = [UIImage jsq_keyboardImage];
	UIImage *highlightedImage = [UIImage jsq_keyboardHighligthImage];
	
	UIButton *keyboarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width, normalImage.size.height)];
	[keyboarButton setImage:normalImage forState:(UIControlStateNormal)];
	[keyboarButton setImage:highlightedImage forState:(UIControlStateHighlighted)];
	
	keyboarButton.contentMode = UIViewContentModeScaleAspectFit;
	keyboarButton.backgroundColor = [UIColor clearColor];
	keyboarButton.tintColor = [UIColor lightGrayColor];
	
	return keyboarButton;
}

+ (UIButton*)defaultMoreSelectButtonItem {
	UIImage *normalImage = [UIImage jsq_moreSelectImage];
	UIImage *highlightedImage = [UIImage jsq_moreSelectHightlightImage];
	UIImage *selectedImage = [UIImage jsq_keyboardImage];
	
	UIButton *moreSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width, normalImage.size.height)];
	[moreSelectButton setImage:normalImage forState:(UIControlStateNormal)];
	[moreSelectButton setImage:highlightedImage forState:(UIControlStateHighlighted)];
	[moreSelectButton setImage:selectedImage forState:(UIControlStateSelected)];
	
	moreSelectButton.contentMode = UIViewContentModeScaleAspectFit;
	moreSelectButton.backgroundColor = [UIColor clearColor];
	moreSelectButton.tintColor = [UIColor lightGrayColor];
	
	return moreSelectButton;
}

+ (UIButton *)defaultSendButtonItem
{
    NSString *sendTitle = [NSBundle jsq_localizedStringForKey:@"send"];

    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];

    CGFloat maxHeight = 32.0f;

    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
                                                   context:nil];

    sendButton.frame = CGRectMake(0.0f,
                                  0.0f,
                                  CGRectGetWidth(CGRectIntegral(sendTitleRect)),
                                  maxHeight);

    return sendButton;
}

@end
