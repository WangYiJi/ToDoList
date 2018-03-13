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

+ (UINib *)nib;
@end
