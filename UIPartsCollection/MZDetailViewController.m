//
//  MZDetailViewController.m
//  UIPartsCollection
//
//  Created by Keisuke Matsuo on 12/01/12.
//  Copyright (c) 2012 Keisuke Matsuo. All rights reserved.
//

#import "MZDetailViewController.h"

@interface MZDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MZDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize infoView = _infoView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    InformationView *infoViewUp = [[InformationView alloc] initWithFrame:CGRectMake(20.0,
                                                                                  40.0,
                                                                                  120.0,
                                                                                  120.0)];
    infoViewUp.textLabel.text = @"Tap here! You can delete this!";
    infoViewUp.pointer = CGPointMake(infoViewUp.frame.origin.x + 20.0,
                                   infoViewUp.frame.origin.y - 20.0);

    [self.view addSubview:infoViewUp];
    
    
    InformationView *infoViewDown = [[InformationView alloc] initWithFrame:CGRectMake(180.0,
                                                                                  40.0,
                                                                                  120.0,
                                                                                  120.0)];
    infoViewDown.textLabel.text = @"Tap here! You can delete this!";
    infoViewDown.tintColor = [UIColor blueColor];
    infoViewDown.pointer = CGPointMake(infoViewDown.frame.origin.x + 20.0,
                                       infoViewDown.frame.origin.y + infoViewDown.frame.size.height + 20.0);
    
    [self.view addSubview:infoViewDown];

    InformationView *infoViewLeft = [[InformationView alloc] initWithFrame:CGRectMake(20.0,
                                                                                  220.0,
                                                                                  120.0,
                                                                                  120.0)];
    infoViewLeft.textLabel.text = @"Tap here! You can delete this!";
    infoViewLeft.pointer = CGPointMake(infoViewLeft.frame.origin.x - 20.0,
                                       infoViewLeft.frame.origin.y + 20.0);
    
    infoViewLeft.tintColor = [UIColor redColor];
    [self.view addSubview:infoViewLeft];

    InformationView *infoViewRight = [[InformationView alloc] initWithFrame:CGRectMake(180.0,
                                                                                  220.0,
                                                                                  120.0,
                                                                                  120.0)];
    infoViewRight.textLabel.text = @"Tap here! But you can't delete this!";
    infoViewRight.textLabel.textColor = [UIColor blackColor];
    infoViewRight.hideWhenTouch = NO;
    infoViewRight.tintColor = [UIColor greenColor];
    infoViewRight.pointer = CGPointMake(infoViewRight.frame.origin.x + infoViewRight.frame.size.width + 20.0,
                                        infoViewRight.frame.origin.y + 20.0);
    
    [self.view addSubview:infoViewRight];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
