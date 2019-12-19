//
//  ViewController.m
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/16.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"
#import "PersonModel+WCTTableCoding.h"
#import <WCDB/WCDB.h>
#import <Toast/Toast.h>
#import <YYModel/YYModel.h>
#import "GSDatabaseManager.h"
#import "ShowResultsViewController.h"

@interface ViewController ()

@property(nonatomic, retain)  WCTDatabase *database;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *ageTf;
@property (weak, nonatomic) IBOutlet UITextField *pidTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(WCTDatabase *)database{
    if (!_database) {
        [self creatDatabaseAndTable];
    }
    return _database;
}


- (PersonModel *)getPerson{
    PersonModel *p = [[PersonModel alloc] init];
    p.name = self.nameTf.text;
    p.age = [self.ageTf.text integerValue];
    p.pId = [self.pidTf.text integerValue];
    p.phone = self.phoneTf.text;
    p.interests = @[@"1", @"2", @"3"];
    
    AnimalModel *animal = [[AnimalModel alloc] init];
    animal.weight = 100;
    p.animal = [NSDictionary yy_modelDictionaryWithClass:[AnimalModel class] json:animal.yy_modelToJSONString];
    return p;
}

- (IBAction)insertObject:(id)sender {
    [[GSDatabaseManager sharedManager] insertOrReplaceObject:[self getPerson] into:nil];
}


- (IBAction)queryObject:(id)sender {
    NSArray *array = [[GSDatabaseManager sharedManager] getAllObjectsOfClass:[PersonModel class] fromTable:NSStringFromClass([PersonModel class])];
    
//    NSArray *array = [[GSDatabaseManager sharedManager] getObjectsOfClass:[PersonModel class] fromTable:nil where:PersonModel.pId > 1];
    
    [self.view makeToast:[array yy_modelToJSONString]];
    if (array.count > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ShowResultsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ShowResultsViewController"];
        vc.array = array;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.view makeToast:@"未获取到数据"];
    }
    
   
 }

- (IBAction)deleteAction:(id)sender {
    [[GSDatabaseManager sharedManager] deleteAllObjectsFromTable:NSStringFromClass([PersonModel class])];
    
//    [[GSDatabaseManager sharedManager] deleteObjectsFromTable:@"PersonModel" where:PersonModel.pId == 1];
    
   
}

- (IBAction)updateAction:(id)sender {
//    [[GSDatabaseManager sharedManager] updateAllRowsInTable:@"PersonModel" onProperty:PersonModel.name withValue:@"updateName"];
    
    [self.database updateAllRowsInTable:@"PersonModel" onProperty:PersonModel.name  withObject:[self getPerson]];
    
    
}

- (BOOL)creatDatabaseAndTable {
    //数据库路径
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/NewDB"];
    NSLog(@"%@",path);
    //创建数据库 路径一样,  该接口使用的是IF NOT EXISTS的SQL，因此可以用重复调用
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    _database = database;
    if ([database canOpen]) {
        NSLog(@"创建数据库成功");
    }else{
        NSLog(@"创建数据库失败");
        return NO;
    }

    //创建表  注：该接口使用的是IF NOT EXISTS的SQL，因此可以用重复调用。不需要在每次调用前判断表或索引是否已经存在。
    BOOL result = [database createTableAndIndexesOfName:@"PersonModel" withClass:PersonModel.class];

    if (!result) {
        NSLog(@"创建表失败");
        return NO;
    }
    return YES;
}


@end
