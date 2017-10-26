//
//  ViewController.m
//  HomeWork - Master lvl
//
//  Created by Alex on 10/26/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASStudent.h"

/*
 
 Мастер.
 
 9. Возвращаемся к слудентам. Сгенерируйте 20-30 разных студентов.
 10. В таблице создавайте не дефаулт ячейку а Value1. В этом случае у вас появится еще одна UILabel - detailLabel.
 11. В textLabel пишите имя и фамилию студента, а в detailLabel его средний бал.
 12. Если средний бал низкий - окрашивайте имя студента в красный цвет
 13. Отсортируйте студентов в алфовитном порядке и отобразите в таблице
 
 */

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *studArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studArray = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++)
    {
        ASStudent *obj = [[ASStudent alloc] init];
        obj.name = [NSString stringWithFormat:@"student %d", i];
        obj.lastName = [NSString stringWithFormat:@"lastName %d", i];
        obj.averageScore = arc4random_uniform(9) + 1;
        
        [self.studArray addObject:obj];
        
        [self.studArray sortUsingComparator:^NSComparisonResult(ASStudent *obj1, ASStudent *obj2) {
            NSComparisonResult result = NSOrderedDescending;
            
            if ([obj1.lastName isEqualToString:obj2.lastName])
            {
                result = [obj1.name compare:obj2.name];
            }
            else
            {
                result = [obj1.lastName compare:obj2.lastName];
            }
            
            
            return result;
        }];
    }
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"stringID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    ASStudent *stud = [self.studArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", stud.name, stud.lastName];
    
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Average mark: %ld", stud.averageScore];
    [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    
    if (stud.averageScore < 5)
    {
        cell.backgroundColor = [UIColor redColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    return cell;
}





@end
