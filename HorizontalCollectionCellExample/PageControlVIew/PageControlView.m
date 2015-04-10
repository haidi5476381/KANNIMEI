//
//  PageControlView.m
//  PageControllerDemo
//
//  Created by Dipen Majithiya on 14/08/13.
//  Copyright (c) 2013 iMobDev. All rights reserved.
//

#import "PageControlView.h"
#import "UIImageView+AFNetworking.h"
//  iphone check
//  iphone check
#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

//Iphone checking

#define ISIPHONE_5 [UIScreen mainScreen].bounds.size.height == 568
#define ISIPHONE_6 [UIScreen mainScreen].bounds.size.height == 667
#define IPhone6Plus [UIScreen mainScreen].bounds.size.height == 736
#define ISIPHONE_4 [UIScreen mainScreen].bounds.size.height == 480
#import "UIImageView+AFNetworking.h"

static const CGFloat dotHeight  = 10;
@implementation PageControlView
@synthesize scrPagesTemp  = _scrPagesTemp;
@synthesize currentIndex;
#pragma mark
#pragma mark Init Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        
        //Create ScrollView
       UIScrollView* _scrPages = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

        _scrPagesTemp = _scrPages; // add by haidi 6.10
        [self addSubview:_scrPages];
        [_scrPages setBackgroundColor:[UIColor whiteColor]];
        [_scrPages setTag:ScrollViewTag];
        [_scrPages setPagingEnabled:YES];
        [_scrPages setScrollEnabled:YES];
        [_scrPages setShowsHorizontalScrollIndicator:NO];
        [_scrPages setShowsVerticalScrollIndicator:NO];
        [_scrPages setDelegate:self];
        [_scrPages setUserInteractionEnabled:YES];
        
        CGFloat viewHeight ;
        
        if (IS_IPHONE)
        {
            if ([UIScreen mainScreen].bounds.size.height == 568.0)
            {
                viewHeight = 90.0;
            }
            else
            {
                viewHeight = 60.0;
            }

        }
        else
        {
            viewHeight = 140.0;
        }
        
                
        //View for Paging Control
        UIView *_viewPaging = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height - viewHeight, self.frame.size.width, viewHeight)];
        [_viewPaging setBackgroundColor:[UIColor clearColor]];
        [_viewPaging setTag:PagingViewTag];
        [self addSubview:_viewPaging];
        [_viewPaging setUserInteractionEnabled:YES];
        
        _dotImageName = @"white";
        
        //Set Default Index
        currentIndex = 0;
        
        if (IS_IPHONE)
        {
            DotSize = 8.0;
            GapSize = 10.0;
        }
        else
        {
            DotSize = 12.0;
            GapSize = 13.0;
        }
    }
    
    return self;
}

#pragma mark
#pragma mark - Global Methods

-(void)showArrayOfImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate
{
    //Set Array Of Images
    _arrOfImages = _arrImages;
    
    //Animate
    animate = _animate;
        
    //Get ScrollView
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    // change by haidi
    /* ===== 3.25 修改在图片没有白边   ====  */
    _scrPages.pagingEnabled = YES;
    _scrPages.bounces = NO;
    
    // end
    //Set Content Size of ScrollView
    [_scrPages setContentSize:CGSizeMake(_scrPages.frame.size.width * [_arrImages count], _scrPages.frame.size.height)];
    
    //Chganges done according to feedback Dot Removes
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    CGFloat fixX = ((self.frame.size.width - ((DotSize * [_arrImages count]) + (GapSize * ([_arrImages count] - 1)))) / 2.0);
    
    //Set Images For ScrollView
    for (int i = 0; i < [_arrImages count]; i++)
    {
        //Add ImageView
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _scrPages.frame.size.width, 0, _scrPages.frame.size.width, _scrPages.frame.size.height)];
           [_imgView setImage:[_arrImages objectAtIndex:i]];
        [_scrPages addSubview:_imgView];
        
        //Add Paging Dot
        UIImageView *_imgViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(fixX + (i * (DotSize + GapSize)), _viewPaging.frame.size.height - DotSize - dotHeight , DotSize, DotSize)];
        [_imgViewDot setTag:(i+1)];
        [_imgViewDot setImage:[UIImage imageNamed:@"white"]];
        [_viewPaging addSubview:_imgViewDot];
    }
    
    //For Animation
    if (_animate)
    {
        [self startTimer];
    }
    
    //Default Image View
    [self setImageScreenAtIndex:1];
}


