//
//  ThoughtsViewController.m
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import "ThoughtsViewController.h"
#import "ThoughtsStorage.h"
#import "AnalyticsManager.h"

@interface ThoughtsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThoughtsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[AnalyticsManager sharedInstance] filterThenPushEvent:@{@"event":@"screenLoad",
                                                             @"screenName":@"Thoughts"}];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ThoughtsStorage sharedInstance] returnThoughts].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSMutableArray *thoughts = [ThoughtsStorage sharedInstance].returnThoughts;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [thoughts objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
