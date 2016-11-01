//
//  WXNewsController.m
//  NetEaseNewsHomePage
//
//  Created by 王旭 on 2016/11/1.
//  Copyright © 2016年 wangxu. All rights reserved.
//

#import "WXNewsController.h"

@interface WXNewsController ()

@end

@implementation WXNewsController


static NSString *ID = @"cell";

+ (instancetype)initWithTitle:(NSString *)title{
    WXNewsController *vc = [[self alloc] init];
    vc.title = title;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",self.title,indexPath.row ];
    
    return cell;
}



@end
