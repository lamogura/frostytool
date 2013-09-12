//
//  ViewController.h
//  shit
//
//  Created by Justin on 9/12/13.
//  Copyright (c) 2013 studystream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcButton.h"
#import "BlurCalculatorView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *overlayAlpha;
@property (weak, nonatomic) IBOutlet UISlider *buttonSelectedAlpha;
@property (weak, nonatomic) IBOutlet UISlider *labelAlpha;

@property (weak, nonatomic) IBOutlet UISlider *whiteSlider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet UISlider *blurSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet CalcButton *calcButton;
@property (weak, nonatomic) IBOutlet BlurCalculatorView *calcView;

@end
