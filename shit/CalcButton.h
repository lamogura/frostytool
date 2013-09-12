//
//  CalcButton.h
//  frostycalc
//
//  Created by Mogura on 8/30/13.
//  Copyright (c) 2013 dravvo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalcButton : UIButton

// could be anything number or function or whatevs
@property (nonatomic, strong) UILabel *calculatorMinion;
@property (nonatomic, assign) CGFloat fillAlpha;
@property (nonatomic, assign) CGFloat selectedFillAlpha;
@property (nonatomic, assign) CGFloat labelTextAlpha;
@property (nonatomic, strong) NSNumber *cornerRadius;

@end
