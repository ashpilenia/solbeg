//
//  ASDirectoryViewController.m
//  FileManagerTest
//
//  Created by Alex on 11/16/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDirectoryViewController.h"

@interface ASDirectoryViewController ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation ASDirectoryViewController

- (id) initWithFolderPath:(NSString *) path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        NSError *error = nil;
        
        self.path = path;
        
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                            error:&error];
        if (error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if ([self.navigationController.viewControllers count] > 1)
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back to Root"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backToRoot:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath *) indexPath
{
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"stringID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fileName;
    
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegat

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        
        ASDirectoryViewController *vc = [[ASDirectoryViewController alloc] initWithFolderPath:filePath];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - Actions

- (void) backToRoot:(UIBarButtonItem *) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
