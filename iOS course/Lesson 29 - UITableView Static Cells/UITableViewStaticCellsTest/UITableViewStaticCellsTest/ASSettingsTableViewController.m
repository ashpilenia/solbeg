//
//  ASSettingsTableViewController.m
//  UITableViewStaticCellsTest
//
//  Created by Alex on 10/22/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASSettingsTableViewController.h"

@interface ASSettingsTableViewController ()


@end

static  NSString *kSettingsLogin               = @"login";
static  NSString *kSettingsPassword            = @"password";
static  NSString *kSettingsDifficulty          = @"difficulty";
static  NSString *kSettingsShadows             = @"shadows";
static  NSString *kSettingsDetalization        = @"detalization";
static  NSString *kSettingsSound               = @"sound";
static  NSString *kSettingsMusic               = @"music";

@implementation ASSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSettings];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
                                
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notifications

- (void) notificationKeyboardWillShow:(NSNotification *) notification
{
    NSLog(@"notificationKeyboardWillShow: \n%@", notification.userInfo);
}

- (void) notificationKeyboardWillHide:(NSNotification *) notification
{
    NSLog(@"notificationKeyboardWillHide: \n%@", notification.userInfo);
}

#pragma mark - Save and Load
- (void) saveSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   
    [userDefaults setObject:self.loginField.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
    [userDefaults setInteger:self.difficultyControl.selectedSegmentIndex forKey:kSettingsDifficulty];
    [userDefaults setBool:self.shadowsSwitch.isOn forKey:kSettingsShadows];
    [userDefaults setInteger:self.detalizationControl.selectedSegmentIndex forKey:kSettingsDetalization];
    [userDefaults setDouble:self.soundSlider.value forKey:kSettingsSound];
    [userDefaults setDouble:self.musicSlider.value forKey:kSettingsMusic];
    
    [userDefaults synchronize];

}

- (void) loadSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
    self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
    self.difficultyControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsDifficulty];
    self.shadowsSwitch.on = [userDefaults boolForKey:kSettingsShadows];
    self.detalizationControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsDetalization];
    self.soundSlider.value = [userDefaults doubleForKey:kSettingsSound];
    self.musicSlider.value = [userDefaults doubleForKey:kSettingsMusic];
    
    
    
}

#pragma mark - Actions
- (IBAction)actionTextChanged:(UITextField *)sender
{
    [self saveSettings];
}

- (IBAction)actionValueChanged:(id)sender
{
    [self saveSettings];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.loginField])
    {
        [self.passwordField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
