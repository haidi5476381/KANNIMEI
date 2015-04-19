//
//  ImageViewController.m
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-3-30.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "ImageViewController.h"
#import "HorizontalScrollCell.h"
#import "ImagesPreviewViewController.h"
#import "HeaderCollectionReusableView.h"
#import "YourSubclassNameHere.h"
#import "HttpRequestEngine.h"
#import "SessisterListObject.h"
#import "iCarousel.h"

@interface ImageViewController ()<HorizontalScrollCellDelegate,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource>
{
    NSMutableArray*  dataArray;
    NSArray* images;
    iCarousel*  icarousel;
}
@property (nonatomic,strong) NSMutableArray*  imagesArray;
@property (nonatomic, assign) BOOL wrap;
@end

@implementation ImageViewController
@synthesize collection,imagesArray,wrap;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view from its nib.
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    self.collection.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);

    
   
    [self.view addSubview:self.collection];
  
    self.tabBarItem.title = @"图片";

    
    [self prepareImages];
}

-(void)prepareImages
{
    self.imagesArray = [[NSMutableArray alloc]init];
    for(int i = 1; i <5; i++)
    {
       // [self.imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img%i.jpg", i]]];
        [self.imagesArray addObject:[NSString stringWithFormat:@"head_%d.png",i]];
    }
    

    [HttpRequestEngine getAlliconInfoWithImei:@"ASWO" imsi:@"100001" customerId:@"1" deviceType:@"123" complete:^(BOOL success,NSMutableArray* resultArray){
        
        if (success) {
            dataArray = resultArray;
            [self setUpCollection];
        }
    }];
    
}

-(void)setUpCollection
{
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    UINib *hsCellNib = [UINib nibWithNibName:@"HorizontalScrollCell" bundle:nil];
    UINib *headViews= [UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil];
    [self.collection registerNib:hsCellNib forCellWithReuseIdentifier:@"cvcHsc"];
    [self.collection registerNib:headViews forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Reusable"];
    icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 200)];

    icarousel.type = iCarouselTypeCoverFlow2;
      [self.collection addSubview:icarousel];
    icarousel.dataSource = self;
    icarousel.delegate = self;
    self.wrap = YES;
    
    [self.collection reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalScrollCell *hsc =[collectionView dequeueReusableCellWithReuseIdentifier:@"cvcHsc" forIndexPath:indexPath];
    [hsc setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5f]];
    SessisterListObject* listObject = [dataArray objectAtIndex:indexPath.section];
    hsc.sessionListObject = listObject;
    [hsc setUpCellWithArray:listObject.sessionValueArray];
    [hsc.scroll setFrame:CGRectMake(hsc.scroll.frame.origin.x, hsc.scroll.frame.origin.y, hsc.frame.size.width, 120)];
    
    hsc.cellDelegate = self;
    
    return hsc;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(self.view.frame.size.width, 120);
    return retval;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(100.0f, 30.0f);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    return [self.collection.collectionViewLayout layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    HeaderCollectionReusableView* aLabel = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Reusable" forIndexPath:indexPath];
    aLabel.headerLabel.frame = CGRectMake(0, 0,100, 30);
    aLabel.headerLabel.textAlignment = NSTextAlignmentLeft;
    aLabel.headerLabel.textColor = [UIColor whiteColor];
    SessisterListObject* listObject = [dataArray objectAtIndex:indexPath.section];
    aLabel.headerLabel.text = listObject.sessisterTitle;
    return aLabel;
    
}


/**
 *  cell的头部
 */
-(void)cellSelected:(SessisterValueObject*) valueObject andListObject:(SessisterListObject *)aListObject
{
    NSLog(@"Selected !!");
    
    ImagesPreviewViewController* imagesPreviewVc = [[ImagesPreviewViewController alloc] initWithNibName:@"ImagesPreviewViewController" bundle:nil];
    imagesPreviewVc.aValueObject = valueObject;
    imagesPreviewVc.aListObject = aListObject;
    
    [self.navigationController pushViewController:imagesPreviewVc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.imagesArray count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:[self.imagesArray objectAtIndex:index]];
        view.contentMode = UIViewContentModeScaleAspectFit;
      
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
   // label.text = [self.imagesArray[(NSUInteger)index] stringValue];
  
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * icarousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (icarousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.imagesArray)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(icarousel.currentItemIndex));
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
