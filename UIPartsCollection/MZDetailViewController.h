//
//  MZDetailViewController.h
//  UIPartsCollection
//
//  Created by Keisuke Matsuo on 12/01/12.
//  Copyright (c) 2012 Keisuke Matsuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationView.h"

@interface MZDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) InformationView *infoView;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
