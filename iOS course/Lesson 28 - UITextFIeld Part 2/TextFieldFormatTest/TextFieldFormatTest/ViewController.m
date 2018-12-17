//
//  ViewController.m
//  TextFieldFormatTest
//
//  Created by Alex on 12/17/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - UITextFIeldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    if (components.count > 1)
    {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    /*
     +XX (XXX) XXX-XXXX number format
     */
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if (newString.length > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength)
    {
        return NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    
    NSInteger localNumberLength = MIN(localNumberMaxLength, newString.length);
    if (localNumberLength)
    {
        NSString *number = [newString substringFromIndex:newString.length - localNumberLength];
        
        [resultString appendString:number];
        if (resultString.length > 3)
        {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if (newString.length > localNumberMaxLength)
    {
        NSInteger areaCodeLength = MIN(areaCodeMaxLength, newString.length - localNumberMaxLength);
        NSRange areaRange = NSMakeRange(newString.length - localNumberLength - areaCodeLength, areaCodeLength);
        NSString *area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if (newString.length > (localNumberMaxLength + areaCodeMaxLength))
    {
        NSInteger countryCodeLength = MIN(countryCodeMaxLength, newString.length - localNumberMaxLength - areaCodeMaxLength);
        NSRange countryRange = NSMakeRange(0, countryCodeLength);
        NSString *country = [newString substringWithRange:countryRange];
        
        if (countryCodeLength == 3)
        {
            country = [NSString stringWithFormat:@"+%@ ", country];
        }
        
        [resultString insertString:country atIndex:0];
    }
    
    textField.text = resultString;
    
    return NO;
}


@end
