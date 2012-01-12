//
//  InformationView.m
//  UIPartsCollection
//
//  Created by Keisuke Matsuo on 12/01/12.
//  Copyright (c) 2012 Keisuke Matsuo. All rights reserved.
//

#import "InformationView.h"
#import <QuartzCore/QuartzCore.h>


enum kInformationViewPointerPosition {
    INFORMATION_VIEW_POINTER_POSITION_UP_DOWN = 0,
    INFORMATION_VIEW_POINTER_POSITION_LEFT_RIGHT
};

@interface InformationPointerView : UIView
@property (nonatomic, assign) enum kInformationViewPointerPosition pointerPosition;
@property (nonatomic, retain) UIColor *tintColor;
@end

@interface InformationView()
@property (nonatomic, retain) InformationPointerView *pointerView;
@property (nonatomic, assign) enum kInformationViewPointerPosition pointerPosition;
- (void)makePointerView;
@end

@implementation InformationView
@synthesize tintColor;
@synthesize pointer;
@synthesize cornerRadius;
@synthesize textLabel;
@synthesize hideWhenTouch;
@synthesize pointerPosition;
@synthesize pointerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.clipsToBounds = NO;
        cornerRadius = 10.0;
        hideWhenTouch = YES;
        pointerPosition = INFORMATION_VIEW_POINTER_POSITION_UP_DOWN;
        self.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 50;
        self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:textLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(self.cornerRadius,
                                      self.cornerRadius,
                                      self.frame.size.width - self.cornerRadius * 2.0,
                                      self.frame.size.height - self.cornerRadius * 2.0);
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.layer.shadowColor = [self.tintColor CGColor];
    self.layer.shadowRadius = self.cornerRadius;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    CGRect shadowFrame = CGRectMake(-self.cornerRadius*0.5,
                                    -self.cornerRadius*0.5,
                                    self.bounds.size.width + self.cornerRadius,
                                    self.bounds.size.height + self.cornerRadius);
    //        self.layer.shadowPath = CGPathCreateWithRect(shadowFrame, NULL);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowOpacity = 0.5;

    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat r = self.cornerRadius;
    
    CGContextSaveGState(c);
    CGContextSetShouldAntialias(c, true);
    
    // 角丸の描画領域を設定
    CGRect rc = CGRectMake(0, 0, w, h);
    CGContextMoveToPoint(c, CGRectGetMinX(rc), CGRectGetMaxY(rc)-r);
    CGContextAddArcToPoint(c, CGRectGetMinX(rc), CGRectGetMinY(rc), CGRectGetMidX(rc), CGRectGetMinY(rc), r);
    CGContextAddArcToPoint(c, CGRectGetMaxX(rc), CGRectGetMinY(rc), CGRectGetMaxX(rc), CGRectGetMidY(rc), r);
    CGContextAddArcToPoint(c, CGRectGetMaxX(rc), CGRectGetMaxY(rc), CGRectGetMidX(rc), CGRectGetMaxY(rc), r);
    CGContextAddArcToPoint(c, CGRectGetMinX(rc), CGRectGetMaxY(rc), CGRectGetMinX(rc), CGRectGetMidY(rc), r);
    
    CGFloat r1,g1,b1,a1;
    [self.tintColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    CGFloat components[4] = {
        r1, g1, b1, a1*0.5,
    };
    CGContextSetFillColor(c, components);
    CGContextFillPath(c);
    
    CGContextRestoreGState(c);
    
    self.pointerView.pointerPosition = self.pointerPosition;
    self.pointerView.tintColor = self.tintColor;
    [self.pointerView setNeedsDisplay];
}
#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if (hideWhenTouch) {
        [self hideViewWithAnimateDuration:0.3];
    }
}

#pragma mark - Override Methods
- (void)didMoveToSuperview {
    [self makePointerView];
}

#pragma mark - Private Methods
- (void)makePointerView {
    if (pointer.x == 0.0 && pointer.y == 0.0) {
        [self.pointerView removeFromSuperview];
        self.pointerView = nil;
        return;
    }
    
    
    CGPoint convertedPoint = [self convertPoint:pointer fromView:self.superview];
    if (0.0 <= convertedPoint.y && convertedPoint.y < self.bounds.size.height) {
        pointerPosition = INFORMATION_VIEW_POINTER_POSITION_LEFT_RIGHT;
    } else {
        pointerPosition = INFORMATION_VIEW_POINTER_POSITION_UP_DOWN;
    }
    
    CGRect pointerFrame;
    if (pointerPosition == INFORMATION_VIEW_POINTER_POSITION_UP_DOWN) {
        pointerFrame = CGRectMake(convertedPoint.x - 5.0,
                                  convertedPoint.y < 0.0 ? convertedPoint.y : self.bounds.size.height,
                                  convertedPoint.x + 5.0,
                                  convertedPoint.y < 0.0
                                  ? fabs(convertedPoint.y)
                                  : convertedPoint.y - self.bounds.size.height);
    } else {
        pointerFrame = CGRectMake(convertedPoint.x < 0.0 ? convertedPoint.x : self.bounds.size.width,
                                  convertedPoint.y - 5.0,
                                  convertedPoint.x < 0.0
                                  ? fabs(convertedPoint.x)
                                  : convertedPoint.x - self.bounds.size.width,
                                  convertedPoint.y + 5.0);
    }
    self.pointerView = [[InformationPointerView alloc] initWithFrame:pointerFrame];
    self.pointerView.backgroundColor = [UIColor clearColor];
    [self addSubview:pointerView];
}

#pragma mark - Public Methods
- (void)setPointer:(CGPoint)point {
    pointer = point;
    
    [self setNeedsDisplay];
}
- (void)setTintColor:(UIColor *)color {
    if (tintColor != color) {
        tintColor = color;
    }
    
    [self setNeedsDisplay];
}
- (void)hideViewWithAnimateDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

@implementation InformationPointerView
@synthesize pointerPosition;
@synthesize tintColor;
- (void)drawRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    if (pointerPosition == INFORMATION_VIEW_POINTER_POSITION_UP_DOWN) {
        if (0 < self.frame.origin.y) {
            CGContextMoveToPoint(c, 0.0, 0.0);
            CGContextAddLineToPoint(c, rect.size.width * 0.5, rect.size.height);
            CGContextAddLineToPoint(c, rect.size.width, 0.0);
            CGContextAddLineToPoint(c, 0.0, 0.0);
        } else {
            CGContextMoveToPoint(c, 0.0, rect.size.height);
            CGContextAddLineToPoint(c, rect.size.width * 0.5, 0.0);
            CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
            CGContextAddLineToPoint(c, 0.0, rect.size.height);
        }
    } else {
        if (0 < self.frame.origin.x) {
            CGContextMoveToPoint(c, 0.0, 0.0);
            CGContextAddLineToPoint(c, rect.size.width, rect.size.height * 0.5);
            CGContextAddLineToPoint(c, 0.0, rect.size.height);
            CGContextAddLineToPoint(c, 0.0, 0.0);
        } else {
            CGContextMoveToPoint(c, rect.size.width, 0.0);
            CGContextAddLineToPoint(c, 0.0, rect.size.height * 0.5);
            CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
            CGContextAddLineToPoint(c, rect.size.width, 0.0);
        }
    }

    
    CGFloat r1,g1,b1,a1;
    [self.tintColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    CGFloat components[4] = {
        r1, g1, b1, a1*0.5,
    };
    CGContextSetFillColor(c, components);
    CGContextFillPath(c);
}
@end
