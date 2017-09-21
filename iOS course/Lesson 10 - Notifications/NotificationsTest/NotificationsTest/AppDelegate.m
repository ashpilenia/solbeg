//
//  AppDelegate.m
//  NotificationsTest
//
//  Created by Alex on 9/19/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASGovernment.h"
#import "ASDoctor.h"
#import "ASBusinessman.h"
#import "ASPensioner.h"
#import "ASAppNotification.h"

/*
 
 Ученик.
 
 1. Используя мой код создать свой проект со своими классами и понять как оно работает
 2. Добавить классы "пенсионер" и "бизнесмен"
 3. Доктор следит за изменением зарплаты, бизнесмен должен следить за изменением налогов, а пенсионер за изменением пенсий.
 4. Все классы: Доктор, Пенсионер и Бизнесмен долджны следить также и за средней ценой на товар.
 
 Умничка.
 
 5. Каждый из классов следит за инфляцией (процентный рост средней цены на товар) и оценивает свой потенциальный доход по отношению к инфляции, например размер пенсии к возможности купить продукты у пенсионера, либо новая прибыль за вычетом налогов у бизнесмена также по отношению к ценам на товар.
 
 6. Не секрет что изменение этих характеристик оказывает разное влияние на разные слои населения, поэтому пусть в зависимости от уровня покупательской способности каждый класс выдает свои перлы.
 
 Мастер.
 
 7. Подпишите классы на нотификацию ухода приложения в бекграунд, чтобы когда нажимается кнопка HOME и приложение сворачивается, каждый объект заявлял о том что он идет спать
 
 8. Тоже самое сделать для случая, когда приложение возвращается из свернутого состояния
 
 Супермен
 
 9. Создайте свой класс аналог апп делегату, только он не делегат приложения, но слушатель тех же самых нотификаций, какие методы есть у делегата. Грубо говоря у вашего класса должны быть теже методы, что и у апп делегата, но вызываться они должны путем нотификаций
 
 10. Добавьте НСЛоги в каждый метод апп делегата и своего класса
 
 11. Сворачивая и разварачивая приложение добивайтесь вызовов определенный методов делегата и тех же нотификаций и посмотрите что вызывается раньше - метод делегата или нотификация :)
 
 
 
 */

@interface AppDelegate ()

@property (nonatomic, strong) ASGovernment *government;
@property (nonatomic, strong) NSArray *objectholder;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.government = [[ASGovernment alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:ASGovernmentTaxLevelDidChangeNotification
                                               object:nil];
    
    ASDoctor *doctor1 = [[ASDoctor alloc] init];
    ASDoctor *doctor2 = [[ASDoctor alloc] init];
    ASDoctor *doctor3 = [[ASDoctor alloc] init];
    ASDoctor *doctor4 = [[ASDoctor alloc] init];
    ASDoctor *doctor5 = [[ASDoctor alloc] init];
    
    ASPensioner *pensioner = [[ASPensioner alloc] init];
    
    ASBusinessman *businessman = [[ASBusinessman alloc] init];
    
    ASAppNotification *testobject = [[ASAppNotification alloc] init];
    
    NSArray *safeArray = [NSArray arrayWithObjects:doctor1, doctor2, doctor3, doctor4, doctor5, pensioner, businessman, testobject, nil];
    self.objectholder = safeArray;
    
    
    doctor1.salary = doctor2.salary = doctor3.salary = doctor4.salary = doctor5.salary = self.government.salary;
    doctor1.averagePrice = doctor2.averagePrice = doctor3.averagePrice = doctor4.averagePrice = doctor5.averagePrice = self.government.averagePrice;
    
    
    pensioner.averagePrice = self.government.averagePrice;
    pensioner.pension = self.government.pension;
    
    businessman.averagePrice = self.government.averagePrice;
    businessman.taxLevel = self.government.taxLevel;
    
    
    self.government.taxLevel = 5.5;
    self.government.salary = 1100;
    self.government.averagePrice = 15;
    self.government.pension = 550;
    
    [self.government getInflation:10];
    
    self.government.taxLevel = 4;
    self.government.salary = 1050;
    self.government.averagePrice = 13;
    self.government.pension = 540;
    
    [self.government getInflation:15];
    

    
    return YES;
}

- (void) governmentNotification:(NSNotification *) notification
{
    NSLog(@"governmentNotification userInfo = %@", notification.userInfo);
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"APPDelegate applicationWillResignActive  method is called");
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"APPDelegate applicationDidEnterBackground  method is called");
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"APPDelegate applicationWillEnterForeground  method is called");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"APPDelegate applicationDidBecomeActive  method is called");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"APPDelegate applicationWillTerminate  method is called");
}


@end
