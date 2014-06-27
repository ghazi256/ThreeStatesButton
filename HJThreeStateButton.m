//
//  HJThreeStateButton.m
//  zzz-sliderManualTest
//
//  Created by hasnainjafri on 6/27/14.
//  Copyright (c) 2014 hasnainjafri. All rights reserved.
//

#import "HJThreeStateButton.h"


@implementation HJThreeStateButton
{
    UIPanGestureRecognizer *panGesture;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    [self setAutoresizesSubviews:NO];
    [self setClipsToBounds:NO];
    
    [self createView];
    
    return self;
}

-(void) createView
{
    bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    bgImgView.image=[UIImage imageNamed:@"Neutral.png"];
    [self addSubview:bgImgView];
    
    //=======================================================================================================================================//
    
    ONBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ONBtn setFrame:CGRectMake(0, 0, 19, 21)];
    [ONBtn setBackgroundColor:[UIColor clearColor]];
    [ONBtn setTitle:@"" forState:UIControlStateNormal];
    [ONBtn addTarget:self action:@selector(ONBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ONBtn];
    
    NeutralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [NeutralBtn setFrame:CGRectMake(30, 0, 19, 21)];
    [NeutralBtn setBackgroundColor:[UIColor clearColor]];
    [NeutralBtn setTitle:@"" forState:UIControlStateNormal];
    [NeutralBtn addTarget:self action:@selector(NeutralBtnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:NeutralBtn];
    
    OFFBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OFFBtn setFrame:CGRectMake(61, 0, 19, 21)];
    [OFFBtn setBackgroundColor:[UIColor clearColor]];
    [OFFBtn setTitle:@"" forState:UIControlStateNormal];
    [OFFBtn addTarget:self action:@selector(OFFBtnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:OFFBtn];
    
    //=======================================================================================================================================//
    
    thumbBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [thumbBtn setFrame:CGRectMake(26, -3, 27, 28)];
    [thumbBtn setBackgroundImage:[UIImage imageNamed:@"Selector"] forState:UIControlStateNormal];
    [thumbBtn setBackgroundImage:[UIImage imageNamed:@"Selector"] forState:UIControlStateSelected];
    [thumbBtn setBackgroundImage:[UIImage imageNamed:@"Selector"] forState:UIControlStateHighlighted];
    [self addSubview:thumbBtn];
    
    panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    [thumbBtn addGestureRecognizer:panGesture];
}

-(void) set_Enabled:(BOOL)enabled
{
    if(enabled==NO)
    {
        [ONBtn setEnabled:NO];
        [OFFBtn setEnabled:NO];
        [NeutralBtn setEnabled:NO];
    }
    else
    {
        [ONBtn setEnabled:YES];
        [OFFBtn setEnabled:YES];
        [NeutralBtn setEnabled:YES];
    }
}

-(void) setOn:(BOOL) value
{
    [self ONBtnPressed:nil];
}
-(void) setOff:(BOOL) value;
{
    [self OFFBtnBtnPressed:nil];
}
-(void) setNeutral
{
    [self NeutralBtnBtnPressed:nil];
}

-(void) ONBtnPressed:(id) sender
{
    self.isOn=!self.isOn;
    
    if(self.isOn)
    {
        self.isOFF=FALSE;
        self.isNeutral=FALSE;
        [UIView transitionWithView:bgImgView
                          duration:0.4f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            bgImgView.image=[UIImage imageNamed:@"ON.png"];
                        } completion:NULL];
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            
            [thumbBtn setFrame:CGRectMake(-3, -3, 27, 28)];
            
        } completion:nil];
        
        [delegate stateChangeForSwitch:self];
    }
    else
    {
        [self NeutralBtnBtnPressed:nil];
        
    }
}

-(void) NeutralBtnBtnPressed:(id) sender
{
    [UIView transitionWithView:bgImgView
                      duration:0.4f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        bgImgView.image=[UIImage imageNamed:@"Neutral.png"];
                    } completion:NULL];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [thumbBtn setFrame:CGRectMake(26, -3, 27, 28)];
        
    } completion:nil];
    
    self.isOn=FALSE;
    self.isOFF=FALSE;
    self.isNeutral=TRUE;
    
    [delegate stateChangeForSwitch:self];
}

-(void) OFFBtnBtnPressed:(id) sender
{
    self.isOFF=!self.isOFF;
    
    if(self.isOFF)
    {
        self.isOn=FALSE;
        self.isNeutral=FALSE;
        
        [UIView transitionWithView:bgImgView
                          duration:0.4f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            bgImgView.image=[UIImage imageNamed:@"OFF.png"];
                        } completion:NULL];
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [thumbBtn setFrame:CGRectMake(58, -3, 27, 28)];
            
        } completion:nil];
        
        [delegate stateChangeForSwitch:self];
    }
    else
    {
        [self NeutralBtnBtnPressed:nil];
        
    }
    
}

-(void) panning:(UIPanGestureRecognizer*) recoganizer
{
    CGPoint translation = [recoganizer translationInView:self];
    if(recoganizer.view.frame.origin.x>-4 && (recoganizer.view.frame.origin.x<(86-27))) //27 is width of thumb
    {
        recoganizer.view.center = CGPointMake(recoganizer.view.center.x+translation.x, recoganizer.view.center.y);
        
        [recoganizer setTranslation:CGPointMake(0, 0) inView:self];
    }
    
    NSLog(@"%.2f",recoganizer.view.frame.origin.x);
    
    if (recoganizer.state == UIGestureRecognizerStateEnded)
    {
        if(recoganizer.view.frame.origin.x<14)
        {
            [self ONBtnPressed:nil];
        }
        else if (recoganizer.view.frame.origin.x>3 && recoganizer.view.frame.origin.x<19)
        {
            [self NeutralBtnBtnPressed:nil];
        }
        else if (recoganizer.view.frame.origin.x>18 && recoganizer.view.frame.origin.x<46)
        {
            [self NeutralBtnBtnPressed:nil];
        }
        else if (recoganizer.view.frame.origin.x>45)
        {
            [self OFFBtnBtnPressed:nil];
        }
    }
}

-(void) dealloc
{
    panGesture=nil;
}

@end
