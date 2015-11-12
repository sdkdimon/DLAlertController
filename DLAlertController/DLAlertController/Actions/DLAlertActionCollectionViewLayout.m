//
// DLAlertActionCollectionViewLayout.m
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

#import "DLAlertActionCollectionViewLayout.h"

@interface DLAlertActionCollectionViewLayout ()

@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *,UICollectionViewLayoutAttributes *> *layoutInfo;
@end

@implementation DLAlertActionCollectionViewLayout

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

-(void)setup{
    _itemLayout = DLAlertActionItemLayoutVertical;
    _interItemSpacing = 2.0f;
    _itemHeight = 50.0f;
    _layoutInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
}



-(void)prepareLayout{
    [self prepareLayoutForActionItemLayout:_itemLayout];
}

-(void)prepareLayoutForActionItemLayout:(DLAlertActionItemLayout)itemLayout{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    if(itemCount == 0) return;
    [_layoutInfo removeAllObjects];

    CGSize collectionViewSize = [[self collectionView] bounds].size;
    
    switch (itemLayout) {
        case DLAlertActionItemLayoutHorizontal:{
            CGFloat totalSpacingWidth = _interItemSpacing * (itemCount - 1);
            CGFloat width = (collectionViewSize.width - totalSpacingWidth)/itemCount;
            CGRect itemFrame = CGRectMake(0, 0, width, collectionViewSize.height);
            for (NSInteger item = 0; item < itemCount; item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
                UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                [itemAttributes setFrame:itemFrame];
                itemFrame.origin.x = itemFrame.origin.x + itemFrame.size.width + _interItemSpacing;
                [_layoutInfo setObject:itemAttributes forKey:indexPath];
            }
            break;
        }
            
            
        case DLAlertActionItemLayoutVertical:{
            CGRect itemFrame = CGRectMake(0, 0, collectionViewSize.width, _itemHeight);
            for (NSInteger item = 0; item < itemCount; item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
                UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                [itemAttributes setFrame:itemFrame];
                itemFrame.origin.y = itemFrame.origin.y + itemFrame.size.height + _interItemSpacing;
                [_layoutInfo setObject:itemAttributes forKey:indexPath];
            }
            break;
        }
            
    }
    
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
   return [_layoutInfo allValues];
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutInfo[indexPath];
}

-(CGSize)collectionViewContentSize{
    return [self collectionViewContentSizeForActionItemLayout:_itemLayout];
}

-(CGSize)collectionViewContentSizeForActionItemLayout:(DLAlertActionItemLayout)itemLayout{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    CGSize collectionViewSize = [[self collectionView] bounds].size;
    
    switch (itemLayout) {
        case DLAlertActionItemLayoutHorizontal:{
            return CGSizeMake(collectionViewSize.width, _itemHeight);
        }
            
        case DLAlertActionItemLayoutVertical:{
            CGFloat height = itemCount * _itemHeight + ((itemCount-1)%(itemCount+1))*_interItemSpacing;
            return  CGSizeMake(collectionViewSize.width,height);
           
        }
            
    }
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end
