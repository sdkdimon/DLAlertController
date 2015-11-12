//
// DLAlertActionStyle.m
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

#import "DLAlertActionVisualStyle.h"

@interface DLAlertActionVisualStyleItem : NSObject <NSCopying>

@property(strong,nonatomic,readwrite) UIColor *backgroundColor;
@property(strong,nonatomic,readwrite) UIColor *textColor;

@end

@implementation DLAlertActionVisualStyleItem

-(id)copyWithZone:(NSZone *)zone{
    DLAlertActionVisualStyleItem *copy = [[DLAlertActionVisualStyleItem alloc] init];
    [copy setBackgroundColor:[_backgroundColor copy]];
    [copy setTextColor:[_textColor copy]];
    return copy;
}

@end

@interface DLAlertActionVisualStyle ()

@property(strong,nonatomic,readwrite)  NSDictionary<NSNumber *,DLAlertActionVisualStyleItem *> *styleItems;

@end


@implementation DLAlertActionVisualStyle

-(void)setBackgroundColor:(UIColor *)color forActionState:(DLAlertActionState)state{
    [_styleItems[@(state)] setBackgroundColor:color];
}

-(UIColor *)backgroundColorForActionState:(DLAlertActionState)state{
    
    return [_styleItems[@(state)] backgroundColor];
}

-(void)setTextColor:(UIColor *)color forActionState:(DLAlertActionState)state{
    [_styleItems[@(state)] setTextColor:color];
}

-(UIColor *)textColorForActionState:(DLAlertActionState)state{
    return [_styleItems[@(state)] textColor];
}


@end


@implementation DLAlertActionVisualStyle (Factory)

+(instancetype)defaultStyle{
    
    UIColor *backgroundMainColor = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];
    UIColor *textMainColor = [UIColor colorWithRed:68.0f/255.0f green:69.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
    
    DLAlertActionVisualStyle *defaultStyle = [[DLAlertActionVisualStyle alloc] init];
    [defaultStyle setFont:[UIFont systemFontOfSize:17.0f]];
    
    DLAlertActionVisualStyleItem *normalStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
    [normalStyleItem setBackgroundColor:backgroundMainColor];
    [normalStyleItem setTextColor:textMainColor];
    
    DLAlertActionVisualStyleItem *highlightedStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
    [highlightedStyleItem setBackgroundColor:[backgroundMainColor colorWithAlphaComponent:.5]];
    [highlightedStyleItem setTextColor:[textMainColor colorWithAlphaComponent:.5]];
    
    DLAlertActionVisualStyleItem *disabledStyleItem = [highlightedStyleItem copy];
    
    [defaultStyle setStyleItems:@{@(DLAlertActionStateNormal) : normalStyleItem,
                                 @(DLAlertActionStateHighlighted) : highlightedStyleItem,
                                 @(DLAlertActionStateDisabled) : disabledStyleItem}];

    return defaultStyle;
}

+(instancetype)cancelStyle{
    return [self defaultStyle];
}

+(instancetype)destructiveStyle{
    
    UIColor *backgroundMainColor = [UIColor colorWithRed:254.0f/255.0f green:67.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    UIColor *textMainColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    
    DLAlertActionVisualStyle *destructiveStyle = [[DLAlertActionVisualStyle alloc] init];
    [destructiveStyle setFont:[UIFont systemFontOfSize:17.0f]];
    
    DLAlertActionVisualStyleItem *normalStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
    [normalStyleItem setBackgroundColor:backgroundMainColor];
    [normalStyleItem setTextColor:textMainColor];
    
    DLAlertActionVisualStyleItem *highlightedStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
    [highlightedStyleItem setBackgroundColor:[backgroundMainColor colorWithAlphaComponent:.5]];
    [highlightedStyleItem setTextColor:[textMainColor colorWithAlphaComponent:.5]];
    
    DLAlertActionVisualStyleItem *disabledStyleItem = [highlightedStyleItem copy];
    
    [destructiveStyle setStyleItems:@{@(DLAlertActionStateNormal) : normalStyleItem,
                                  @(DLAlertActionStateHighlighted) : highlightedStyleItem,
                                  @(DLAlertActionStateDisabled) : disabledStyleItem}];
    
    return destructiveStyle;
}





@end



