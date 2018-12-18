//
//  ViewController.m
//  HomeWork
//
//  Created by Alex on 12/18/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

typedef NS_ENUM(NSInteger) {
    
    passwordTextField = 4,
    ageTextField,
    phoneTextField,
    emailTextField
    
}textFieldsNames;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textFieldsCollection enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.delegate = self;
    }];
    
    [self.labelsCollection enumerateObjectsUsingBlock:^(UILabel  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = @"";
        obj.textColor = [UIColor blueColor];
        obj.textAlignment = NSTextAlignmentRight;
    }];
    

}

#pragma mark - Private Methods

- (NSString *)phoneEntryValidation:(NSString *)resultString andReplacementString:(NSString *)string  {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if (components.count > 1) {
        return @"error";
    }
    
    NSString *newString = resultString;
    
    /*
     +XX (XXX) XXX-XXXX number format
     */
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if (newString.length > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return @"error";
    }
    
    NSMutableString *retVal = [NSMutableString string];
    
    NSInteger localNumberLength = MIN(localNumberMaxLength, newString.length);
    if (localNumberLength) {
        
        NSString *number = [newString substringFromIndex:newString.length - localNumberLength];
        [retVal appendString:number];
        
        if (resultString.length > 3) {
            [retVal insertString:@"-" atIndex:3];
        }
    }
    
    if (newString.length > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN(areaCodeMaxLength, newString.length - localNumberMaxLength);
        NSRange areaRange = NSMakeRange(newString.length - localNumberLength - areaCodeLength, areaCodeLength);
        NSString *area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [retVal insertString:area atIndex:0];
    }
    
    if (newString.length > (localNumberMaxLength + areaCodeMaxLength)) {
        
        NSInteger countryCodeLength = MIN(countryCodeMaxLength, newString.length - localNumberMaxLength - areaCodeMaxLength);
        NSRange countryRange = NSMakeRange(0, countryCodeLength);
        NSString *country = [newString substringWithRange:countryRange];
        
        if (countryCodeLength == 3) {
            
            country = [NSString stringWithFormat:@"+%@ ", country];
        }
        
        [retVal insertString:country atIndex:0];
    }
    
    return retVal;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.emailTextField]) {
        
        [textField resignFirstResponder];
    } else {
        NSUInteger index = [self.textFieldsCollection indexOfObject:textField];
        [[self.textFieldsCollection objectAtIndex:index+1] becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    UILabel *label = [self.labelsCollection objectAtIndex:textField.tag-1];
    label.text = @"";
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.tag == phoneTextField) {
        resultString = [self phoneEntryValidation:resultString andReplacementString:string];
        
        if ([resultString isEqualToString:@"error"]) {
            return NO;
        }
    }
    
    if (textField.tag == emailTextField) {
        
        NSMutableCharacterSet *validCharacters = [NSMutableCharacterSet letterCharacterSet];
        [validCharacters formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
        [validCharacters addCharactersInString:@".@"];
        
        NSArray *componetns = [string componentsSeparatedByCharactersInSet:[validCharacters invertedSet]];
        if (componetns.count > 1 || ([string containsString:@"@"] && [textField.text containsString:@"@"])) {
            return NO;
        }
    }
    
    textField.text = resultString;
    UILabel *label = [self.labelsCollection objectAtIndex:textField.tag - 1];
    label.text = resultString;
    
    if (textField.tag == passwordTextField) {
        if (resultString.length > 10) {
            label.text = @"Safe";
            label.textColor = [UIColor greenColor];
        } else {
            label.text = @"Weak";
            label.textColor = [UIColor redColor];
        }
    }
    
    return NO;
}
@end
