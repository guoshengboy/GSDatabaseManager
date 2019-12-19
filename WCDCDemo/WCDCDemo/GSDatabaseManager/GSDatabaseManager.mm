//
//  GSDatabaseManager.m
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/18.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "GSDatabaseManager.h"



@interface GSDatabaseManager ()

@property (nonatomic, strong) WCTDatabase *db;

@end

@implementation GSDatabaseManager

+ (instancetype)sharedManager {
    static GSDatabaseManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
        [_sharedManager createDatabase];
    });
    
    return _sharedManager;
}


#pragma mark - Private Method

//创建数据库
- (BOOL)createDatabase{
    //数据库路径
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(), GSDataBaseDefaultName];
    NSLog(@"路径为%@",path);
    //创建数据库 路径一样,  该接口使用的是IF NOT EXISTS的SQL，因此可以用重复调用
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    _db = database;
    if ([database canOpen]) {
        NSLog(@"创建数据库成功");
         return YES;
    }else{
        NSLog(@"创建数据库失败");
        return NO;
    }
}

//判断数据库是否存在 不存在就创建
- (BOOL)isExistOfTable:(NSString *)tableName WithClass:(Class<WCTTableCoding>)cls{
    BOOL result = [_db createTableAndIndexesOfName:tableName withClass:cls];
    if (!result) {
        NSLog(@"创建表失败");
        return NO;
    }
    return YES;
}

//获取表名
- (NSString *)getTableNaneWithClass:(Class)cls withOldTableName:(NSString *)tableName{
    if (!tableName || tableName.length == 0) {
        return NSStringFromClass(cls);
    }
    return tableName;
}


#pragma mark - Public Method
-(BOOL)insertOrReplaceObject:(WCTObject *)obj into:(NSString *)tableName{
    tableName = [self getTableNaneWithClass:[obj class] withOldTableName:tableName];
    if ([self isExistOfTable:tableName WithClass:[obj class]]) {
        return [_db insertOrReplaceObject:obj into:tableName];
    }
    return NO;
}


-(BOOL)insertOrReplaceObjects:(NSArray<WCTObject *>*)array into:(NSString *)tableName{
    if (array.count > 0) {
        WCTObject *obj = array[0];
        tableName = [self getTableNaneWithClass:[obj class] withOldTableName:tableName];
        if ([self isExistOfTable:tableName WithClass:[obj class]]) {
            return [_db insertOrReplaceObjects:array into:tableName];
        }
    }
    return NO;
}


- (BOOL)deleteAllObjectsFromTable:(NSString *)tableName{
    return [_db deleteAllObjectsFromTable:tableName];
}

- (BOOL)deleteObjectsFromTable:(NSString *)tableName where:(const WCTCondition &)condition{
    return [_db deleteObjectsFromTable:tableName where:condition];
}

- (BOOL)updateAllRowsInTable:(NSString *)tableName onProperty:(const WCTProperty &)property withValue:(WCTValue *)value{
    return [_db updateAllRowsInTable:tableName onProperty:property withValue:value];
}

-(NSArray *)getAllObjectsOfClass:(Class)cls fromTable:(NSString *)tableName{
    tableName = [self getTableNaneWithClass:cls withOldTableName:tableName];
    return [_db getAllObjectsOfClass:cls fromTable:tableName];
}

-(NSArray *)getObjectsOfClass:(Class)cls fromTable:(NSString * __nullable)tableName where:(const WCTCondition &)condition{
    tableName = [self getTableNaneWithClass:cls withOldTableName:tableName];
    return [_db getObjectsOfClass:cls fromTable:tableName where:condition];
}

@end
