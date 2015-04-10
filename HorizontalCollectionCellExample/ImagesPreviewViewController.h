//
//  ImagesPreviewViewController.h
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-3-30.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessisterListObject.h"
@interface ImagesPreviewViewController : UIViewController
@property (nonatomic,strong) SessisterValueObject* aValueObject;
@property (nonatomic,strong) SessisterListObject* aListObject;

@end
