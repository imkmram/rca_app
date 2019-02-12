//
//  PopTipView.h
//  RCA
//
//  Created by Ashok Gupta on 13/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface PopTipView : NSObject<CMPopTipViewDelegate>

-(void)initializePopView:(UIView *)contentView;
-(void)showPopView:(UIView *)presentingView overView:(UIView *)parentView;
-(void)dismiss;

@end
