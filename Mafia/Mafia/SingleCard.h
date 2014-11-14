//
//  SingleCard.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/5/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCard.h"

@protocol SingleCardProtocol <NSObject>

-(void) pullUpIndividualCard : (UIView *) theCard;

@end

@interface SingleCard : UIView

-(id)makeCard : (CGRect) cardSpec WithLabel : (CGRect) labelSpec AndType : (int) labelType;
-(CGPoint) getCenter;

// attributes for the card
@property (nonatomic) NSInteger cardWidth;
@property (nonatomic) NSInteger cardHeight;
@property (nonatomic) NSInteger xCoord;
@property (nonatomic) NSInteger yCoord;

@property (nonatomic, weak) SingleCard *theCard;

@property(weak, nonatomic) id <SingleCardProtocol> delegate;
// [TODO] attach connected textfield and update name




@end
