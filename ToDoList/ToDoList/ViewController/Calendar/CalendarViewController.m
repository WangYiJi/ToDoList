//
//  CalendarViewController.m
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}

- (void)calendarViewDidChange:(id)sender {
    self.datePicker.date = self.calendarView.selectedDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
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
