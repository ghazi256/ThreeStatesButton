ThreeStatesButton
=================

This is a custom control that contains three states for a switch ON, OFF and Neutral

Import the header where you want to use this control and initialize it with

HJThreeStateButton *threeStatebtn=[[HJThreeStateButton alloc] initWithFrame:CGRectMake(100, 100, 80, 21)];

threeStatebtn.tag=101;

threeStatebtn.delegate=self;

[self.view addSubview:threeStatebtn];
