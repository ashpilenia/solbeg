//
//  ASDirectoryController.m
//  Navigation_Homework
//
//  Created by Alex on 12/1/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDirectoryController.h"
#import "FileCell.h"
#import "UIView+TableViewFindCell.h"
#import "ASAddFolderCell.h"

@interface ASDirectoryController ()

@property (nonatomic, strong) NSArray *content;
@property (nonatomic, assign) NSInteger foldersCount;


@end

@implementation ASDirectoryController

#pragma mark - NSObject

- (instancetype) initWithPath:(NSString *) path
{
    self = [super initWithStyle:(UITableViewStyleGrouped)];
    
    if (self)
    {
        self.path = path;
    }
    
    return self;
}

- (void) sortContent
{
    NSMutableArray *foldersArray = [[NSMutableArray alloc] init];
    NSMutableArray *filesArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.content.count; i++)
    {
        NSString *obj = [self.content objectAtIndex:i];
        
        BOOL isDirectory = NO;
        
        NSString *filePath = [self.path stringByAppendingPathComponent:obj];
        
        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (isDirectory)
        {
            [foldersArray addObject:obj];
        }
        else
        {
            [filesArray addObject:obj];
        }
    }
    
    NSLog(@"folders - %@, %ld", foldersArray, foldersArray.count );
    NSLog(@"files - %@, %ld", filesArray, filesArray.count );
    
    [filesArray sortUsingComparator:^NSComparisonResult(NSString  *obj1, NSString *obj2) {
        NSComparisonResult result;
        
        result = [obj1 compare:obj2];
        
        return result;
    }];
    
    [foldersArray sortUsingComparator:^NSComparisonResult(NSString  *obj1, NSString *obj2) {
        NSComparisonResult result;
        
        result = [obj1 compare:obj2];
        
        return result;
    }];
    
    NSMutableArray *arrayWithoutHiddenFiles = [NSMutableArray array];
    
    for (NSString *obj in foldersArray)
    {
        if (![obj hasPrefix:@"."])
        {
            [arrayWithoutHiddenFiles addObject:obj];
        }
    }
    
    for (NSString *obj in filesArray)
    {
        if (![obj hasPrefix:@"."])
        {
            [arrayWithoutHiddenFiles addObject:obj];
        }
    }
    
    self.content = arrayWithoutHiddenFiles;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.foldersCount = 0;
    
    if (!self.path)
    {
        self.path = @"Users/alex/Downloads";
    }

    NSError *error = nil;
    
    self.content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];

    [self sortContent];
    
    
    if (error)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASAddFolderCell" bundle:nil]
         forCellReuseIdentifier:@"ASAddFolderCell"];
    

}

- (void) viewWillAppear:(BOOL)animated
{
    if ([self.navigationController.viewControllers count] > 1)
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back to root"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backToRootAction:)];
        
        self.navigationItem.rightBarButtonItem = item;
    }
    
    self.navigationItem.title = [self.path lastPathComponent];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.content count] + 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *folderCell = @"FolderCell";
    NSString *fileCell = @"FileCell";    
    
    if (indexPath.row == 0)
    {
        ASAddFolderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASAddFolderCell"];
        return cell;
    }
    else
    {
        NSString *fileName = [self.content objectAtIndex:indexPath.row - 1];
    
    if ([self isDirectoryAtIndexPath:indexPath])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderCell];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:folderCell];
        }
        
        unsigned long long folderSize = [self getFileSizeAtIndexPath:indexPath];
        
        NSString *sizeString = [self fileSizeFormatter:folderSize];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", fileName, sizeString];
        
    
        
        return cell;
    }
    
    else
    {

        NSString *path = [self.path stringByAppendingPathComponent:fileName];
        
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
         FileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileCell];
        
        if (!cell)
        {
            cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fileCell];
        }
        
        cell.fileName.text = fileName;
        cell.fileSize.text = [NSString stringWithFormat:@"%@", [self fileSizeFormatter:[fileAttributes fileSize]]];
        cell.modifiedDate.text = [NSString stringWithFormat:@"%@", [fileAttributes fileModificationDate]];
        
        return cell;
    }
    }

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        NSString *folderName = [NSString stringWithFormat:@"Folder number %ld", self.foldersCount];
        NSString *folderPath = [self.path stringByAppendingPathComponent:folderName];
        
        self.foldersCount++;
        
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        
        self.content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
        [self sortContent];
        
        [self.tableView reloadData];
        
    }
    else
    {
        if ([self isDirectoryAtIndexPath:indexPath])
        {
            NSString *fileName = [self.content objectAtIndex:indexPath.row - 1];
            NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
            
            ASDirectoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDirectoryController"];
            controller.path = filePath;
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    }

}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 50;
    }
    else
    {
        if ([self isDirectoryAtIndexPath:indexPath])
        {
            return 80.f;
        }
        else
        {
            return 90.f;
        }
    }

}

#pragma mark - Custom Methods

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath *) path
{
    BOOL isDirectory = NO;
    
    NSString *fileName = [self.content objectAtIndex:path.row - 1];
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

- (NSString *) fileSizeFormatter:(unsigned long long) size
{
    static NSString *units[] = {@"B", @"KB", @"MB", @"GB", @"TB"};
    static int unitsCount = 5;
    
    int index = 0;
    double fileSize = (double)size;
    
    while (fileSize > 1024 && index < unitsCount) {
        fileSize = fileSize / 1024;
        index++;
    }
    
    return [NSString stringWithFormat:@"%.2f %@",fileSize, units[index]];
    
}

#pragma mark - Actions

- (IBAction)infoAction:(UIButton *)sender {
    
    UITableViewCell *cell = [sender superCell];
    
    if (cell)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"%ld %ld", indexPath.row, indexPath.section);
        
        NSString *stringForAlert = [NSString stringWithFormat:@"Section %ld, row %ld", indexPath.section, indexPath.row];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Yahoo!!"
                                                                     message:nil
                                                              preferredStyle:UIAlertControllerStyleAlert];
                                 
        UIAlertAction *yahoo = [UIAlertAction actionWithTitle:stringForAlert style:UIAlertActionStyleDefault handler:nil];
        
        [ac addAction:yahoo];
        
        [self.navigationController presentViewController:ac animated:YES completion:nil];
        
        
    }
}

- (void) backToRootAction:(UIBarButtonItem *) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)removeFileAction:(UIButton *)sender
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil
                                                                message:@"You are going to remove this file. Proceed?"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITableViewCell *cell = [sender superCell];
        
        NSIndexPath *path =[self.tableView indexPathForCell:cell];
        
        NSString *fileName = [self.content objectAtIndex:path.row - 1];
        
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        
        NSLog(@"%@", filePath);
        
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        
        self.content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
        [self sortContent];
        
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [ac dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [ac addAction:cancel];
    [ac addAction:ok];
    
    
    [self presentViewController:ac animated:YES completion:nil];

}

- (unsigned long long) getFileSizeAtIndexPath:(NSIndexPath *) path
{
    NSString *folderName = [self.content objectAtIndex:path.row -1];
    NSString *folderPath = [self.path stringByAppendingPathComponent:folderName];
    
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath
                                                                              error:nil];
    
    NSLog(@"%@", filesArray);
    
//    for (NSString *obj in filesArray)
//    {
//        if (self isDirectoryAtIndexPath:<#(NSIndexPath *)#>)
//    }
    
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    
    unsigned long long fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject])
    {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName]
                                                                                        error:nil];
        
        fileSize += [fileDictionary fileSize];
    }
    NSLog(@"%lld", fileSize);
    return fileSize;

}


@end
