//
//  ASWallController.m
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "ASWallCell.h"

@interface ASWallController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *testArray;

@end

@implementation ASWallController

- (instancetype)initWithUser:(ASUser *)user {
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    if (self) {
        self.user = user;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.testArray = @[@"Small string", @"Looooooooooooooooooooonger texttttttttttttt", @"Real Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong text"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASWallCell class]) bundle:nil]
         forCellReuseIdentifier:[ASWallCell reuseIdentifier]];
    
    [self loadWall];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASWallCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASWallCell reuseIdentifier] forIndexPath:indexPath];
    cell.mainTextLabel.backgroundColor = [UIColor redColor];
    cell.mainTextLabel.textColor = [UIColor greenColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
    switch (indexPath.row) {
        case 0:
        {
            cell.mainTextLabel.text = @"Small string";
            
            cell.textHeightConstraint.constant = [self mesureTextHeight:cell.mainTextLabel.text];
            
        }
            break;
            
        case 1:
        {
            cell.mainTextLabel.text = @"Looooooooooooooooooooonger texttttttttttttt";
            
            cell.textHeightConstraint.constant = [self mesureTextHeight:cell.mainTextLabel.text];
        }
            break;
            
        case 2:
        {
            cell.mainTextLabel.text = @"Real Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong text";
            
            cell.textHeightConstraint.constant = [self mesureTextHeight:cell.mainTextLabel.text];
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self mesureTextHeight:[self.testArray objectAtIndex:indexPath.row]] + 15.f;
}

#pragma mark - Private Methods

- (CGFloat)mesureTextHeight:(NSString *)text {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 10.f, CGFLOAT_MAX)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:attributes
                                                        context:nil];
    
    return rect.size.height;
    
}

#pragma mark - API

- (void)loadWall {
    
    [[ASServerManager sharedManager] loadWall:self.user.identifier
                                    onSuccess:^(NSArray *parsedObjects) {
        
    }
                                    onFailure:^(NSError *error, NSInteger code) {
        
                                    }];
    
}

@end
