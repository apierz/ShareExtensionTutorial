//
//  ShareViewController.m
//  BasicShareExtension
//
//  Created by Andy on 9/30/14.
//  Copyright (c) 2014 Andy Pierz. All rights reserved.
//

#import "ShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ShareViewController ()
@property  SLComposeSheetConfigurationItem * item;
@property (strong, nonatomic) NSArray * array;
@property (strong, nonatomic) NSMutableArray * thingsToAdd;
@property (strong, nonatomic) NSUserDefaults * mySharedDefaults;

@end

@implementation ShareViewController

-(void)viewDidLoad {
    NSLog(@"view did load");
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear ani");
}


#pragma mark - Config Table Delegate Methods
-(void)didSelectOptionAtIndexPath:(NSIndexPath *)indexPath {
    //sets the item's "value" to the option the user selected and pops the config table menu
    
    self.item.value = self.array[indexPath.row];
    [self popConfigurationViewController];
    
}


- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    
    //This loads the data into the shared NSUserDefaults, make sure you set up your app group properply and change
    //the suitename!
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.yourname.yourappgroup"];
    
    //stores the user text and the selected option in an NSDictionary
    NSDictionary * objectToAdd = [[NSDictionary alloc]initWithObjectsAndKeys:self.contentText, @"INFO", self.item.value, @"WHICH_OPTION", nil];
    
    //
    //examples of using the share items
    //
    
    //***URL***
    NSExtensionItem * exItem = self.extensionContext.inputItems[0];
    NSItemProvider * itemProvider = exItem.attachments[0];
    
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        NSLog(@"INSIDE IF");
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler: ^(NSURL *url, NSError *error) {
            
            NSURL * myUrl = url;
            
            //Do Something Interesting with the URL
            
            NSLog(@"The URL is: %@", myUrl.absoluteString);
            
            
            
            //Save to defaults
            if (![mySharedDefaults objectForKey:@"THINGS_TO_ADD"]) {
                self.thingsToAdd = [[NSMutableArray alloc]init];
            }
            
            else {
                self.thingsToAdd = [mySharedDefaults objectForKey:@"THINGS_TO_ADD"];
            }
            
            [self.thingsToAdd addObject:objectToAdd];
            
            [mySharedDefaults setObject:self.thingsToAdd forKey:@"THINGS_TO_ADD"];
            
            [mySharedDefaults synchronize];
            
            [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
            
        }];
        
    }
    
    //***Image***
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
        NSLog(@"INSIDE IF");
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler: ^(NSData * data, NSError *error) {
           
            UIImage * image = [UIImage imageWithData:data];
            
            //Do Something Interesting with the Image:
            
            NSLog(@"Width: %f  Height: %f", image.size.width, image.size.height);
            
            //Save to defaults
            if (![mySharedDefaults objectForKey:@"THINGS_TO_ADD"]) {
                self.thingsToAdd = [[NSMutableArray alloc]init];
            }
            
            else {
                self.thingsToAdd = [mySharedDefaults objectForKey:@"THINGS_TO_ADD"];
            }
            
            [self.thingsToAdd addObject:objectToAdd];
            
            [mySharedDefaults setObject:self.thingsToAdd forKey:@"THINGS_TO_ADD"];
            
            [mySharedDefaults synchronize];
            
            
            [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
            
        }];
        
    }
    

    

}

- (NSArray *)configurationItems {
    
    //Creates an instance of our config menu and sets its size to be the same as the main extension view
    ConfigMenuTableViewController * configTable = [[ConfigMenuTableViewController alloc]init];
    configTable.size = self.preferredContentSize;
    
    //calls up the shared NSUserDefaults, make sure you set up your app group properply and change
    //the suitename!
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.yourname.yourappgroup"];
    
    //stores the options from the main app in an array
    self.array = [mySharedDefaults objectForKey:@"OPTIONS"];
    
    //passes the array to our config menu
    configTable.OptionNames = [self.array mutableCopy];
    configTable.delegate = self;
    
    
    //sets the properties of our configuration item before passing it to the view controller
    self.item = [[SLComposeSheetConfigurationItem alloc]init];
    self.item.title = @"Option";
    self.item.tapHandler = ^{ NSLog(@"block hit");
        [self pushConfigurationViewController:configTable];
    };
    
    
    return @[self.item];
}

-(void)saveToDefaults {
    //stores the dictionary in an array in our shared NSUserDefalts
    if (![mySharedDefaults objectForKey:@"THINGS_TO_ADD"]) {
        self.thingsToAdd = [[NSMutableArray alloc]init];
    }
    
    else {
        self.thingsToAdd = [mySharedDefaults objectForKey:@"THINGS_TO_ADD"];
    }
    
    [self.thingsToAdd addObject:objectToAdd];
    
    [mySharedDefaults setObject:self.thingsToAdd forKey:@"THINGS_TO_ADD"];
    
    [mySharedDefaults synchronize];
    
}

@end
