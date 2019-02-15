//
//  ViewController.m
//  WebView HomeWork
//
//  Created by Alex on 2/12/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASWebViewController.h"

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSURL *> *internalURLs;
@property (nonatomic, strong) NSArray<NSURL *> *externalURLs;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WebView App";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    NSArray *fileNamesArray = @[@"01.pdf", @"02.pdf", @"03.pdf"];
    self.internalURLs = [self getLocalURLsForFiles:fileNamesArray];
    
    NSURL *google = [NSURL URLWithString:@"https://www.google.com/"];
    NSURL *yandex = [NSURL URLWithString:@"https://yandex.by/"];
    NSURL *yahoo = [NSURL URLWithString:@"https://www.yahoo.com/"];
    
    self.externalURLs = @[google, yandex, yahoo];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger retNumber = 0;
    if (section) {
        retNumber = self.internalURLs.count;
    } else {
        retNumber = self.externalURLs.count;
    }
    
    return retNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    
    NSArray *urlsArray = indexPath.section ? self.internalURLs : self.externalURLs;
    NSURL *url = [urlsArray objectAtIndex:indexPath.row];
    
    NSString *text;
    if (url.lastPathComponent.length > 1) {
        text = url.lastPathComponent;
    } else {
        text = [url absoluteString];
    }
    
    cell.textLabel.text = text;
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return section ? @"PDF files" : @"Sites:";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASWebViewController *controller = [self.storyboard  instantiateViewControllerWithIdentifier:@"ASWebViewController"];
    
    NSArray *urlsArray = indexPath.section ? self.internalURLs : self.externalURLs;
    controller.passedUrl = [urlsArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private Methods

- (NSArray<NSURL *> *)getLocalURLsForFiles:(NSArray<NSString *> *)namesArray {
    
    NSMutableArray *retVal = [NSMutableArray array];
    for (NSString *fileName in namesArray) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        [retVal addObject:fileUrl];
    }
    return retVal;
}


@end
