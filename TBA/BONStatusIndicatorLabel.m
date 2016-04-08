//
//  BONStatusIndicatorLabel.m
//  BONCustomButton
//
//  Created by christopher fleisher on 4/7/16.
//  Copyright © 2016 Outlaw Capital. All rights reserved.
//

#import "BONStatusIndicatorLabel.h"
#import "Common.h"

#define HUE 0.75f
#define SATURATION 0.75f
#define BRIGHTNESS_BASE  1.0f
#define BRIGHTNESS_END 0.1f
#define ALPHA_BASE 1.0f
#define OUTER_MARGIN 20.0f
#define RADIUS 2.0f

@implementation BONStatusIndicatorLabel

- (void)drawRect:(CGRect)rect {
    // define base colors
    CGColorRef grayColor = [UIColor grayColor].CGColor;
    CGColorRef greenColor = [UIColor greenColor].CGColor;
    
    // define base paths
    CGRect outerRect = CGRectInset(self.bounds, OUTER_MARGIN, OUTER_MARGIN);
    CGMutablePathRef topPath = createPathForRect(outerRect, 0.0,1.0-self.tapLevel);
    CGMutablePathRef bottomPath = createPathForRect(outerRect,1.0-self.tapLevel, 1.0);
    
    // build label
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, grayColor);
    CGContextAddPath(context, topPath);
    CGContextFillPath(context);

    CGContextSetFillColorWithColor(context, greenColor);
    CGContextAddPath(context, bottomPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
}

@end
