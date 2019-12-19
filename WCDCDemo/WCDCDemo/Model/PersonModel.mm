//
//  PersonModel.mm
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/16.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "PersonModel+WCTTableCoding.h"
#import "PersonModel.h"
#import <WCDB/WCDB.h>

#import "AnimalModel.h"
#import "AnimalModel+WCTTableCoding.h"


@implementation PersonModel

WCDB_IMPLEMENTATION(PersonModel)

WCDB_SYNTHESIZE(PersonModel, name)
WCDB_SYNTHESIZE(PersonModel, age)
WCDB_SYNTHESIZE(PersonModel, pId)
WCDB_SYNTHESIZE(PersonModel, phone)
WCDB_SYNTHESIZE(PersonModel, interests)
WCDB_SYNTHESIZE(PersonModel, animal)


WCDB_PRIMARY(PersonModel, pId)

  
@end
