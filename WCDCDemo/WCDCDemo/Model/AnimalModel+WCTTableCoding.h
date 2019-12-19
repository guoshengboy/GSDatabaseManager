//
//  AnimalModel+WCTTableCoding.h
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/19.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "AnimalModel.h"
#import <WCDB/WCDB.h>

@interface AnimalModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(weight)


@end
