//
//  WMProgressView.h
//  PullToRefreshNav
//
//  Created by Willem Mattelaer on 23/03/14.
//  Copyright (c) 2014 Willem Mattelaer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProgressView : UIView

@property (nonatomic) CGFloat progress;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
