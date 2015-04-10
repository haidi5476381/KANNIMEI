//
//  ImagesPreviewViewController.m
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-3-30.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "ImagesPreviewViewController.h"
#import "PageControlView.h"
#import "HttpRequestEngine.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ImagesPreviewViewController ()
{
    NSArray* strArray;
}
@end

@implementation ImagesPreviewViewController
@synthesize aValueObject = _aValueObject,aListObject = _aListObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getDetail];
    
    NSLog(@"ttttt");
    
}


-(void) getDetail {
    
    [HttpRequestEngine getIconDetailWithItemName:_aValueObject.itemName categoryName:self.aListObject.sessisterTitle complete:^(BOOL success,NSDictionary* resultDict) {
        
        if (success) {
            
            
            
            self.title = [resultDict objectForKey:@"ItemName"];
            NSString* imageUrl = [resultDict objectForKey:@"ImgUrl"];
            if ([imageUrl hasSuffix:@"mp4"]) {
                MPMoviePlayerController*  mpVc = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:imageUrl]];
                mpVc.view.frame = self.view.bounds;
                mpVc.view.backgroundColor = [UIColor redColor];
                mpVc.movieSourceType = MPMovieSourceTypeStreaming;
                [mpVc setControlStyle:MPMovieControlStyleDefault];
                [mpVc setScalingMode:MPMovieScalingModeAspectFit];
                [mpVc prepareToPlay];
                [self.view addSubview:mpVc.view];
                [mpVc play];
            }else {
                strArray = [imageUrl componentsSeparatedByString:@","];
                PageControlView* pageContrlView = [[PageControlView alloc] initWithFrame:CGRectMake(0, 44, 320, 480)];
                [pageContrlView showArrayOfImagesWithUrl:strArray withAnimation:NO];
                [self.view addSubview:pageContrlView];
            }
            
        }
    }];
}


-(void) diss:(UIButton*) sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
