//
//  CalcButton.m
//  frostycalc
//
//  Created by Mogura on 8/30/13.
//  Copyright (c) 2013 dravvo. All rights reserved.
//

#import "CalcButton.h"

#define kFontSize 42.f

@implementation CalcButton

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.calculatorMinion = [self minionLabel];
        [self addSubview:self.calculatorMinion];
        
        if (!_cornerRadius) {
            _cornerRadius = @(self.bounds.size.height / 2.0);
        }
        
         [self setToDefaultColors];
    }
    return self;
}

#pragma mark - UI Code
-(void)setupLabelForContent
{
    UILabel *label = self.calculatorMinion;
    if (!label) return;

    // position
    CGFloat delta = 0;
    if      ([label.text isEqualToString:@"±"]) delta = -5;
    else if ([label.text isEqualToString:@"÷"]) delta = -5;
    else if ([label.text isEqualToString:@"×"]) delta = -3;
    else if ([label.text isEqualToString:@"−"]) delta = -3;
    else if ([label.text isEqualToString:@"+"]) delta = -3;
    else if ([label.text isEqualToString:@"="]) delta = -3;
    label.center = CGPointMake(label.center.x, label.center.y+delta);
    
    // font size
    CGFloat newSize = kFontSize;
    if      ([label.text isEqualToString:@"%"]) newSize = kFontSize-6;
    else if ([label.text isEqualToString:@"C"]) newSize = kFontSize-8;
    else if ([label.text isEqualToString:@"AC"]) newSize = kFontSize-8;
    else if ([label.text isEqualToString:@"÷"]) newSize = kFontSize+4;
    label.font = [label.font fontWithSize:newSize];
}

-(NSString *)accessibilityLabel
{
    return self.calculatorMinion.text;
}

-(UILabel *)minionLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor colorWithWhite:1.0 alpha:kCalcPadButtonLabelAlpha];
//    label.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    label.font = [UIFont fontWithName:@"Helvetica-Light" size:kFontSize];

    [label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    label.text = @"3";
    [self setupLabelForContent];
    
    return label;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (self.isSelected)
        self.calculatorMinion.textColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    else
        self.calculatorMinion.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
}

-(UIImage *)highlightedStateImage
{
    return [self buttonImageWithColor:[UIColor colorWithWhite:1.0 alpha:self.selectedFillAlpha] outlineWidth:0.0];
}

-(UIImage *)normalStateImage
{
    return [self buttonImageWithColor:[UIColor colorWithWhite:0 alpha:self.fillAlpha] outlineWidth:1.6];
}

-(UIImage *)buttonImageWithColor:(UIColor *)color outlineWidth:(CGFloat)outlineWidth
{
    // inner shape
    CGRect inRect = CGRectInset(self.bounds, outlineWidth, outlineWidth);
    UIBezierPath *inPath = [UIBezierPath bezierPathWithRoundedRect:inRect
                                                      cornerRadius:[self.cornerRadius floatValue]-outlineWidth];

    // inner shape
    UIBezierPath *outPath;
    if (outlineWidth > 0.0)
    {
        CGRect outRect = self.bounds;
        outPath = [UIBezierPath bezierPathWithRoundedRect:outRect
                                             cornerRadius:[self.cornerRadius floatValue]];
    }
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.f);
    CGContextRef gc = UIGraphicsGetCurrentContext();

    if (outPath)
    {
        CGContextAddPath(gc, inPath.CGPath);
        CGContextAddPath(gc, outPath.CGPath);
#warning play with this color for border in unselected state
        CGContextSetFillColorWithColor(gc, [UIColor colorWithWhite:1.0
                                                             alpha:self.selectedFillAlpha].CGColor);
        
       CGContextEOFillPath(gc); // fill area outter - inner
    }
    
    // fill inner
    CGContextAddPath(gc, inPath.CGPath);
    CGContextSetFillColorWithColor(gc, color.CGColor);
    CGContextFillPath(gc);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Helpers
-(NSString *)makeCacheKeyForColor:(UIColor *)color outlineWidth:(CGFloat)width cornerRadius:(CGFloat)radius
{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    return [NSString stringWithFormat:@"%.2f%.2f%.2f%.2f%.2f%.2f%.2f%.2f%.2f%.2f",
            self.bounds.origin.x, self.bounds.origin.y,
            self.bounds.size.width, self.bounds.size.height,
            r, g, b, a,
            width, radius];
}

#pragma mark - Setters
-(void)setToDefaultColors
{
    self.tintColor = [UIColor clearColor]; // purposefully kill the tint so it wont show when selected
    // clear color which is set in storyboard so we can see the layout
    self.backgroundColor = [UIColor clearColor];
    
    _fillAlpha = 0.5;
    _selectedFillAlpha = 0.5;

    [self setImage:[self normalStateImage] forState:UIControlStateNormal];
    [self setImage:[self highlightedStateImage] forState:UIControlStateHighlighted];
    [self setImage:[self highlightedStateImage] forState:UIControlStateSelected];
    
    self.calculatorMinion.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
}

-(void)refreshButtonImages
{
    [self setImage:[self buttonImageWithColor:[UIColor colorWithWhite:0 alpha:self.fillAlpha] outlineWidth:1.6] forState:UIControlStateNormal];
    
    [self setImage:[self buttonImageWithColor:[UIColor colorWithWhite:1 alpha:self.selectedFillAlpha] outlineWidth:0] forState:UIControlStateHighlighted];
    
    [self setImage:[self buttonImageWithColor:[UIColor colorWithWhite:1 alpha:self.selectedFillAlpha] outlineWidth:0] forState:UIControlStateSelected];
}

-(void)setCornerRadius:(NSNumber *)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self refreshButtonImages];
}


-(void)setFillAlpha:(CGFloat)fillAlpha
{
    _fillAlpha = fillAlpha;
    [self refreshButtonImages];
}

-(void)setSelectedFillAlpha:(CGFloat)selectedFillAlpha {
    _selectedFillAlpha = selectedFillAlpha;
    [self refreshButtonImages];
}

-(void)setLabelTextAlpha:(CGFloat)labelTextAlpha {
    self.calculatorMinion.textColor = [UIColor colorWithWhite:1.0 alpha:labelTextAlpha];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.calculatorMinion && [keyPath isEqualToString:@"text"]) {
        [self setupLabelForContent];
    }
}

@end
