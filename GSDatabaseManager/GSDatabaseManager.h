//
//  GSDatabaseManager.h
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/18.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

//在这里定义数据库的名字 方便下次获取 单个数据库默认此数据库
#define GSDataBaseDefaultName @"defaultDatabase"

@interface GSDatabaseManager : NSObject

#pragma mark - Create Database

/**
 获取数据库单例
 */
+ (instancetype)sharedManager;


#pragma mark - 增


/**
 插入一条数据  如果有主键重复 则替代 不新增

 @param obj 插入的对象
 @param tableName 表名 可传空则默认类名为表明
 @return 插入是否成功
 */
-(BOOL)insertOrReplaceObject:(WCTObject *)obj into:(NSString * __nullable)tableName;



/**
 插入多条数据

 @param array 要插入的数据集合
 @param tableName 表名 可传空则默认类名为表明
 @return 插入数据是否成功结果
 */
-(BOOL)insertOrReplaceObjects:(NSArray<WCTObject *>*)array into:(NSString * __nullable)tableName;

#pragma mark - 删

/**
 删除表的所有数据

 @param tableName 表名
 */
- (BOOL)deleteAllObjectsFromTable:(NSString *)tableName;


/**
 根据条件删除数据

 @param tableName 表名
 @param condition 删除条件  类似 Class.age == 1 或者 Class.age > 1
 @return 删除是否成功
 */
- (BOOL)deleteObjectsFromTable:(NSString *)tableName where:(const WCTCondition &)condition;

#pragma mark - 改

/**
 更新

 @param tableName 需要更新的表
 @param property 更新的属性 Class.property
 @param value 更新的值
 @return 更新是否成功
 */
- (BOOL)updateAllRowsInTable:(NSString *)tableName onProperty:(const WCTProperty &)property withValue:(WCTValue *)value;

#pragma mark - 查

/**
 获取表的所有数据

 @param cls 数据的类
 @param tableName 表名 可传空则默认类名为表明
 @return 获取的数据
 */
-(NSArray *)getAllObjectsOfClass:(Class)cls fromTable:(NSString * __nullable)tableName;



/**
 根据条件查询数据

 @param cls 获取的数据的类
 @param tableName 表名
 @param condition 查询条件   类似 Class.age == 1 或者 Class.age > 1
 @return 查询的结果
 */
-(NSArray *)getObjectsOfClass:(Class)cls fromTable:(NSString * __nullable)tableName where:(const WCTCondition &)condition;

@end

NS_ASSUME_NONNULL_END
