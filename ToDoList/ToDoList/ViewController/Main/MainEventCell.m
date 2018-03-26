//
//  MainEventCell.m
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "MainEventCell.h"

@implementation MainEventCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MainEventCell" bundle:nil];
}

-(void)autoresizingNameLabel:(NSInteger)iConstant
{
    self.eventNameCon.constant = iConstant;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