-(void)showArrayOfImagesWithUrl:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate
{
    //Set Array Of Images
    _arrOfImages = _arrImages;
    
    //Animate
    animate = _animate;
    
    //Get ScrollView
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    // change by haidi
    /* ===== 3.25 修改在图片没有白边   ====  */
    _scrPages.pagingEnabled = YES;
    _scrPages.bounces = NO;
    
    // end
    //Set Content Size of ScrollView
    [_scrPages setContentSize:CGSizeMake(_scrPages.frame.size.width * [_arrImages count], _scrPages.frame.size.height)];
    
    //Chganges done according to feedback Dot Removes
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    CGFloat fixX = ((self.frame.size.width - ((DotSize * [_arrImages count]) + (GapSize * ([_arrImages count] - 1)))) / 2.0);
    
    //Set Images For ScrollView
    for (int i = 0; i < [_arrImages count]; i++)
    {
        //Add ImageView
        
        UIScrollView*  s = [[UIScrollView alloc] initWithFrame:CGRectMake(i * _scrPages.frame.size.width, 0, _scrPages.frame.size.width, _scrPages.frame.size.height)];
        s.backgroundColor =[UIColor clearColor];
        s.contentSize =  CGSizeMake(_scrPages.frame.size.width, _scrPages.frame.size.height);
        s.showsHorizontalScrollIndicator = NO;
        s.showsVerticalScrollIndicator = NO;
        s.clipsToBounds = YES;
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
        s.tag = i+1;
        [s setZoomScale:1.0];
        
     
        
        
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:s.bounds];
        [_imgView setContentMode:UIViewContentModeScaleAspectFit];
        [_imgView setImageWithURL:[NSURL URLWithString:[_arrImages objectAtIndex:i]]];
        
        _imgView.tag = (i+1);
        [s addSubview:_imgView];
        
           [_scrPagesTemp addSubview:s];
        //Add Paging Dot
        UIImageView *_imgViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(fixX + (i * (DotSize + GapSize)), _viewPaging.frame.size.height - DotSize - dotHeight , DotSize, DotSize)];
        [_imgViewDot setTag:(i+1)];
        [_imgViewDot setImage:[UIImage imageNamed:@"white"]];
        [_viewPaging addSubview:_imgViewDot];
    }
    
    //For Animation
    if (_animate)
    {
        [self startTimer];
    }
    
    //Default Image View
    [self setImageScreenAtIndex:1];
}




-(void)showArrayOfImagesGallery:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate
{
    //Set Array Of Images
    _arrOfImages = _arrImages;
    
    //Animate
    animate = _animate;
    
    //Get ScrollView
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    // change by haidi
    /* ===== 3.25 修改在图片没有白边   ====  */
    _scrPages.pagingEnabled = YES;
    _scrPages.bounces = NO;
    
    // end
    //Set Content Size of ScrollView
    [_scrPages setContentSize:CGSizeMake(_scrPages.frame.size.width * [_arrImages count], _scrPages.frame.size.height)];
    
    //Chganges done according to feedback Dot Removes
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    CGFloat fixX = ((self.frame.size.width - ((DotSize * [_arrImages count]) + (GapSize * ([_arrImages count] - 1)))) / 2.0);
    
    //Set Images For ScrollView
    for (int i = 0; i < [_arrImages count]; i++)
    {
        //Add ImageView
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _scrPages.frame.size.width, 0, _scrPages.frame.size.width, _scrPages.frame.size.height)];
        
        // add by Lance 12.26//
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_imgView setImageWithURL:[NSURL URLWithString:[_arrImages objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"loading"]];
        [_scrPages addSubview:_imgView];
        
        
        //Add Paging Dot
        UIImageView *_imgViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(fixX + (i * (DotSize + GapSize)), _viewPaging.frame.size.height - DotSize - dotHeight , DotSize, DotSize)];
        [_imgViewDot setTag:(i+1)];
        [_imgViewDot setImage:[UIImage imageNamed:@"white"]];
        [_viewPaging addSubview:_imgViewDot];
    }
    
    //For Animation
    if (_animate)
    {
        [self startTimer];
    }
    
    //Default Image View
    [self setImageScreenAtIndex:1];
}

