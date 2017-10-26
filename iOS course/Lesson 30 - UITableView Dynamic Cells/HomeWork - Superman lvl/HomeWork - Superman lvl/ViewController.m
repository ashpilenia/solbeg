//
//  ViewController.m
//  HomeWork - Superman lvl
//
//  Created by Alex on 10/26/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASStudent.h"
#import "ASColorObject.h"

/*
 
 Супермен.
 
 14. Средний бал для студентов ставьте рандомно от 2 до 5
 15. После того, как вы сгенерировали 30 студентов вам надо их разбить на группы:
 отличники, хорошисты, троечники и двоечники
 16. Каждая группа это секция с соответствующим названием.
 17. Студенты внутри своих групп должны быть в алфовитном порядке
 18. Отобразите группы студентов с их оченками в таблице.
 
 Mission Impossible!
 
 19. Добавьте к супермену еще одну секцию, в которой вы отобразите 10 моделей цветов из задания Студент.
 20. Помните, это должно быть 2 разных типа ячеек Value1 для студентов и Default для цветов.
 
 */


@interface ViewController ()

@property (nonatomic, strong) NSArray *namesArray;
@property (nonatomic, strong) NSArray *lastNamesArray;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *dvoechniki;
@property (nonatomic, strong) NSMutableArray *troechniki;
@property (nonatomic, strong) NSMutableArray *horoshisti;
@property (nonatomic, strong) NSMutableArray *otlichniki;

@property (nonatomic, strong) NSMutableArray *colorObjArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dvoechniki = [NSMutableArray array];
    self.troechniki = [NSMutableArray array];
    self.horoshisti = [NSMutableArray array];
    self.otlichniki = [NSMutableArray array];
    
    self.colorObjArray = [NSMutableArray array];
    
    
    NSString *str1 = @"Albert";
    NSString *str2 = @"Eric";
    NSString *str3 = @"Mortal";
    NSString *str4 = @"John";
    NSString *str5 = @"Alex";
    NSString *str6 = @"Limb";
    NSString *str7 = @"Clown";
    NSString *str8 = @"Gus";
    NSString *str9 = @"Jack";
    NSString *str10 = @"Peter";
    
    self.namesArray = [[NSArray alloc] initWithObjects:str1, str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, nil];
    
    NSString *str11 = @"Smoth";
    NSString *str20 = @"Smith";
    NSString *str30 = @"Merkel";
    NSString *str40 = @"White";
    NSString *str50 = @"Black";
    NSString *str60 = @"Green";
    NSString *str70 = @"Blue";
    NSString *str80 = @"Petrov";
    NSString *str90 = @"Sosnov";
    NSString *str100 = @"Hrenov";
    
    self.lastNamesArray = [[NSArray alloc] initWithObjects: str11, str20, str30, str40, str50, str60, str70, str80, str90, str100, nil];
    
    NSString *title1 = @"Dvoechniki";
    NSString *title2 = @"Troechniki";
    NSString *title3 = @"Horoshisti";
    NSString *title4 = @"Otlichniki";
    
    self.titles = [NSArray arrayWithObjects:title1, title2, title3, title4, nil];
    
    for (int i = 0; i < 30; i++)
    {
        ASStudent *stud = [[ASStudent alloc] init];
        NSInteger index = arc4random_uniform(9);
        NSString *name = [self.namesArray objectAtIndex:index];
        
        stud.name = [NSString stringWithFormat:@"%@", name];
        
        NSInteger index2 = arc4random_uniform(9);
        NSString *lastName = [self.lastNamesArray objectAtIndex:index2];
        
        stud.lastName = [NSString stringWithFormat:@"%@", lastName];
        
        stud.averageScore = arc4random_uniform(4) + 2;
        
        if (stud.averageScore == 2)
        {
            [self.dvoechniki addObject:stud];
        }
        if (stud.averageScore == 3)
        {
            [self.troechniki addObject:stud];
        }
        if (stud.averageScore == 4)
        {
            [self.horoshisti addObject:stud];
        }
        if (stud.averageScore == 5)
        {
            [self.otlichniki addObject:stud];
        }
       
    }
    
    [self sortArray:self.dvoechniki];
    [self sortArray:self.troechniki];
    [self sortArray:self.horoshisti];
    [self sortArray:self.otlichniki];
    
    for (int i = 0; i < 10; i++)
    {
        ASColorObject *obj = [[ASColorObject alloc] init];
        [self.colorObjArray addObject:obj];
    }

    
    
}

- (NSComparisonResult) sortArray:(NSMutableArray *) array
{
    NSComparisonResult __block result;
    
    [array sortUsingComparator:^NSComparisonResult(ASStudent *obj1, ASStudent *obj2) {
        
        NSComparisonResult result2 = NSOrderedAscending;
        
        if ([obj1.lastName isEqualToString:obj2.lastName])
        {
            result2 = [obj1.name compare:obj2.name];
        }
        else
        {
            result2 = [obj1.lastName compare:obj2.lastName];
        }
        
        result = result2;
    
        return result;
    }];
    
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ([self.titles count] + 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    switch (section) {
        case 0:
            number = [self.dvoechniki count];
            break;
            
            case 1:
            number = [self.troechniki count];
            break;
            
            case 2:
            number = [self.horoshisti count];
            break;
            
            case 3:
            number = [self.otlichniki count];
            break;
            
            case 4:
            number = 10;
        
    }
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StringID";
    static NSString *colorID = @"color";
    
    
    
    UITableViewCell *cell;
    if (indexPath.section <= 3){
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSArray *array;
    switch (indexPath.section) {
        case 0:
            array = self.dvoechniki;
            break;
            
        case 1:
            array = self.troechniki;
            break;
            
        case 2:
            array = self.horoshisti;
            break;
            
        case 3:
            array = self.otlichniki;
            break;

    }
    
    ASStudent *stud = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", stud.lastName, stud.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", stud.averageScore];
    
    
    
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:colorID];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:colorID];
        }
        
        ASColorObject *obj = [self.colorObjArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = obj.name;
        cell.backgroundColor = obj.color;
        
        
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleName;
    
    if (section <=3) {
    
    titleName = [NSString stringWithFormat:@"%@", [self.titles objectAtIndex:section]];
    }
    else
    {
        titleName = @"Colors";
    }
    
    return titleName;
}





@end
