//
//  HorizontalScrollCell.h
//  MoviePicker
//
//  Created by Muratcan Celayir on 28.01.2015.
//  Copyright (c) 2015 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScrollCellAction;
@class SessisterValueObject;
@class SessisterListObject;

@protocol HorizontalScrollCellDelegate <NSObject>
-(void)cellSelected:(SessisterValueObject*) valueObject  andListObject:(SessisterListObject*) aListObject;
@end

@interface HorizontalScrollCell : UICollectionViewCell <UIScrollViewDelegate>
{
    CGFloat supW;
    CGFloat off;
    CGFloat diff;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic,strong) SessisterListObject* sessionListObject;
@property (strong, nonatomic) IBOutlet UILabel *title;
-(void)setUpCellWithArray:(NSArray *)array;

@property (nonatomic,strong) id<HorizontalScrollCellDelegate> cellDelegate;

@end
