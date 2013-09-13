//
//  BlackWhiteVC.m
//  shit
//
//  Created by Pyrus on 9/13/13.
//  Copyright (c) 2013 studystream. All rights reserved.
//

#import "BlackWhiteVC.h"
#import "ViewController.h"

@implementation BlackWhiteVC

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *vc = (ViewController *)[segue destinationViewController];
    vc.isBlackOnWhite = [segue.identifier isEqualToString:@"BWSegue"];
}

@end
