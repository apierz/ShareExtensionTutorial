//
//  ConfigMenuTableViewController.h
//  ShareExtensionTutorial
//
//  Created by Andy on 9/30/14.
//  Copyright (c) 2014 Andy Pierz. All rights reserved.
//

#import <UIKit/UIKit.h>


//Delegate method for passing the user's choice back to the main share extension view
@protocol ConfigMenuTableViewControllerDelegate <NSObject>

-(void)didSelectOptionAtIndexPath:(NSIndexPath * )indexPath;

@end

@interface ConfigMenuTableViewController : UITableViewController


@property CGSize size;
@property (strong, nonatomic) NSMutableArray * OptionNames;
@property (strong, nonatomic) id <ConfigMenuTableViewControllerDelegate> delegate;

@end
