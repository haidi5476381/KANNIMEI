//
//  HttpClientManager.m
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-1.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "HttpClientManager.h"

@implementation HttpClientManager
+(instancetype)  shareManager {
    
    static HttpClientManager*  _httpClientManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _httpClientManager = [[HttpClientManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://wan-game.com/zllgameplatform/seesister/"]];

    });
    return _httpClientManager;
}

-(void) httpRequset:(NSString*) interface parameters:(NSDictionary*) dict completeBlock:(void (^)(BOOL success ,NSDictionary* resutl) )block {
    

   [self GET:interface parameters:dict success:^(NSURLSessionDataTask* task , id response) {
        block(YES,response);
        
    }failure:^(NSURLSessionDataTask* task ,NSError* error) {
        block(NO,nil);
        
    }];
}



@end