-(void)showPostCardImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate
{
    //Set Array Of Images
    _arrOfImages = _arrImages;
    
    //Animate
    animate = _animate;
    
    //Get ScrollView
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    // change by haidi
    /* ===== 3.25 修改在图片没有白边   ====  */
    _scrPages.pagingEnabled = YES;
    _scrPages.bounces = NO;
    
    // end
    //Set Content Size of ScrollView
    [_scrPages setContentSize:CGSizeMake(_scrPages.frame.size.width * [_arrImages count], _scrPages.frame.size.height)];
    
    //Chganges done according to feedback Dot Removes
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    CGFloat fixX = ((self.frame.size.width - ((DotSize * [_arrImages count]) + (GapSize * ([_arrImages count] - 1)))) / 2.0);
    
    //Set Images For ScrollView
    for (int i = 0; i < [_arrImages count]; i++)
    {
        //Add ImageView
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _scrPages.frame.size.width, 0, _scrPages.frame.size.width, _scrPages.frame.size.height)];
        [_imgView setImageWithURL:[NSURL URLWithString:[_arrImages objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"loading"]];
        [_scrPages addSubview:_imgView];
        
        //Add Paging Dot
        UIImageView *_imgViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(fixX + (i * (DotSize + GapSize)), _viewPaging.frame.size.height - DotSize - dotHeight , DotSize, DotSize)];
        [_imgViewDot setTag:(i+1)];
        [_imgViewDot setImage:[UIImage imageNamed:@"white"]];
        [_viewPaging addSubview:_imgViewDot];
    }
    
    //For Animation
    if (_animate)
    {
        [self startTimer];
    }
    
    //Default Image View
    [self setImageScreenAtIndex:1];

}

-(void)showArrayOfImages:(NSMutableArray *)_arrImages withAnimation:(BOOL)_animate WithFrame:(CGRect)imgFrame WithNormalImageName:(NSString *)_strImgName WithDotSize:(CGFloat)_dot
{
    //Set Array Of Images
    _arrOfImages = _arrImages;
    
    _dotImageName = _strImgName;
    
    //Animate
    animate = _animate;
    
    //Get ScrollView
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    
    // change by haidi
    /* ===   */
    _scrPages.bounces = NO;
    _scrPages.pagingEnabled = YES;
    //end
    //Set Content Size of ScrollView
    [_scrPages setContentSize:CGSizeMake(_scrPages.frame.size.width * [_arrImages count], _scrPages.frame.size.height)];
    
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    CGFloat fixX = ((self.frame.size.width - ((_dot * [_arrImages count]) + (GapSize * ([_arrImages count] - 1)))) / 2.0);
    
    //Set Images For ScrollView
    for (int i = 0; i < [_arrImages count]; i++)
    {
        //Add ImageView
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake((i * _scrPages.frame.size.width) + imgFrame.origin.x, imgFrame.origin.y, imgFrame.size.width, imgFrame.size.height)];
        [_imgView setImage:[_arrImages objectAtIndex:i]];
        [_scrPages addSubview:_imgView];
        
        float yOrigin;
        
        if (IS_IPHONE)
        {
            if (ISIPHONE_5)
            {
                yOrigin = 70.0;
            }
            else
            {
                yOrigin = 40.0;
            }
       
        }
        else
        {
            yOrigin = 110.0;
        }
        
                
        //Add Paging Dot
        UIImageView *_imgViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(fixX + (i * (_dot + GapSize)), yOrigin , _dot, _dot)];
        [_imgViewDot setTag:(i+1)];
        [_imgViewDot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_dotImageName]]];
        [_viewPaging addSubview:_imgViewDot];

    }
    
    //For Animation
    if (_animate)
    {
        [self startTimer];
    }
    
    //Default Image View
    [self setImageScreenAtIndex:1];
}

#pragma mark
#pragma mark Supporting Metods

-(void)imageChange:(NSTimer *)timer
{
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    
    NSInteger index = _scrPages.contentOffset.x/_scrPages.frame.size.width;
    
    CGPoint offset = _scrPages.contentOffset;
    
    if (offset.x == (_scrPages.contentSize.width - _scrPages.frame.size.width))
    {
        offset.x = 0.0;
        [_scrPages setContentOffset:offset animated:NO];
    }
    else
    {
        offset.x += _scrPages.frame.size.width;
        [_scrPages setContentOffset:offset animated:YES];
    }
    
    //To Setup Dot Position of Page Control
    if (index >= ([_arrOfImages count]-1))
    {
        [self setImageScreenAtIndex:1];
    }
    else
    {
        [self setImageScreenAtIndex:(index + 2)];
    }
}

