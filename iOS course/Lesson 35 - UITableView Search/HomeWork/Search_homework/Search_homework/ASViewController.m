//
//  ASViewController.m
//  Search_homework
//
//  Created by Alex on 4/26/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASViewController.h"
#import "ASStudent.h"
#import "ASSection.h"
#import "ASDateFormatter.h"

typedef NS_ENUM(NSInteger, FilterType) {
    FitlerByMonth,
    FilterByFirstName,
    FilterByLastName
};

static NSString * const kStudId = @"kStudId";

@interface ASViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) NSArray *studentsArray;
@property (strong, nonatomic) NSArray <ASSection *>*sectionsArray;

@end

@implementation ASViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    
    self.searchBar.showsCancelButton = YES;
    
    self.searchBar.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    NSInteger randomNumber = arc4random() % 20 + 50;
    self.studentsArray = [self createStudentClass:randomNumber];
    
    [self processData];
    
    [super viewDidLoad];
}

#pragma mark - UItableViewDataSource

- (NSInteger)  numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionsArray objectAtIndex:section].sectionItems.count;
}

- (UITableViewCell  *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASSection *section = [self.sectionsArray objectAtIndex:indexPath.section];
    ASStudent *stud = [section.sectionItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kStudId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", stud.name, stud.lastName];
    cell.detailTextLabel.text = stud.birthDateString;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [self.sectionsArray valueForKey:@"name"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.sectionsArray objectAtIndex:section].name;
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.sectionsArray = [self generateSectionsWithFilter:searchText
                                            andFilterType:self.segmentedControl.selectedSegmentIndex];
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}


#pragma mark - Custom Methods

- (void)processData {
    
    [self sorting:self.studentsArray];
    
    self.sectionsArray = [self generateSectionsWithFilter:self.searchBar.text
                                            andFilterType:self.segmentedControl.selectedSegmentIndex];
}

- (NSArray <ASStudent *>*) createStudentClass:(NSInteger) classSize
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableArray <ASStudent *>* tempArray = [NSMutableArray array];
    for (int i = 0; i < classSize; i++)
    {
        ASStudent *stud = [[ASStudent alloc] init];
        stud.name = [self randomName];
        stud.lastName  = [self randomName];
        [self getBirth:stud];
        stud.month = [calendar component:NSCalendarUnitMonth fromDate:stud.birthDate];
        
        [tempArray addObject:stud];
    }
    
    NSArray *studentsArray = tempArray;
    return studentsArray;
}

- (NSString *)randomName
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

- (void) getBirth:(ASStudent *) student {
    
    NSTimeInterval interval = arc4random() % 63072000 + 315360000;
    NSDate *randomDate = [NSDate dateWithTimeIntervalSinceNow:-interval];
    student.birthDate = randomDate;
    
    ASDateFormatter *formatter = [ASDateFormatter getFormatter];
    NSString *dateString = [formatter stringFromDate:randomDate];
    student.birthDateString = dateString;
}

- (NSArray <ASSection *>*) generateSectionsWithFilter:(NSString *)searchString andFilterType:(FilterType)filterType
{
    NSMutableArray *sectionsArray = [NSMutableArray array];
    ASSection *currentSection;
    
        for (ASStudent *obj in self.studentsArray)
        {
            if ([obj.name rangeOfString:searchString].location == NSNotFound && [obj.lastName rangeOfString:searchString].location == NSNotFound && searchString.length)
            {
                continue;
            }
            NSString *sectionName;
            switch (self.segmentedControl.selectedSegmentIndex) {
                case 0:
                    sectionName = [self cutDateComponent:obj.birthDateString];
                    break;
                case 1:
                    sectionName = [obj.name substringToIndex:1];
                    break;
                    case 2:
                    sectionName = [obj.lastName substringToIndex:1];
                default:
                    break;
            }
            if (![sectionName isEqualToString:currentSection.name])
            {
                ASSection *section = [ASSection new];
                section.name = sectionName;
                section.sectionItems = [NSMutableArray array];
                [section.sectionItems addObject:obj];
                currentSection = section;
                
                [sectionsArray addObject:section];
            }
            else
            {
                [currentSection.sectionItems addObject:obj];
            }
        }
    NSArray *retValue = sectionsArray;
    
    return retValue;
}

- (void)sorting:(NSArray <ASStudent *>*)studentsArray {
    
    NSSortDescriptor *birthDesctiptor = [NSSortDescriptor sortDescriptorWithKey:@"month" ascending:YES];
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSArray <NSSortDescriptor *>* descriptorArray;
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            descriptorArray = [NSArray arrayWithObjects:birthDesctiptor, nameDescriptor, lastNameDescriptor, nil];
        }
        break;
            
        case 1:
        {
            descriptorArray = [NSArray arrayWithObjects:nameDescriptor, birthDesctiptor, lastNameDescriptor, nil];
        }
        break;
            
        case 2:
        {
            descriptorArray = [NSArray arrayWithObjects:lastNameDescriptor, birthDesctiptor, nameDescriptor, nil];
        }
        break;
        default:
            break;
    }
    
    self.studentsArray = [studentsArray sortedArrayUsingDescriptors:descriptorArray];
    
}

- (NSString *) cutDateComponent:(NSString *) dateString {
    
    ASDateFormatter *formatter =[ASDateFormatter getFormatter];
    NSDate *transDate = [formatter dateFromString:dateString];
    
    ASDateFormatter *monthFormatter = [ASDateFormatter cutMonthFormatter];
    NSString *retValue = [monthFormatter stringFromDate:transDate];
    
    return retValue;
}

#pragma mark - Segmented Control

- (IBAction)segmentedControlValueChangedAction:(UISegmentedControl *)sender {
    
    [self processData];
    [self.tableView reloadData];
}

@end
