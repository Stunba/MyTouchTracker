//
//  MyClass.m
//  MyTouchTracker
//
//  Created by Artem Bastun on 12.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Line.h"


@implementation Line

@synthesize begin , end;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
