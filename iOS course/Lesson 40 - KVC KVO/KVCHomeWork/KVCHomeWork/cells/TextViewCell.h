//
//  TextViewCell.h
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStudent.h"

@interface TextViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textView;

@property (nonatomic, assign) BOOL isLastNameCell;

@property (nonatomic, strong) ASStudent *student;

- (IBAction)textEditingEnded:(UITextField *)sender;

+ (NSString *)reuseIdentifier;

@end

