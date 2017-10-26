//
//  ViewController.m
//  FontsTest
//
//  Created by Alex on 10/23/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection %ld", section);
    NSArray *familyNames = [UIFont familyNames];
    
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:section]];
    
    
    return [fontNames count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *familyNames = [UIFont familyNames];
    NSString *header = [familyNames objectAtIndex:section];
    
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath {%ld, %ld}", indexPath.section, indexPath.row );
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"Cell created");
    }
    else
    {
        NSLog(@"Cell reused");
    }
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indexPath.section]];
    
    NSString *fontInstanceName = [fontNames objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fontInstanceName;
   
    UIFont *font = [UIFont fontWithName:fontInstanceName size:18];
    
    cell.textLabel.font = font;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return [[UIFont familyNames] count];
}

@end
