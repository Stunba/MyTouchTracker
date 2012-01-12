//
//  MyClass.h
//  MyTouchTracker
//
//  Created by Artem Bastun on 12.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Line : NSObject {
@private
    CGPoint begin;
    CGPoint end;
}

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;

@end
