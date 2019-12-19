//
//  ShowResultsViewController.m
//  WCDCDemo
//
//  Created by caoguosheng on 2019/12/18.
//  Copyright © 2019 caoguosheng. All rights reserved.
//

#import "ShowResultsViewController.h"

#import <YYModel/YYModel.h>

@interface ShowResultsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLab;

@end

@implementation ShowResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.array.count > 0) {
        NSString *resultStr = @"";
        for (int i = 0; i < self.array.count; i++) {
            NSObject *obj = self.array[i];
           resultStr = [NSString stringWithFormat:@"%@%@\n",resultStr, obj.yy_modelToJSONString];
        }
        self.resultLab.text = resultStr;
    }
}


@end
