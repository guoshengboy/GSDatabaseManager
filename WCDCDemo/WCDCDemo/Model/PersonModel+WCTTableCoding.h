//
//  PersonModel+WCTTableCoding.h
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/16.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "PersonModel.h"
#import <WCDB/WCDB.h>

@interface PersonModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(pId)
WCDB_PROPERTY(phone)
WCDB_PROPERTY(interests)
WCDB_PROPERTY(animal)

@end
