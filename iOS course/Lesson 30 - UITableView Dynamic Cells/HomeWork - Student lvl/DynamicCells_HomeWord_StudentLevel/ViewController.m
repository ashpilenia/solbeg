//
//  ViewController.m
//  DynamicCells_HomeWord_StudentLevel
//
//  Created by Alex on 10/25/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASObject.h"

/*
 Студент.
 
 5. Теперь создайте класс, который содержит цвет и нейм.
 6. В viewDidLoad сгенерируйте 1000 объектов такого класса по принципу из ученика
 7. Положите их в массив и отобразите в таблице
 8. В этом случае когда вы будете листать назад вы увидете те же ячейки, что там и были, а не новые рандомные
 
 */

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *objArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.objArray = [NSMutableArray array];
    
    for (int i = 0; i < 1000; i++) {
        ASObject *obj = [[ASObject alloc] init];
        [self.objArray addObject:obj];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"str";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ASObject *obj = [self.objArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj.name;
    cell.backgroundColor = obj.color;
    
    return cell;
   
}





@end
