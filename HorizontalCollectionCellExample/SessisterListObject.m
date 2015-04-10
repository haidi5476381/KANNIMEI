//
//  SessisterListObject.m
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-2.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "SessisterListObject.h"

@implementation SessisterListObject
@synthesize sessisterTitle = _sessisterTitle,sessisterType = _sessisterType,sessionValueArray = _sessionValueArray;
-(instancetype)  initObjectWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        _sessisterTitle =[dict objectForKey:@"name"];
        _sessisterType = [dict objectForKey:@"type"];
        NSArray* valueArray = [dict objectForKey:@"value"];
        _sessionValueArray = [[NSMutableArray alloc] initWithCapacity:0];
        if (valueArray.count > 0) {
            for(NSDictionary*  dic in valueArray) {
                
                SessisterValueObject*  sessisterValueObject = [[SessisterValueObject alloc] initObjectWithDict:dic];
                [_sessionValueArray addObject:sessisterValueObject];
            }
        }
     
      
    }
    
    return self;
}
@end

@implementation SessisterValueObject
@synthesize itemName = _itemName,itemIcon = _itemIcon,itemDesc = _itemDesc;

-(instancetype) initObjectWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _itemName = [dict objectForKey:@"ItemDesc"];
        _itemIcon = [dict objectForKey:@"ItemIcon"];
        _itemName = [dict objectForKey:@"ItemName"];
    }
    return self;
}

@end
