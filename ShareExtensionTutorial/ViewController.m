//
//  ViewController.m
//  ShareExtensionTutorial
//
//  Created by Andy on 9/30/14.
//  Copyright (c) 2014 Andy Pierz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //This is the list of options that will be selectable from the share extension
    NSArray * arrayOfOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4" ];
    
    //This loads the array into the shared NSUserDefaults, make sure you set up your app group properply and change
    //the suitename!
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.yourName.yourAppGroup"];
    [mySharedDefaults setObject:arrayOfOptions forKey:@"OPTIONS"];
    [mySharedDefaults synchronize];
    
    
    //This loads the data out of the shareduser defaults that was put there by the share extension
    //and then reads it in the terminal
    NSMutableArray * thingsToAdd = [mySharedDefaults objectForKey:@"THINGS_TO_ADD"];
    
    for (NSDictionary * dictionary in thingsToAdd) {
        NSLog(@"%@", [dictionary objectForKey:@"INFO"]);
        NSLog(@"%@", [dictionary objectForKey:@"WHICH_OPTION"]);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
