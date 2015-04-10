//
//  HttpClientManager.h
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-1.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpClientManager : AFHTTPSessionManager
+(instancetype)  shareManager;
-(void) httpRequset:(NSString*) interface parameters:(NSDictionary*) dict completeBlock:(void (^)(BOOL success ,NSDictionary* resutl) )block ;
@end
