//
//  MainEventCell.h
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainEventCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *lblName;
@property (nonatomic,weak) IBOutlet UIButton *btnFinish;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventNameCon;

+ (UINib *)nib;

- (void)autoresizingNameLabel:(NSInteger)iConstant;

@end
