//
//  SingleCard.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/5/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleCard : UIView

-(id)makeCard : (CGRect) cardSpec;

@property (nonatomic) NSInteger *cardWidth;
@property (nonatomic) NSInteger *cardHeight;
@property (nonatomic) NSInteger *xCoord;
@property (nonatomic) NSInteger *yCoord;

@end
