//
//  ViewController.h
//  htmlDemo
//
//  Created by DQuang on 3/13/16.
//  Copyright © 2016 Rasia Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet TableViewCell *tableViewCell;
- (IBAction)btn:(id)sender;
@property NSDictionary* info;
@property (strong, nonatomic) IBOutlet UITextField *mssv;
@property (strong, nonatomic) IBOutlet UITextField *hocky;
@property (strong, nonatomic) IBOutlet UITextField *namhoc;
- (IBAction)btnUp:(id)sender;
- (IBAction)btnDown:(id)sender;
- (IBAction)btnAbout:(id)sender;

@property NSMutableArray* t2,*t3,*t4,*t5,*t6,*t7,*cn;
@end

