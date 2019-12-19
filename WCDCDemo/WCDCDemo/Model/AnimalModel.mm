//
//  AnimalModel.mm
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/19.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "AnimalModel+WCTTableCoding.h"
#import "AnimalModel.h"
#import <WCDB/WCDB.h>

@implementation AnimalModel

WCDB_IMPLEMENTATION(AnimalModel)

WCDB_SYNTHESIZE(AnimalModel, weight)

  
@end
