//
//  AppDelegate.m
//  StringsTest
//
//  Created by Alex on 9/29/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *string = @"Hello World!";
    
    NSRange range = [string rangeOfString:@"World" options:1];
    
    if (range.location != NSNotFound)
    {
        NSLog(@"range = %@", NSStringFromRange(range));
    }
    else
    {
        NSLog(@"Not found");
    }
    The NSString class declares the programmatic interface for an object that manages immutable strings",
    
    NSString *text = @"An NSString object encodes a Unicode-compliant text string, represented as a sequence of UTF–16 code units. All lengths, character indexes, and ranges are expressed in terms of 16-bit platform-endian values, with index values starting at 0.An NSString object can be initialized from or written to a C buffer, an NSData object, or the contents of an NSURL. It can also be encoded and decoded to and from ASCII, UTF–8, UTF–16, UTF–32, or any other string encoding represented by NSStringEncoding. Note An immutable string is a text string that is defined when it is created and subsequently cannot be changed. An immutable string is implemented as an array of UTF–16 code units (in other words, a text string). To create and manage an immutable string, use the NSString class. To construct and manage a string that can be changed after it has been created, use NSMutableString. The objects you create using NSString and NSMutableString are referred to as string objects (or, when no confusion will result, merely as strings). The term C string refers to the standard char * type. Because of the nature of class clusters, string objects aren’t actual instances of the NSString or NSMutableString classes but of one of their private subclasses. Although a string object’s class is private, its interface is public, as declared by these abstract superclasses, NSString and NSMutableString. The string classes adopt the NSCopying and NSMutableCopying protocols, making it convenient to convert a string of one type to the other. A string object presents itself as a sequence of UTF–16 code units. You can determine how many UTF-16 code units a string object contains with the length method and can retrieve a specific UTF-16 code unit with the character(at:) method. These two “primitive” methods provide basic access to a string object. Most use of strings, however, is at a higher level, with the strings being treated as single entities: You compare strings against one another, search them for substrings, combine them into new strings, and so on. If you need to access string objects character by character, you must understand the Unicode character encoding, specifically issues related to composed character sequences. For details see The Unicode Standard, Version 4.0 (The Unicode Consortium, Boston: Addison-Wesley, 2003, ISBN 0-321-18578-1) and the Unicode Consortium web site: http://www.unicode.org/. See also Characters and Grapheme Clusters in String Programming Guide. Localized string comparisons are based on the Unicode Collation Algorithm, as tailored for different languages by CLDR (Common Locale Data Repository). Both are projects of the Unicode Consortium. Unicode is a registered trademark of Unicode, Inc. When creating an NSString object from a UTF-16-encoded string (or a byte stream interpreted as UTF-16), if the byte order is not otherwise specified, NSString assumes that the UTF-16 characters are big-endian, unless there is a BOM (byte-order mark), in which case the BOM dictates the byte order. When creating an NSString object from an array of unichar values, the returned string is always native-endian, since the array always contains UTF–16 code units in native byte order.";
    
    NSRange searchRange = NSMakeRange(0, [text length]);
    
    NSInteger counter = 0;
    
    while (YES) {
        NSRange range = [text rangeOfString:@"NSString" options:0 range:searchRange];
        if (range.location != NSNotFound)
        {
            NSInteger index = range.location + range.length;
            
            searchRange = NSMakeRange(index, [text length] - index);
            
            NSLog(@"%@", NSStringFromRange(range));
            
            counter++;
        }
        else
        {
            break;
        }
    }
    
    NSLog(@"Search word was found %ld times", (long)counter);
    
    text = [text stringByReplacingOccurrencesOfString:@"NSString" withString:@"TRA-LA-LA"];
    
    NSLog(@"%@", text);
    
    NSString *str1 = @"str1 ";
    NSString *str2 = @"str2";
    
    NSString *str3 = [str1 stringByAppendingString:str2];
    
    NSLog(@"%@", str3);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
