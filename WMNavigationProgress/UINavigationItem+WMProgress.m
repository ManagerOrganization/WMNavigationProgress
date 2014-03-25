//
//  UINavigationItem+Progress.m
//  PullToRefreshNav
//
//  Created by Willem Mattelaer on 23/03/14.
//  Copyright (c) 2014 Willem Mattelaer. All rights reserved.
//

#import "UINavigationItem+WMProgress.h"

#import <objc/runtime.h>

@implementation UINavigationItem (WMProgress)

- (CGFloat)progress {
	NSNumber *progress = objc_getAssociatedObject(self, @selector(progress));
	
	return [progress floatValue];
}

- (void)setProgress:(CGFloat)progress {
	objc_setAssociatedObject(self, @selector(progress), @(progress), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
