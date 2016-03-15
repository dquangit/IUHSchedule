//
//  ViewController.m
//  htmlDemo
//
//  Created by DQuang on 3/13/16.
//  Copyright © 2016 Rasia Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

@end
static NSString *appDetail = @"IUH Schedule 1.0 \nDesign by DQuang\nGmail + Skype:\nphamvanquangit@gmail.com\nFacebook:\nfacebook.com/SherlockQuang";
NSMutableArray *a;
NSMutableArray *currentTime;
int thisYear;
@implementation ViewController

- (void)viewDidLoad {
    [self initSomeThing];
    [super viewDidLoad];
    [self setFrame];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initSomeThing{
    currentTime = [[NSMutableArray alloc] init];
    a = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    currentTime = [NSMutableArray arrayWithArray:[[dateFormatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"]];
}

-(void)setFrame{
    _tableView.hidden = YES;
    _name.enabled = NO;
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    _namhoc.enabled = NO;
    if ([[currentTime objectAtIndex:1] intValue] > 8) {
        _namhoc.text = [NSString stringWithFormat:@"%d - %d",[[currentTime objectAtIndex:0] intValue],[[currentTime objectAtIndex:0] intValue] + 1];
        thisYear = [[currentTime objectAtIndex:0] intValue];
    } else {
        _namhoc.text = [NSString stringWithFormat:@"%d - %d",[[currentTime objectAtIndex:0] intValue] -1,[[currentTime objectAtIndex:0] intValue]];
        thisYear = [[currentTime objectAtIndex:0] intValue] - 1;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn:(id)sender {
    if ([_mssv.text length] == 0 || [_hocky.text length] == 0) {
        if([_mssv.text length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo: " message:@"Quên nhập mã số sinh viên kìa má :))" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        } else if ([_hocky.text length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo: " message:@"Không nhập học kỳ mấy ai biết mà kiếm >.<" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];

        }
    } else {
        NSString *urlString = [NSString stringWithFormat:@"http://www.iuh.edu.vn/phongdaotao/TV_InLopHocPhanDaDangKy.aspx?MaSV=%@&NienHoc=%d&HocKy=%@",_mssv.text,thisYear,_hocky.text];
        NSURL *url = [NSURL URLWithString:urlString];
        NSError *error = nil;
        NSString *string = [NSString stringWithContentsOfURL:url usedEncoding:nil error:&error];
        string = [self convertHTML:string];
        NSMutableArray *ar = [NSMutableArray arrayWithArray:
                              [string componentsSeparatedByString:@"  "]];
        for (int i = [ar count] -1; i >= 0; i --) {
            if ([[ar objectAtIndex:i] isEqualToString:@""]){
            [ar removeObjectAtIndex:i];
            }
        }
    
        [ar removeLastObject];
    
        for (int i = 0; i < [ar count]; i++) {
            NSLog(@"%d %@",i,[ar objectAtIndex:i]);
        }
        if ([ar count] < 29) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops: " message:@"Không tìm thấy dữ liệu" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];

        } else {
            a = [self parseToArray:ar];
            for (int i = 0; i < [a count]; i++){
                NSLog(@"%@",[[a objectAtIndex:i] objectForKey:@"thu"]);
            }
            _name.text = [NSString stringWithFormat:@"%@",[_info objectForKey:@"hoten"]];
            _tableView.hidden = NO;
            [_tableView reloadData];
        }
    }
}


-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    html = [self convertDQ:html];
    
    return html;
}

- (NSString *)convertDQ:(NSString *)string {
    NSString *s = [string stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"SÁNG"     withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"CHIỀU"    withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"TỐI"      withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"  "       withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@";" withString:@""];
    s = [[s componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    return s;
}

- (NSMutableArray *)parseToArray:(NSMutableArray *)ar {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    _info               = @{@"namhoc"   :[ar objectAtIndex:8],
                            @"hocky"    :[ar objectAtIndex:10],
                            @"hoten"    :[ar objectAtIndex:12],
                            @"masv"     :[ar objectAtIndex:14]};
    NSDictionary *tmpDic = [[NSMutableDictionary alloc] init];
    NSString *currentString;
    for (int i = 21; i < [ar count]; i += 6) {
        NSLog(@"%d",i);
        while ([self isCurrentStringADate:[ar objectAtIndex:i]]) {
            currentString = [ar objectAtIndex:i];
            i++;
            if (i >= [ar count])
                break;
        }
        if (i > [ar count] - 6) {
            break;
        }
        NSLog(@"%@",currentString);
        tmpDic = @{@"thu"       :currentString,
                   @"mon"       :[ar objectAtIndex:i],
                   @"tiet"      :[ar objectAtIndex:i+1],
                   @"giangvien" :[ar objectAtIndex:i+2],
                   @"phong"     :[ar objectAtIndex:i+3],
                   @"batdau"    :[ar objectAtIndex:i+4],
                   @"ketthuc"   :[ar objectAtIndex:i+5]};
            [res addObject:tmpDic];
            NSLog(@"%d-",i+5);
    }
    return [NSMutableArray arrayWithArray:res];
}

- (BOOL)isCurrentStringADate:(NSString *)currentString{
    if ([currentString  isEqualToString:@"HAI"] ||
    [currentString      isEqualToString:@"BA"]  ||
    [currentString      isEqualToString:@"TƯ"]  ||
    [currentString      isEqualToString:@"NĂM"] ||
    [currentString      isEqualToString:@"SÁU"] ||
    [currentString      isEqualToString:@"BẢY"] ||
    [currentString      isEqualToString:@"CN"]) {
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [a count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.contentView.layer.borderColor  = [UIColor blackColor].CGColor;
    cell.contentView.layer.borderWidth  = 0.25;
    NSMutableDictionary *tmp            = [a objectAtIndex:indexPath.row];
    if ([[tmp objectForKey:@"thu"] isEqualToString:@"CN"]) {
        cell.thu.text = @"CN";
    } else {
    cell.thu.text       = [NSString stringWithFormat:@"THỨ %@",[tmp objectForKey:@"thu"]];
    }
    cell.mon.text       = [tmp objectForKey:@"mon"];
    cell.tiet.text      = [tmp objectForKey:@"tiet"];
    cell.phong.text     = [tmp objectForKey:@"phong"];
    return cell;
}


- (IBAction)btnUp:(id)sender {
    thisYear++;
    _namhoc.text = [NSString stringWithFormat:@"%d - %d",thisYear,thisYear+1];
}

- (IBAction)btnDown:(id)sender {
    thisYear--;
    _namhoc.text = [NSString stringWithFormat:@"%d - %d",thisYear,thisYear+1];
}

- (IBAction)btnAbout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông tin chi tiết: " message:appDetail delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    NSArray *subViewArray = alert.subviews;
    for(int x = 0; x < [subViewArray count]; x++){
        if([[[subViewArray objectAtIndex:x] class] isSubclassOfClass:[UILabel class]]) {
            UILabel *label = [subViewArray objectAtIndex:x];
            label.textAlignment = NSTextAlignmentLeft;
        }
    }
    [alert show];
}

-(void)dismissKeyboard {
    [_mssv resignFirstResponder];
    [_hocky resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushToListViewController:indexPath.row];
}

- (void)pushToListViewController:(NSInteger)index{
    DetailViewController            *detailViewController;
    UIStoryboard *storyboard                      = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    detailViewController              = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.detail = [NSDictionary dictionaryWithDictionary:[a objectAtIndex:index]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
