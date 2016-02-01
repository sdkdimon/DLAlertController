//
// DLAlertViewTest.m
// Copyright (c) 2015 Dmitry Lizin (sdkdimon@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DLAlertView.h"

@interface DLAlertView ()

@property(strong,nonatomic,readwrite) UIView *contentView;
@property(strong,nonatomic,readwrite) NSLayoutConstraint *widthConstraint;
@property(strong,nonatomic,readwrite) NSLayoutConstraint *heightConstraint;

@property(strong,nonatomic,readwrite) NSDictionary <NSNumber *, NSLayoutConstraint *> *contentViewConstraints;

@end


@implementation DLAlertView

#pragma mark Initializers

-(instancetype)init{
    self = [super init];
    if(self != nil) {
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self != nil){
        [self setup];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        [self setup];
    }
    return self;
}

#pragma mark Setup and initialize subviews

-(void)setup{
    _contentViewInsets = UIEdgeInsetsZero;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self createUI];
    [self setupLayoutConstraints];
}

-(void)createUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_scrollView];
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollView addSubview:_contentView];
    _actionContentView = [[UIView alloc] initWithFrame:CGRectZero];
    [_actionContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_actionContentView];
}

#pragma mark Setup layout constraint

-(void)setupLayoutConstraints{
    [self setupSelfLayoutConstraints];
    [self setupScrollViewConstraints];
    [self setupContentViewConstraints];
    [self setupActionContentViewConstraints];
}


-(void)prepareLayout{
    [self setupLayoutConstraints];
}

#pragma mark Self constraints

-(void)setupSelfLayoutConstraints{
    _widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0f
                                                     constant:0.0f];
    [_widthConstraint setPriority:UILayoutPriorityDefaultLow];
    
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:0.0f];
    
    [_heightConstraint setPriority:UILayoutPriorityDefaultLow];
    [self addConstraints:@[_widthConstraint,_heightConstraint]];
}

#pragma mark ScrollView constraints

-(void)setupScrollViewConstraints{
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_scrollView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.0f];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:_scrollView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.0f];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:_scrollView
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:0.0f];
    
    NSLayoutConstraint *bottom =    [NSLayoutConstraint
                                     constraintWithItem:_scrollView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:self
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                     constant:0.0f];
    [self addConstraints:@[leading,
                           top,
                           trailing,
                           bottom]];
    
    _contentViewConstraints = @{@(NSLayoutAttributeLeading) : leading,
                                @(NSLayoutAttributeTop) : top,
                                @(NSLayoutAttributeTrailing) : trailing,
                                @(NSLayoutAttributeBottom) : bottom};
    
}


#pragma mark ContentView constraints

-(void)setupContentViewConstraints{
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_contentView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_scrollView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:_contentViewInsets.left];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                                   constraintWithItem:_contentView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_scrollView
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0f
                                   constant:_contentViewInsets.top];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                   constraintWithItem:_contentView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_scrollView
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:_contentViewInsets.right];
    
    NSLayoutConstraint *bottom =   [NSLayoutConstraint
                                   constraintWithItem:_contentView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_scrollView
                                   attribute:NSLayoutAttributeBottom
                                   multiplier:1.0f
                                   constant:_contentViewInsets.bottom];
    
    NSLayoutConstraint *equalHeight = [NSLayoutConstraint
                                        constraintWithItem:_contentView
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:_scrollView
                                        attribute:NSLayoutAttributeHeight
                                        multiplier:1.0f
                                        constant:0.0f];
    [equalHeight setPriority:UILayoutPriorityDefaultHigh];
    
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint
                                       constraintWithItem:_contentView
                                       attribute:NSLayoutAttributeWidth
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_scrollView
                                       attribute:NSLayoutAttributeWidth
                                       multiplier:1.0f
                                       constant:0.0f];
    
    
    [_scrollView addConstraints:@[leading,
                                  top,
                                  trailing,
                                  bottom,
                                  equalHeight,
                                  equalWidth]];
    
}


-(void)setupActionContentViewConstraints{
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_actionContentView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.0f];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:_actionContentView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:_scrollView
                               attribute:NSLayoutAttributeBottom
                               multiplier:1.0f
                               constant:0.0f];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:_actionContentView
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:0.0f];
    
    NSLayoutConstraint *bottom =   [NSLayoutConstraint
                                    constraintWithItem:_actionContentView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1.0f
                                    constant:0.0f];
    [self addConstraints:@[leading,trailing,top,bottom]];
}

#pragma mark Update ContentView insets and constraints

//-(void)setContentViewInsets:(UIEdgeInsets)contentViewInsets{
//    _contentViewInsets = contentViewInsets;
//    
//    NSLayoutConstraint *leading = [_contentViewConstraints objectForKey:@(NSLayoutAttributeLeading)];
//    [leading setConstant:contentViewInsets.left];
//    
//    NSLayoutConstraint *top = [_contentViewConstraints objectForKey:@(NSLayoutAttributeTop)];
//    [top setConstant:contentViewInsets.top];
//    
//    NSLayoutConstraint *trailing = [_contentViewConstraints objectForKey:@(NSLayoutAttributeTrailing)];
//    [trailing setConstant:- contentViewInsets.right];
//    
//    NSLayoutConstraint *bottom = [_contentViewConstraints objectForKey:@(NSLayoutAttributeBottom)];
//    [bottom setConstant:- contentViewInsets.bottom];
//}















































@end
