//
//  ViewController.m
//  EditTableView
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITabBarDelegate> {
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

// 삭제/추가 작업 - 로그로 확인
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        NSLog(@"%d 번째 삭제", (int)indexPath.row);
    }
    else {
        NSLog(@"%d 번째 추가", (int)indexPath.row);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dynamic Prototypes 방식 사용
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", (int)indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