#pragma mark
#pragma mark - ImageView Dot

-(void)setImageScreenAtIndex:(NSInteger)index
{
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    if (currentIndex > 0)
    {
        UIImageView *_imgViewPrev = (UIImageView *)[_viewPaging viewWithTag:currentIndex];
        [_imgViewPrev setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_dotImageName]]];
    }
    
    UIImageView *_imgViewNext = (UIImageView *)[_viewPaging viewWithTag:index];
    [_imgViewNext setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",_dotImageName]]];
    
    currentIndex = index;
    

}

#pragma mark
#pragma mark - SCrollView Delegate Methods

//Edited On 19/08/2013===================
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{    
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    
    
    [self setImageScreenAtIndex:(index + 1)];
    [self startPaging];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    /*if (animate)
    {
        [timer invalidate];
        timer = nil;
        [self performSelector:@selector(startTimer) withObject:nil afterDelay:0.2];
    }*/
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    if (animate)
//    {
//        [timer invalidate];
//        timer = nil;
//        //[self startTimer]; 
//    }
    [self stopPaging];
}
//Edited On 19/08/2013===================

#pragma mark
#pragma mark Touches Event Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (animate)
    {
        //Edited On 19/08/2013===================
        //[timer invalidate];
        //[self performSelector:@selector(startTimer) withObject:nil afterDelay:0.2];
        
        [timer invalidate];
        timer = nil;
        [self startTimer];
    }
    
    //Get Current Offset Index
    UIScrollView *_scrPages = (UIScrollView *)[self viewWithTag:ScrollViewTag];
    
    CGPoint offset = _scrPages.contentOffset;
    
    NSInteger index = offset.x/_scrPages.frame.size.width;
    
    //Get View
    UIView *_viewPaging = [self viewWithTag:PagingViewTag];
    
    //Get Touch Object
    UITouch *_touch = [touches anyObject];
    
    //Get Touch Point
    CGPoint _pointTouch = [_touch locationInView:_viewPaging];
    
    if (_pointTouch.x > (_viewPaging.frame.size.width / 2.0))
    {
        //If Point is at Right Side
        
        if (index != ([_arrOfImages count] - 1))
        {
            [_scrPages setContentOffset:CGPointMake(((index + 1) * _scrPages.frame.size.width), offset.y) animated:YES];
            [self setImageScreenAtIndex:(index + 2)];
        }
        if (index == [_arrOfImages count] - 1) {
            [_scrPages setContentOffset:CGPointMake(0, 0) animated:YES];
            [self setImageScreenAtIndex:1];
        }
    }
    else
    {
        //If Point is At Left Side or Equal to
        if (index != 0)
        {
            [_scrPages setContentOffset:CGPointMake(((index - 1) * _scrPages.frame.size.width), offset.y) animated:YES];
            [self setImageScreenAtIndex:(index)];
        }
    }
    
    
}

#pragma mark
#pragma mark Start Timer

-(void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(imageChange:) userInfo:_arrOfImages repeats:YES];
}

#pragma mark
#pragma mark - Start & Stop Paging

-(void)stopPaging
{
    if (animate)
    {
        if (timer != nil)
        {
            if(timer.isValid)
            {
                [timer invalidate];
                timer = nil;
            }
        }
    }
}

-(void)startPaging
{
    if (animate)
    {
        if (timer == nil)
        {
            [self startTimer];
        }
    }
}



#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}


- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    
    NSLog(@"imageScrollView Bounds Width = %f , imageScrollView.contentSize.widht = %f",aScrollView.bounds.size.width,aScrollView.contentSize.width);

    CGFloat offsetX = (aScrollView.bounds.size.width > aScrollView.contentSize.width)?
    (aScrollView.bounds.size.width - aScrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (aScrollView.bounds.size.height > aScrollView.contentSize.height)?
    (aScrollView.bounds.size.height - aScrollView.contentSize.height) * 0.5 : 0.0;
    UIImageView* aImageView = [aScrollView.subviews  objectAtIndex:0];
    aImageView.center = CGPointMake(aScrollView.contentSize.width * 0.5 + offsetX,
                                   aScrollView.contentSize.height * 0.5 + offsetY);
}





@end
