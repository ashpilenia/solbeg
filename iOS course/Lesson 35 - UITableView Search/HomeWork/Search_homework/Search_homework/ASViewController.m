//
//  ASViewController.m
//  Search_homework
//
//  Created by Alex on 4/26/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASViewController.h"
#import "ASStudent.h"

static NSString * const kStudId = @"kStudId";

@interface ASViewController () 

@property (strong, nonatomic) NSArray *studentsArray;

@end

@implementation ASViewController

- (void)viewDidLoad {
    
    self.studentsArray = [self createStudentClass:20];
    
    [super viewDidLoad];
}

#pragma mark - UItableViewDataSource

- (NSInteger)  numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentsArray.count;
}

- (UITableViewCell  *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASStudent *stud = [self.studentsArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kStudId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", stud.name, stud.lastName];
    cell.detailTextLabel.text = stud.birthDate;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    return cell;
}

#pragma mark - UItableViewDelegate

#pragma mark - Custom Methods

- (NSArray <ASStudent *>*) createStudentClass:(NSInteger) classSize
{
    NSMutableArray <ASStudent *>* tempArray = [NSMutableArray array];
    for (int i = 0; i < classSize; i++)
    {
        ASStudent *stud = [[ASStudent alloc] init];
        stud.name = [self randomName];
        stud.lastName  = [self randomName];
        stud.birthDate = [self getBirth];
        
        [tempArray addObject:stud];
    }
    
    NSArray *studentsArray = tempArray;
    return studentsArray;
}

- (NSString *) randomName
{
    NSInteger length = arc4random_uniform(5) + 5;
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";
    NSMutableString *nameString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++)
    {
        [nameString appendFormat:@"%C", [letters characterAtIndex:arc4random() % letters.length]];
    }
    
    return [NSString stringWithFormat:@"%@", [nameString capitalizedString]];
}

- (NSString *) getBirth {
    
    NSTimeInterval interval = arc4random() % 63072000 + 315360000;
    NSDate *randomDate = [NSDate dateWithTimeIntervalSinceNow:-1*interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *retVal = [formatter stringFromDate:randomDate];
    
    return retVal;
}

@end
