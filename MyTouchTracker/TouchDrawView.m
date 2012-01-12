//
//  TouchDrawView.m
//  MyTouchTracker
//
//  Created by Artem Bastun on 12.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"


@implementation TouchDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        linesInProcess = [[NSMutableDictionary alloc] init];
        completeLines = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 10);
    CGContextSetLineCap(content, kCGLineCapRound);
    [[UIColor blackColor] set];
    for (Line *line in completeLines) {
        CGContextMoveToPoint(content, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(content, line.end.x, line.end.y);
        CGContextStrokePath(content);
    }
    [[UIColor redColor] set];
    for (NSValue *value in linesInProcess) {
        Line *line = [linesInProcess objectForKey:value];
        CGContextMoveToPoint(content, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(content, line.end.x, line.end.y);
        CGContextStrokePath(content);
    }
}

- (void) clearAll {
    [linesInProcess removeAllObjects];
    [completeLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        if ([t tapCount] > 1) {
            [self clearAll];
            return;
        }
        NSValue *key = [NSValue valueWithPointer:t];
        CGPoint begin = [t locationInView:self];
        Line *l = [[[Line alloc] init] autorelease];
        l.begin = l.end = begin;
        [linesInProcess setObject:l forKey:key];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        Line *line = [linesInProcess objectForKey:key];
        CGPoint loc = [t locationInView:self];
        line.end = loc;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        Line *l = [linesInProcess objectForKey:key];
        if (!l) {
            return;
        }
        CGPoint end = [t locationInView:self];
        l.end = end;
        [completeLines addObject:l];
        [linesInProcess removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [linesInProcess release];
    [completeLines release];
    [super dealloc];
}

@end
