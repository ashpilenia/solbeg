//
//  ViewController.m
//  KVCHomeWork
//
//  Created by Alex on 2/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerController.h"
#import "GradesListController.h"
#import "TextViewCell.h"
#import "SegmentedViewCell.h"
#import "SimpleCell.h"

static NSString * const kReuseIdentifier = @"reuseIdentifier";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.student = [[ASStudent alloc] initWithInitialParams];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TextViewCell class]) bundle:nil] forCellReuseIdentifier:[TextViewCell reuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SegmentedViewCell class]) bundle:nil] forCellReuseIdentifier:[SegmentedViewCell reuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleCell class]) bundle:nil] forCellReuseIdentifier:[SimpleCell reuseIdentifier]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0:
            {
                TextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:[TextViewCell reuseIdentifier]];
                textCell.isLastNameCell = NO;
                textCell.student = self.student;
                textCell.textView.text = self.student.name;
                cell = textCell;
            }
            break;
            
        case 1:
            {
                TextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:[TextViewCell reuseIdentifier]];
                textCell.isLastNameCell = YES;
                textCell.student = self.student;
                textCell.textView.text = self.student.lastName;
                cell = textCell;
            }
            break;
            
        case 2:
            {
                SegmentedViewCell *segmentedCell = [tableView dequeueReusableCellWithIdentifier:[SegmentedViewCell reuseIdentifier]];
                segmentedCell.student = self.student;
                segmentedCell.segmentedView.selectedSegmentIndex = self.student.gender;
                cell = segmentedCell;
                
            }
            break;
            
        case 3:
            {
                SimpleCell *simpleCell = [tableView dequeueReusableCellWithIdentifier:[SimpleCell reuseIdentifier] forIndexPath:indexPath];
                simpleCell.leftLabel.text = @"Grade:";
                simpleCell.rightLabel.text = [self.student gradeString];
                simpleCell.rightLabel.textColor = [UIColor blueColor];
                simpleCell.leftLabel.textColor = [UIColor blackColor];
                cell = simpleCell;
            }
            break;
            
        case 4:
            {
                SimpleCell *simpleCell = [tableView dequeueReusableCellWithIdentifier:[SimpleCell reuseIdentifier] forIndexPath:indexPath];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd/MMM/yyyy"];
                simpleCell.leftLabel.text = @"Birthday:";
                simpleCell.rightLabel.text = [formatter stringFromDate:self.student.birthDate];
                simpleCell.rightLabel.textColor = [UIColor blueColor];
                simpleCell.leftLabel.textColor = [UIColor blackColor];
                cell = simpleCell;
            }
            break;
            
        case 5:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.layer.borderWidth = 2.f;
                cell.textLabel.layer.borderColor = [UIColor blackColor].CGColor;
                cell.textLabel.text = @"Clear Data";
            }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        DatePickerController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerController"];
        controller.modalPresentationStyle = UIModalPresentationCustom;
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    if (indexPath.row == 3) {
        
        GradesListController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GradesListController"];
        controller.modalPresentationStyle = UIModalPresentationCustom;
        controller.delegate = self;
        
        [self presentViewController:controller animated:NO completion:nil];
    }
    
    if (indexPath.row == 5) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.student clearSettings];
        [self.tableView reloadData];
        
        //Master
        [self testKVCMethodStart];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (void)testKVCMethodStart {
    
    NSMutableArray *studentsArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        ASStudent *student = [[ASStudent alloc] init];
        student.name = [NSString stringWithFormat:@"Student #%d", i];
        [studentsArray addObject:student];
    }
    
    [studentsArray insertObject:self.student atIndex:3];
    
    [self setFriends:studentsArray];
    
    ASStudent *stud = studentsArray.firstObject;
    
    [stud setValue:@"CHANGED" forKeyPath:@"name"];
    [stud setValue:@"CHANGED1" forKeyPath:@"buddy.name"];
    [stud setValue:@"CHANGED2" forKeyPath:@"buddy.buddy.name"];
    [stud setValue:@"CHANGED3" forKeyPath:@"buddy.buddy.buddy.name"];
    [stud setValue:@"CHANGED4" forKeyPath:@"buddy.buddy.buddy.buddy.name"];
    [stud setValue:@"CHANGED5" forKeyPath:@"buddy.buddy.buddy.buddy.buddy.name"];
    
    for (ASStudent *student in studentsArray) {
        NSLog(@"Student name = %@", student.name);
    }
    
    //Superman
    NSArray *newArray = [self createStudentsArray];
    NSLog(@"Students names: %@", [newArray valueForKeyPath:@"@distinctUnionOfObjects.name"]);
    NSLog(@"Max date birth: %@", [newArray valueForKeyPath:@"@max.birthDate"]);
    NSLog(@"Min date birth: %@", [newArray valueForKeyPath:@"@min.birthDate"]);
    NSLog(@"Average score: %@", [newArray valueForKeyPath:@"@avg.score"]);
    NSLog(@"Total score: %@", [newArray valueForKeyPath:@"@sum.score"]);
    
    for (ASStudent *student in newArray) {
        NSLog(@"%@", student);
    }
    
}

- (void)setFriends:(NSMutableArray *)array {
    
    for (int i = 0; i < array.count; i++) {
        
        ASStudent *stud = [array objectAtIndex:i];
        if (i != array.count -1) {
            stud.buddy = [array objectAtIndex:i+1];
        } else {
            stud.buddy = [array objectAtIndex:0];
        }
    }
}

- (NSArray *)createStudentsArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        
        ASStudent *student = [[ASStudent alloc] init];
        student.score = i+1;
        student.name = [self randomName];
        student.birthDate = [self randomBirth];
        [array addObject:student];
    }
    
    return array;
}

- (NSString *)randomName {
    
    NSArray *namesArray = @[@"Jack", @"John", @"Bill", @"Carl", @"Eugene", @"Neo", @"Audrey", @"Alex", @"Clement", @"Serge"];
    NSInteger randomNumber = arc4random_uniform(9);
    return [namesArray objectAtIndex:randomNumber];
}

- (NSDate *)randomBirth {
    
    NSDate *initialDate = [NSDate dateWithTimeIntervalSinceNow:-630720000.f];
    NSTimeInterval oneYear = 31536000;
    
    NSInteger signNumber;
    if (arc4random()%2){
        signNumber = 1;
    } else {
        signNumber = -1;
    }
    
    NSInteger randomDiff = arc4random_uniform(5);
    
    NSDate *finalDate = [initialDate dateByAddingTimeInterval:oneYear*randomDiff*signNumber];
    
    return finalDate;
    
}



@end
