//
//  WMProgressView.m
//  PullToRefreshNav
//
//  Created by Willem Mattelaer on 23/03/14.
//  Copyright (c) 2014 Willem Mattelaer. All rights reserved.
//

#import "WMProgressView.h"

@interface WMProgressView ()

@property (nonatomic) int direction;
@property (nonatomic) CGFloat currentProgress;
@property (nonatomic) CFTimeInterval lastTimestamp;
@property (nonatomic) CADisplayLink *displayLink;

@end

@implementation WMProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat height = CGRectGetHeight(self.bounds);
	
	UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width * self.currentProgress, height)];
	[self.tintColor setFill];
	[bezierPath fill];
}

- (void)tintColorDidChange {
	[self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
	[self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
	_progress = progress;
	
	if (self.progress != self.currentProgress) {
		if (animated) {
			self.direction = (self.currentProgress < self.progress ? 1 : -1);
			self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(nextStep)];
			[self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
			self.lastTimestamp = -1;
		} else {
			self.currentProgress = self.progress;
			[self setNeedsDisplay];
		}
	}
}

- (void)nextStep {
	CFTimeInterval timestamp = [self.displayLink timestamp];
	if (self.lastTimestamp != -1) {
		double difference = timestamp - self.lastTimestamp;
		self.currentProgress += self.direction * difference * 0.6f;
		if ((self.currentProgress > self.progress && self.direction > 0) || (self.currentProgress < self.progress && self.direction < 0)) {
			[self.displayLink invalidate];
			self.currentProgress = self.progress;
		}
	}
	
	[self setNeedsDisplay];
	self.lastTimestamp = timestamp;
}

@end
