//
//  PageControlView.h
//  PageControllerDemo
//
//  Created by Dipen Majithiya on 14/08/13.
//  Copyright (c) 2013 iMobDev. All rights reserved.
//

#import <UIKit/UIKit.h>

enum PageControlTags
{
    ScrollViewTag = 1000,
    PagingViewTag
};

@interface PageControlView : UIView <UIScrollViewDelegate>
{
    //Array
    NSMutableArray *_arrOfImages;
    
    //AnimateFlag
    BOOL animate;
    
    //Timer Object
    NSTimer *timer;
    
    //Index Integer
//    NSInteger currentIndex;
    
    //ImageName
    NSString *_dotImageName;
    
    //Variables
    CGFloat DotSize;
    CGFloat GapSize;
}
// change by haidi 6.20
@property (nonatomic,strong) UIScrollView* scrPagesTemp;
@property (nonatomic,assign) NSInteger  currentIndex;
-(void)setImageScreenAtIndex:(NSInteger)index;


//end
-(void)showArrayOfImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate;
-(void)showArrayOfImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate WithFrame:(CGRect)imgFrame WithNormalImageName:(NSString *)_strImgName WithDotSize:(CGFloat)_dot;
-(void)showArrayOfImagesGallery:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate;
-(void)showPostCardImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate;//postCard
-(void)showArrayOfImagesWithUrl:(NSArray *)_arrImages withAnimation:(BOOL)_animate;
-(void)stopPaging;
-(void)startPaging;
@end
