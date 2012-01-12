//
//  MZMasterViewController.h
//  UIPartsCollection
//
//  Created by Keisuke Matsuo on 12/01/12.
//  Copyright (c) 2012年 Keisuke Matsuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZDetailViewController;

@interface MZMasterViewController : UITableViewController

@property (strong, nonatomic) MZDetailViewController *detailViewController;

@end
