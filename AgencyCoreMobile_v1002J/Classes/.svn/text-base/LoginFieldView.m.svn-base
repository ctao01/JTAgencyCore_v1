//
//  UILoginFieldView.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/18/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "LoginFieldView.h"
#import <QuartzCore/QuartzCore.h>
#import "LogInViewController.h"

@interface  LoginFieldView ()
{
    float _radius;
}
@end

@implementation LoginFieldView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andRadius:0.0f];
}

- (id)initWithFrame:(CGRect)frame andRadius:(float)radius
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _radius = radius;
		self.fillColor = [UIColor clearColor];
		self.shadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
        
        if (_radius > 0.0f)
        {
            self.layer.cornerRadius = _radius;
            self.layer.masksToBounds = YES;
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

-(void) setFillColor:(UIColor *)fillColor
{
	if (_fillColor == fillColor) return;
	_fillColor = fillColor;
	
	[self setNeedsDisplay];
}

-(void) setShadowColor:(UIColor *)shadowColor
{
	if (_shadowColor == shadowColor) return;
	_shadowColor = shadowColor;
	
	[self setNeedsDisplay];
}

#pragma mark -

- (CGMutablePathRef) newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius
{
	CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width  ;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
    
	CGFloat outside_bottom = rect.origin.y + rect.size.height ;
    
	CGFloat inside_top = innerRect.origin.y;
    
	CGFloat outside_top = rect.origin.y ;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
	CGPathCloseSubpath(retPath);
    
	return retPath;
}

- (void)drawRect:(CGRect)rect
{
    
    CGRect bounds = [self bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGFloat radius = 0.5f * CGRectGetHeight(bounds);
    CGFloat outsideOffset = 10.f; // this value doesn't really matter - just > 0
    CGRect innerBounds = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height);
    CGRect outerBounds = CGRectInset(innerBounds, -outsideOffset, -outsideOffset);
    
    
    // Create the "visible" path, which will be the shape that gets the inner shadow
    // In this case it's just a rounded rect, but could be as complex as your want
    CGMutablePathRef visiblePath = [self newPathForRoundedRect:innerBounds radius:_radius];
    
    // Fill this path
    //UIColor *aColor = [UIColor whiteColor];
    [self.fillColor setFill];
    CGContextAddPath(context, visiblePath);
    CGContextFillPath(context);
    
    
    // Now create a larger rectangle, which we're going to subtract the visible path from
    // and apply a shadow
    CGMutablePathRef path = [self newPathForRoundedRect:outerBounds radius:0.0f];
    
    // Add the visible path (so that it gets subtracted for the shadow)
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    // Add the visible paths as the clipping path to the context
    CGContextAddPath(context, visiblePath);
    CGContextClip(context);
    
    
    // Now setup the shadow properties on the context
    //aColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 3.0f, [self.shadowColor CGColor]);
    
    // Now fill the rectangle, so the shadow gets drawn
    [self.shadowColor setFill];
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
    
    // Release the paths
    CGPathRelease(path);
    CGPathRelease(visiblePath);
    
    CGPoint startPoint = CGPointMake(rect.origin.x, rect.origin.y + (rect.size.height / 2));
    CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, startPoint.y);
    UIBezierPath * seperator = [UIBezierPath bezierPath];
    [seperator moveToPoint:startPoint];
    [seperator addLineToPoint:endPoint];
    [[UIColor grayColor]setStroke];
    [seperator setLineWidth:0.25f];
    [seperator stroke];
    
    [super drawRect:rect];
    
    UITextField * usernameField = [[UITextField alloc]initWithFrame:CGRectMake(0.0f, 0.0f, rect.size.width, 40.0f)];
    usernameField.frame = UIEdgeInsetsInsetRect(usernameField.frame, UIEdgeInsetsMake(2.0f, 10.0f, 2.0f, 10.0f));
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.backgroundColor = [UIColor clearColor];
    usernameField.tag = 2001;
    usernameField.placeholder = @"Username";
    usernameField.returnKeyType = UIReturnKeyNext;
    usernameField.delegate = (LogInViewController*)self.parentViewController;
    [self addSubview:usernameField];
    
    UITextField * passwordField = [[UITextField alloc]initWithFrame:CGRectMake(0.0f, 44.0f, rect.size.width, 40.0f)];
    passwordField.frame = UIEdgeInsetsInsetRect(passwordField.frame, UIEdgeInsetsMake(2.0f, 10.0f, 2.0f, 10.0f));
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.delegate = (LogInViewController*)self.parentViewController;
    passwordField.tag = 2002;
    passwordField.placeholder = @"Password";
    passwordField.returnKeyType = UIReturnKeyDone;
    [self addSubview:passwordField];
}

@end
