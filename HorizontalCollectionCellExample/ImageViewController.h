//
//  ImageViewController.h
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-3-30.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic)  UICollectionView *collection;
@end
