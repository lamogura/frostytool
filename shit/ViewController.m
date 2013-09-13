//
//  ViewController.m
//  shit
//
//  Created by Justin on 9/12/13.
//  Copyright (c) 2013 studystream. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"

@interface ViewController ()
@property (nonatomic, strong) UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _image = [UIImage imageNamed:@"default"];
    self.calcView.isBlack = self.isBlackOnWhite;
    self.calcButton.isBlack = self.isBlackOnWhite;
    
    [self updateImage:nil];
    [self updateOverlay:nil];
}

-(IBAction)alert:(id)sender
{
    NSString *msg = [NSString stringWithFormat:
        @"img white: %.1f\nimg alpha: %.1f\nblur rad: %.1f\nsatur: %.1f\n\noverlay: %.1f\ntapped: %.1f\nlabel: %.1f",
                     self.whiteSlider.value,
                     self.alphaSlider.value,
                     self.blurSlider.value,
                     self.saturationSlider.value,
                     self.overlayAlpha.value,
                     self.buttonSelectedAlpha.value,
                     self.labelAlpha.value];
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"details"
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:@"ok"
                                         otherButtonTitles:nil];
    [view show];
}

- (IBAction)updateImage:(id)sender
{
    
    CGFloat white = _isBlackOnWhite ? self.whiteSlider.value : 1.0 - self.whiteSlider.value;
    self.imageView.image = [_image applyEffectWithWhite:white
                                                  alpha:self.alphaSlider.value
                                             blurRadius:self.blurSlider.value
                                        saturationDelta:self.saturationSlider.value];

}
- (IBAction)updateOverlay:(id)sender
{
    NSLog(@"%.1f %.1f",
          self.overlayAlpha.value,
          self.buttonSelectedAlpha.value);
    
    self.calcView.fillAlpha = self.overlayAlpha.value;
    self.calcButton.fillAlpha = self.overlayAlpha.value;
    self.calcButton.selectedFillAlpha = self.buttonSelectedAlpha.value;
    self.calcButton.labelTextAlpha = self.labelAlpha.value;
}

@end
