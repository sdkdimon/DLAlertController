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

@interface DLAlertActionVisualStyleItem : NSObject

@property(strong,nonatomic,readwrite) UIColor *backgroundColor;
@property(strong,nonatomic,readwrite) UIColor *textColor;

@end

@implementation DLAlertActionVisualStyleItem

@end


@implementation DLAlertActionVisualStyle{
    NSDictionary<NSNumber *,DLAlertActionVisualStyleItem *> *styleItems;
}


-(instancetype)init{
    self = [super init];
    if(self != nil){
        
        _font = [UIFont systemFontOfSize:17.0f];
        
        
        DLAlertActionVisualStyleItem *normalStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
        [normalStyleItem setBackgroundColor:[UIColor lightGrayColor]];
        [normalStyleItem setTextColor:[UIColor whiteColor]];
       
        
        
        DLAlertActionVisualStyleItem *highlightedStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
        [highlightedStyleItem setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.5]];
        [highlightedStyleItem setTextColor:[[UIColor darkTextColor] colorWithAlphaComponent:.5]];
       
        
        DLAlertActionVisualStyleItem *disabledStyleItem = [[DLAlertActionVisualStyleItem alloc] init];
        [disabledStyleItem setBackgroundColor:[UIColor darkGrayColor]];
        [disabledStyleItem setTextColor:[UIColor whiteColor]];
        
        styleItems = @{@(DLAlertActionStateNormal) : normalStyleItem,
                       @(DLAlertActionStateHighlighted) : highlightedStyleItem,
                       @(DLAlertActionStateDisabled) : disabledStyleItem};
    }
    return self;
}


-(void)setBackgroundColor:(UIColor *)color forActionState:(DLAlertActionState)state{
    [styleItems[@(state)] setBackgroundColor:color];
}

-(UIColor *)backgroundColorForActionState:(DLAlertActionState)state{
    
    return [styleItems[@(state)] backgroundColor];
}

-(void)setTextColor:(UIColor *)color forActionState:(DLAlertActionState)state{
    [styleItems[@(state)] setTextColor:color];
}

-(UIColor *)textColorForActionState:(DLAlertActionState)state{
    return [styleItems[@(state)] textColor];
}


@end
