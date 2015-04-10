//
//  HttpRequestEngine.h
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-1.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestEngine : NSObject

/**
 *  返回所有的图片类别
bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
 *  @param aCustomerId <#aCustomerId description#>
 *  @param aDeviceType <#aDeviceType description#>
 *  @param block       <#block description#>
 */
+(void) getAlliconInfoWithImei:(NSString*) imei imsi:(NSString*) imsi customerId:(NSString*) aCustomerId deviceType:(NSString*) aDeviceType  complete:(void(^)(BOOL success,NSMutableArray* resulArray)) block;

/**
 *  根据图片名字获取图片详情地址
 *
 *  @param aItemName     <#aItemName description#>
 *  @param aCategoryName <#aCategoryName description#>
 *  @param block         <#block description#>
 */
+(void) getIconDetailWithItemName:(NSString*) aItemName categoryName:(NSString*) aCategoryName  complete:(void(^)(BOOL success,NSDictionary* resultDict)) block;


@end
