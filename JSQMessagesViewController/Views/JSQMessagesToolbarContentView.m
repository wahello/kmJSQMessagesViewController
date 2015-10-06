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

#import "JSQMessagesToolbarContentView.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 8.0f;

const NSInteger kmKeyboardButtonTag = 1000;
const NSInteger kmVoiceButtonTag = 1001;
const NSInteger kmEmojiButtonTag = 1002;
const NSInteger kmMoreSelectButtonTag = 1003;


@interface JSQMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerViewB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewBWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
//    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
	self.inputToolState = kmInputToolBarContentViewStateNone;
	
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc
{
    _textView = nil;
	_leftBarButtonItem = nil;
    _rightBarButtonItem = nil;
    _leftBarButtonContainerView = nil;
    _rightBarButtonContainerView = nil;
	_rightBarButtonContainerViewB = nil;
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
	self.rightBarButtonContainerViewB.backgroundColor = backgroundColor;
}

///*////////////////
- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }

    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }

    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);

    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView jsq_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];

    _leftBarButtonItem = leftBarButtonItem;
	_leftBarButtonItem.tag = kmVoiceButtonTag;
}
////////*/////////

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }

    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
//        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }

    self.rightBarButtonContainerView.hidden = NO;
//    self.rightHorizontalSpacingConstraint.constant = 5;
	
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);

    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem];
	
    [self setNeedsUpdateConstraints];

    _rightBarButtonItem = rightBarButtonItem;
	_rightBarButtonItem.tag = kmEmojiButtonTag;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightContentPadding:(CGFloat)rightContentPadding
{
//    self.rightHorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItemB:(UIButton *)rightBarButtonItemB {
	if (_rightBarButtonItem) {
		[_rightBarButtonItemB removeFromSuperview];
	}
	if (!rightBarButtonItemB) {
		_rightBarButtonItemB = nil;
//		self.rightHorizontalSpacingConstraintB.constant = 0.0f;
		self.rightBarButtonItemBWidth = 0.0f;
		self.rightBarButtonContainerViewB.hidden = YES;
		return;
	}
	if (CGRectEqualToRect(rightBarButtonItemB.frame, CGRectZero)) {
		rightBarButtonItemB.frame = self.rightBarButtonContainerViewB.bounds;
	}
	self.rightBarButtonContainerViewB.hidden = NO;
//	self.rightHorizontalSpacingConstraintB.constant = 5;
	
	self.rightBarButtonItemBWidth = CGRectGetWidth(rightBarButtonItemB.frame);
	
	[rightBarButtonItemB setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	[self.rightBarButtonContainerViewB addSubview:rightBarButtonItemB];
	[self.rightBarButtonContainerViewB jsq_pinAllEdgesOfSubview:rightBarButtonItemB];
		
	[self setNeedsUpdateConstraints];
	
	_rightBarButtonItemB = rightBarButtonItemB;
	_rightBarButtonItemB.tag = kmMoreSelectButtonTag;
}

- (void)setLeftContentPadding:(CGFloat)leftContentPadding
{
    self.leftHorizontalSpacingConstraint.constant = leftContentPadding;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)leftContentPadding
{
    return self.leftHorizontalSpacingConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

- (kmInputToolBarContentViewState)toggleKeyboard:(UIButton*)button {
	NSInteger ttag = (nil == button)? 0 : button.tag;
	
	BOOL selected = (nil == button)?NO : button.selected;
	_leftBarButtonItem.selected = NO;
	_rightBarButtonItem.selected = NO;
	_rightBarButtonItemB.selected = NO;
	kmInputToolBarContentViewState res = (nil == button)?kmInputToolBarContentViewStateText:kmInputToolBarContentViewStateNone;
	
	switch (ttag) {
		case kmVoiceButtonTag: {
			if (!selected) {
				res = kmInputToolBarContentViewStateVoice;
			}
			else {
				res = kmInputToolBarContentViewStateText;
			}
			_leftBarButtonItem.selected = !selected;
			
		} break;
		case kmEmojiButtonTag: {
			if (!selected) {
				res = kmInputToolBarContentViewStateEmoji;
			}
			else {
				res = kmInputToolBarContentViewStateText;
			}
			_rightBarButtonItem.selected = !selected;
		} break;
		case kmMoreSelectButtonTag: {
			if (!selected) {
				res = kmInputToolBarContentViewStateMore;
			}
			else {
				res = kmInputToolBarContentViewStateText;
			}
			_rightBarButtonItemB.selected = !selected;
		} break;
		default:
			break;
	}
	_inputToolState = res;
	return res;
}


@end
