//
//  DetailViewController.h
//  ScheduleIUH
//
//  Created by DQuang on 3/15/16.
//  Copyright © 2016 Rasia Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *thu;
@property (strong, nonatomic) IBOutlet UILabel *tiet;
@property (strong, nonatomic) IBOutlet UILabel *phong;
@property (strong, nonatomic) IBOutlet UILabel *mon;
@property (strong, nonatomic) IBOutlet UILabel *giangvien;
@property (strong, nonatomic) IBOutlet UILabel *thoigian;
@property NSDictionary *detail;
@end
