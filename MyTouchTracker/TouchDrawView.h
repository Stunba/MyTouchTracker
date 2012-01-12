//
//  TouchDrawView.h
//  MyTouchTracker
//
//  Created by Artem Bastun on 12.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouchDrawView : UIView {
    NSMutableDictionary *linesInProcess;
    NSMutableArray *completeLines;
}

@end
