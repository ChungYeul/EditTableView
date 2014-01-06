//
//  ViewController.m
//  EditTableView
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITabBarDelegate> {
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController
- (IBAction)toggleEdit:(id)sender {
    self.table.editing = !self.table.editing;
}

// 각 스타일을 번갈아 가면서 사용
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.row % 3 == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    else {
        return UITableViewCellEditingStyleInsert;
    }
}

//
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    // 입력 문자열 길이가 2 보다 클때만 추가 가능
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length] > 2;
}
//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 데이터 추가 Core Logic
    [data addObject:[alertView textFieldAtIndex:0].text];
    
    // 테이블 셀 추가 UI Logic
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count] - 1) inSection:0];
    NSArray *row = [NSArray arrayWithObject:indexPath];
    [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
}
// 삭제/추가 작업 - 로그로 확인
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
//        NSLog(@"%d 번째 삭제", (int)indexPath.row);
        // 데이터 삭제
        [data removeObjectAtIndex:indexPath.row];
        
        //테이블 셀 삭제
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
//        NSLog(@"%d 번째 추가", (int)indexPath.row);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dynamic Prototypes 방식 사용
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] initWithObjects:@"Item0", @"Item1", @"Item2", @"Item3", @"Item4", @"Item5", @"Item6", @"Item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
