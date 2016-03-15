//
//  DetailViewController.m
//  ScheduleIUH
//
//  Created by DQuang on 3/15/16.
//  Copyright © 2016 Rasia Ltd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    _thu.text = [_detail objectForKey:@"thu"];
    _mon.text = [_detail objectForKey:@"mon"];
    _tiet.text = [_detail objectForKey:@"tiet"];
    _giangvien.text = [_detail objectForKey:@"giangvien"];
    _thoigian.text = [NSString stringWithFormat:@"%@\n%@",[_detail objectForKey:@"batdau"],[_detail objectForKey:@"ketthuc"]];
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
