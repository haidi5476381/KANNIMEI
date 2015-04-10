//
//  HorizontalScrollCell.m
//  MoviePicker
//
//  Created by Muratcan Celayir on 28.01.2015.
//  Copyright (c) 2015 Muratcan Celayir. All rights reserved.
//

#import "HorizontalScrollCell.h"
#import "UIImageView+AFNetworking.h"
#import "SessisterListObject.h"
#import "CustomUIImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HorizontalScrollCell
@synthesize sessionListObject;

- (void)awakeFromNib {
    // Initialization code
 
}

-(void)setUpCellWithArray:(NSMutableArray *)array
{
    CGFloat xbase = 10;
    CGFloat width = 100;
    
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    
    for(int i = 0; i < [array count]; i++)
    {
        SessisterValueObject *valueObject = [array objectAtIndex:i];
        CustomUIImageView *custom = [self createCustomViewWithImage:valueObject];
        [self.scroll addSubview:custom];
        [custom setFrame:CGRectMake(xbase, 10, width, 100)];
        xbase += 10 + width;
        
        
    }
    
    NSLog(@"size height = %f",self.scroll.frame.size.height);
    [self.scroll setContentSize:CGSizeMake(xbase, self.scroll.frame.size.height)];
    
    self.scroll.delegate = self;
}

-(CustomUIImageView *)createCustomViewWithImage:(SessisterValueObject *)aValueObject
{
  
    CustomUIImageView *imageView = [[CustomUIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.layer.cornerRadius = 8;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    imageView.object = aValueObject;
    [imageView setImageWithURL:[NSURL URLWithString:aValueObject.itemIcon]];
    

    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [imageView addGestureRecognizer:singleFingerTap];
    
    return imageView;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    [self containingScrollViewDidEndDragging:scrollView];
    
}

- (void)containingScrollViewDidEndDragging:(UIScrollView *)containingScrollView
{
    CGFloat minOffsetToTriggerRefresh = 25.0f;
    
    NSLog(@"%.2f",containingScrollView.contentOffset.x);
    
    NSLog(@"%.2f",self.scroll.contentSize.width);
    
    if (containingScrollView.contentOffset.x <= -50)
    {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-50 , 7, 100, 150)];
        
        UIActivityIndicatorView *acc = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        acc.hidesWhenStopped = YES;
        [view addSubview:acc];
        
        [acc setFrame:CGRectMake(view.center.x - 25, view.center.y - 25, 50, 50)];
        
        [view setBackgroundColor:[UIColor clearColor]];
        
        [self.scroll addSubview:view];
        
        [acc startAnimating];
        
        [UIView animateWithDuration: 0.3
         
                              delay: 0.0
         
                            options: UIViewAnimationOptionCurveEaseOut
         
                         animations:^{
                             
                             [containingScrollView setContentInset:UIEdgeInsetsMake(0, 100, 0, 0)];
                             
                         }
                         completion:nil];
        //[containingScrollView setContentInset:UIEdgeInsetsMake(0, 100, 0, 0)];
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"Started");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //Do whatever you want.
                
                NSLog(@"Refreshing");
                
               [NSThread sleepForTimeInterval:3.0];
                
                NSLog(@"refresh end");
                
                [UIView animateWithDuration: 0.3
                
                                      delay: 0.0
                
                                    options: UIViewAnimationOptionCurveEaseIn
                
                                 animations:^{
                
                                     [containingScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                
                                 }
                                                completion:nil];
            });
            
        });
        
    }
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"clicked");
    
    CustomUIImageView *selectedView = (CustomUIImageView *)recognizer.view;
    
    if([_cellDelegate respondsToSelector:@selector(cellSelected:andListObject:)])
        [_cellDelegate cellSelected:selectedView.object andListObject:self.sessionListObject];
    
    //Do stuff here...
}

@end
