//
//  BONButton.m
//  BONCustomButton
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 Outlaw Capital. All rights reserved.
//

#import "BONButton.h"
#import "Common.h"

@interface BONButton ()
@property (nonatomic,assign)CGColorRef blackColor;
@property (nonatomic,assign)CGColorRef outerTop;
@property (nonatomic,assign)CGColorRef outerBottom;
@property (nonatomic,assign)CGColorRef innerStroke;
@property (nonatomic,assign)CGColorRef innerTop;
@property (nonatomic,assign)CGColorRef innerBottom;
@property (nonatomic,assign)CGColorRef shadowColor;
@property (nonatomic,assign)CGContextRef context;

@end

@implementation BONButton

#define OUTER_MARGIN 5.0f
#define INNER_MARGIN 1.0f
#define RADIUS 50.0f
#define HUE 0.75f
#define SATURATION 0.75f
#define BRIGHTNESS_BASE  1.0f
#define BRIGHTNESS_END 0.1f
#define ALPHA_BASE 1.0f

- (void)drawRect:(CGRect)rect {
    // define base colors
    CGColorRef blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;
    CGColorRef outerTop = [UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS_BASE alpha:ALPHA_BASE].CGColor;
    CGColorRef outerBottom = [UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS_END alpha:ALPHA_BASE].CGColor;
    CGColorRef innerTop = [UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS_BASE alpha:ALPHA_BASE].CGColor;
    CGColorRef innerBottom = [UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS_END alpha:ALPHA_BASE].CGColor;
    
    // define base paths
    CGRect outerRect = CGRectInset(self.bounds, OUTER_MARGIN, OUTER_MARGIN);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, RADIUS);
    
    CGRect innerRect = CGRectInset(outerRect, INNER_MARGIN, INNER_MARGIN);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, RADIUS);
    
    // build button
    self.context = UIGraphicsGetCurrentContext();
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(self.context);
        CGContextSetFillColorWithColor(self.context, outerTop);
        CGContextSetShadowWithColor(self.context, CGSizeMake(0, 3), 5.0, shadowColor);
        CGContextAddPath(self.context, outerPath);
        CGContextFillPath(self.context);
        CGContextRestoreGState(self.context);
    }
    
    CGContextSaveGState(self.context);
    CGContextAddPath(self.context, outerPath);
    CGContextClip(self.context);
    drawGlossAndGradient(self.context, outerRect, outerTop, outerBottom);
    CGContextRestoreGState(self.context);
    
    CGContextSaveGState(self.context);
    CGContextAddPath(self.context, innerPath);
    CGContextClip(self.context);
    drawGlossAndGradient(self.context, innerRect, innerTop, innerBottom);
    CGContextRestoreGState(self.context);
    
    if (self.state == UIControlStateHighlighted){
        CGContextSaveGState(self.context);
        CGContextAddPath(self.context, innerPath);
        CGContextClip(self.context);
        drawRadialGradient(self.context,innerRect,innerTop,innerBottom);
        CGContextRestoreGState(self.context);
    }
    
    CGContextSaveGState(self.context);
    CGContextSetLineWidth(self.context, 2.0);
    CGContextSetStrokeColorWithColor(self.context, blackColor);
    CGContextAddPath(self.context, outerPath);
    CGContextStrokePath(self.context);
    CGContextRestoreGState(self.context);
    
}

#pragma mark - Setters

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

@end
