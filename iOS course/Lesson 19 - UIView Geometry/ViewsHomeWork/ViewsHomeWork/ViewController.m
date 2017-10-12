//
//  ViewController.m
//  ViewsHomeWork
//
//  Created by Alex on 10/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *viewsArray;

@end

@implementation ViewController

/*
 
 Ученик
 
 1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
 2. доска должна иметь столько клеток, как и настоящая шахматная
 
 Студент
 
 3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
 4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.
 
 Мастер
 
 5. При повороте устройства все черные клетки должны менять цвет :)
 6. Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
 
 Супермен
 
 8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
 9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView
 
 */



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.viewsArray = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    CGRect board;
    board.origin = CGPointMake(0, 100);
    board.size = CGSizeMake(MIN(CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds)),
                            MIN(CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds)));
    
    UIView *boardView = [[UIView alloc] initWithFrame:board];
    [boardView setBackgroundColor:[UIColor purpleColor]];
    
    
    [self.view addSubview:boardView];
    
    
    for (int x = 0; x < 8; x++)
    {
        for (int y = 0 ; y < 8; y++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x*40, y*40, 40, 40)];
            if (x%2)
            {
               if (y%2)
               {
                   [view setBackgroundColor:[UIColor whiteColor]];
               }
               else
               {
                   [view setBackgroundColor:[UIColor blackColor]];
                   [self.viewsArray addObject:view];
               }
                
            
            }
            else
            {
                if (y%2)
                {
                    [view setBackgroundColor:[UIColor blackColor]];
                    [self.viewsArray addObject:view];
                }
                else
                {
                    [view setBackgroundColor:[UIColor whiteColor]];
                }
            }
            
            [boardView addSubview:view];
        }
    }
    
    for (int x = 0; x < 8; x++) // расставляю красные шашки
        {
            for (int y = 0; y < 3; y++)
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x*40 + 7, y*40 + 7, 25, 25)];
                
                if (x%2)
                {
                    if (y%2) {}
                    
                    else
                    {
                        [view setBackgroundColor:[UIColor redColor]];
                        [boardView addSubview:view];
                    }
                }
                else
                {
                    if (y%2)
                    {
                        [view setBackgroundColor:[UIColor redColor]];
                        [boardView addSubview:view];
                    }
                    
                    else {}
                }
            }
        }
    
    
    for (int x = 0; x < 8; x++) //расставляю зеленые шашки
    {
        for (int y = 0; y < 3; y++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x*40 + 7, y*40 + 208, 25, 25)];
            
            if (x%2)
            {
                if (y%2)
                {
                    [view setBackgroundColor:[UIColor greenColor]];
                    [boardView addSubview:view];
                }
                
                else
                {
                    
                }
            }
            else
            {
                if (y%2)
                {
                   
                }
                
                else
                {
                    [view setBackgroundColor:[UIColor greenColor]];
                    [boardView addSubview:view];
                }
            }
        }
    }
    
    boardView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UIView
    

}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    for (UIView *obj in self.viewsArray)
    {
        UIColor *color = [UIColor blueColor];
        
            obj.backgroundColor = color;
    
    }
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
