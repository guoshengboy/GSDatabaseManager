//
//  PersonModel.h
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/16.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimalModel.h"


@interface PersonModel : NSObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger pId;
@property(nonatomic, retain) NSString *phone;

@property (nonatomic, retain) NSArray *interests;
@property (nonatomic, retain) NSDictionary <AnimalModel *>*animal;


@end
