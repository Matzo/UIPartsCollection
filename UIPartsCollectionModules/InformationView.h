//
//  InformationView.h
//  UIPartsCollection
//
//  Created by Keisuke Matsuo on 12/01/12.
//  Copyright (c) 2012 Keisuke Matsuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationView : UIView
@property (nonatomic, retain) UIColor *tintColor;
@property (nonatomic, assign) CGPoint pointer;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, assign) BOOL hideWhenTouch;
- (void)hideViewWithAnimateDuration:(CGFloat)duration;
@end
