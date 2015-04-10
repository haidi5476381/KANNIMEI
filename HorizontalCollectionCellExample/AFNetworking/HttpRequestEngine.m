//
//  HttpRequestEngine.m
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-1.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "HttpRequestEngine.h"
#import "HttpClientManager.h"
#import "SessisterListObject.h"

@implementation HttpRequestEngine
+(void) getAlliconInfoWithImei:(NSString*) imei imsi:(NSString*) imsi customerId:(NSString*) aCustomerId deviceType:(NSString*) aDeviceType  complete:(void(^)(BOOL success,NSMutableArray* resulArra)) block {
    
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:imei,@"imei",imsi,@"imsi",aCustomerId,@"customerid",aDeviceType,@"android",nil];
    [[HttpClientManager shareManager] httpRequset:@"getalliconinfo.action" parameters:dict completeBlock:^(BOOL success,NSDictionary* result){
        
        NSArray*  resultArray = [result objectForKey:@"seesisterlist"];
        NSMutableArray*  newResutlArray = [[NSMutableArray alloc] initWithCapacity:0];
        if (resultArray.count > 0) {
            for(NSDictionary* dict in resultArray) {
                
                SessisterListObject* sessisterListObject = [[SessisterListObject alloc] initObjectWithDict:dict];
                [newResutlArray addObject:sessisterListObject];
            }
            
            block(YES,newResutlArray);
        }
    }];
}

+(void) getIconDetailWithItemName:(NSString*) aItemName categoryName:(NSString*) aCategoryName  complete:(void(^)(BOOL success,NSDictionary* resultDict)) block {
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:aItemName,@"ItemName",aCategoryName,@"CategoryName",nil];
    [[HttpClientManager shareManager] httpRequset:@"geticondetail.action" parameters:dict completeBlock:^(BOOL success,NSDictionary* result) {
        
        block(YES,result);
        
    }];
}
@end
