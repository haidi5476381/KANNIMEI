//
//  SessisterListObject.h
//  HorizontalCollectionCellExample
//
//  Created by Spark on 15-4-2.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessisterValueObject : NSObject
-(instancetype) initObjectWithDict:(NSDictionary*) dict;
@property (nonatomic,copy) NSString* itemDesc;
@property (nonatomic,copy) NSString* itemIcon;
@property (nonatomic,copy) NSString* itemName;
@end

@interface SessisterListObject : NSObject
-(instancetype) initObjectWithDict:(NSDictionary*) dict;
@property(nonatomic,copy) NSString*  sessisterTitle;
@property (nonatomic,copy) NSString* sessisterType;
@property (nonatomic,strong) NSMutableArray*  sessionValueArray;
@end
