//
//  ASDirectoryViewController.m
//  FileManagerTest
//
//  Created by Alex on 11/16/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDirectoryViewController.h"
#import "ASFileCell.h"
#import "UIView+UITableViewCell.h"

@interface ASDirectoryViewController ()


@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSString *selectedPath;

@end

@implementation ASDirectoryViewController

- (id) initWithFolderPath:(NSString *) path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.path = path;
    }
    return self;
}

- (void) setPath:(NSString *)path
{
    _path = path;
    
    NSError *error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.path)
    {
        self.path = @"Users/alex/Documents";
    }
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    static NSString *fileIdentifier = @"FileCell";
    static NSString *folderIdentifier = @"FolderCell";
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:folderIdentifier];
        }
        
        cell.textLabel.text = fileName;
        
        return cell;
    }
    else
    {
        
        NSString *path = [self.path stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
        ASFileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
        
        cell.nameLabel.text = fileName;
        cell.sizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
        
        static NSDateFormatter *formatter = nil;
        
        if (!formatter)
        {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        }
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[attributes fileModificationDate]]];
    
    return cell;
    }
}

#pragma mark - UITableViewDelegat

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        
//        ASDirectoryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDirectoryViewController"];
//        vc.path = filePath;
//
//        [self.navigationController pushViewController:vc animated:YES];
        
        self.selectedPath = filePath;
        
        [self performSegueWithIdentifier:@"navigateInside" sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        return 44.f;
    }
    else
    {
        return 80.f;
    }
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue %@", segue.identifier);
    ASDirectoryViewController *vc = segue.destinationViewController;
    vc.path = self.selectedPath;
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"shouldPerformSegueWithIdentifier: %@", identifier);
    
    return YES;
}

#pragma mark - Actions

- (void) backToRoot:(UIBarButtonItem *) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) actionInfoCell:(UIButton *)sender
{
    
    UITableViewCell *cell = [sender superCell];
    
    if (cell)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSLog(@"tapped on section: %ld row: %ld", indexPath.section, indexPath.row);
    }
    
    
    
}

#pragma mark - Custom methods

- (NSString *) fileSizeFromValue:(unsigned long long) size
{
    static NSString *units[] = {@"B", @"KB", @"MB", @"GB", @"TB"};
    static int unitsCount = 5;
    
    int index = 0;
    double filesize = (double)size;
    
    while (filesize > 1024 && index < unitsCount) {
        filesize = filesize / 1024;
        index++;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", filesize, units[index]];
}

@end
