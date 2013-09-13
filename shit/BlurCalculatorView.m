//
//  CalcPadView.m
//  frostycalc
//
//  Created by Mogura on 8/30/13.
//  Copyright (c) 2013 dravvo. All rights reserved.
//

#import "BlurCalculatorView.h"
#import "CalcButton.h"

@interface BlurCalculatorView ()

@end

@implementation BlurCalculatorView

-(void)setFillAlpha:(CGFloat)fillAlpha
{
    _fillAlpha = fillAlpha;
    NSLog(@"calculator alpha: %.1f", fillAlpha);
    [self setNeedsDisplay];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _fillAlpha = 0.5;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[CalcButton class]])
        {
            CalcButton *button = (CalcButton *)view;
            
            UIBezierPath *cutoutPath = [UIBezierPath bezierPathWithRoundedRect:button.frame
                                                                  cornerRadius:[button.cornerRadius floatValue]];
            [path appendPath:cutoutPath];
        }
        else // result view
        {
            [path appendPath:[UIBezierPath bezierPathWithRect:view.frame]];
        }
    }
    
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGFloat white = _isBlack ? 0.0 : 1.0;
    CGContextSetFillColorWithColor(gc, [UIColor colorWithWhite:white alpha:_fillAlpha].CGColor);
    CGContextAddPath(gc, path.CGPath);
    CGContextEOFillPath(gc);
    UIGraphicsEndImageContext();
}

@end
