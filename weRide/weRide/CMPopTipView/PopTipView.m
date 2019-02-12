//
//  PopTipView.m
//  RCA
//
//  Created by Ashok Gupta on 13/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

#import "PopTipView.h"
#import "CMPopTipView.h"

@implementation PopTipView
{
    CMPopTipView *popTipView;
}

- (void)initializePopView:(UIView *)contentView {
    
    if (contentView) {
        popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
    }
    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = (BOOL)(arc4random() % 2);
    popTipView.delegate = self;
    popTipView.dismissTapAnywhere = YES;
    //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
    /* Some options to try.
     */
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    //popTipView.hasGradientBackground = NO;
    //popTipView.cornerRadius = 2.0;
    //popTipView.sidePadding = 30.0f;
    //popTipView.topMargin = 20.0f;
    //popTipView.pointerSize = 50.0f;
    //popTipView.hasShadow = NO;
}

-(void)showPopView:(UIView *)presentingView overView:(UIView *)parentView {
    
    [popTipView presentPointingAtView:presentingView inView:parentView animated:YES];
}

-(void)dismiss {
    [popTipView dismissAnimated:YES];
}

-(void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
   // [popTipView dismissAnimated:YES];
}

@end
