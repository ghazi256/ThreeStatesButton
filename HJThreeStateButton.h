//
//  HJThreeStateButton.h
//  zzz-sliderManualTest
//
//  Created by hasnainjafri on 6/27/14.
//  Copyright (c) 2014 hasnainjafri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJThreeStateButton;
@protocol HJThreeStateButtonDelegate
@optional
-(void)stateChangeForSwitch:(HJThreeStateButton*)currentSwitch;
@end

@interface HJThreeStateButton : UIControl
{
    UIButton *ONBtn;
    UIButton *OFFBtn;
    UIButton *NeutralBtn;
    
    UIButton *thumbBtn;
    
    UIImageView *bgImgView;
}

@property(nonatomic,assign) BOOL isOn;
@property(nonatomic,assign) BOOL isOFF;
@property(nonatomic,assign) BOOL isNeutral;

@property (nonatomic,assign)id<HJThreeStateButtonDelegate>delegate;
-(void) setOn:(BOOL) value;
-(void) setOff:(BOOL) value;
-(void) setNeutral;
-(void) set_Enabled:(BOOL)enabled;

@end
