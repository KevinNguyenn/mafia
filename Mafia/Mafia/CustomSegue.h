//
//  CustomSegue.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCard.h"

@interface CustomSegue : UIStoryboardSegue
// Originating point for animation
@property CGPoint originatingPoint;

// hold the singleCard
@property (nonatomic, weak) SingleCard *card;

@end
