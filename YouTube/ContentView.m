//
//  ContentView.m
//  YouTube
//
//  Created by Ryo Suzuki on 7/19/13.
//  Copyright (c) 2013 Ryo Suzuki. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.frame = CGRectMake(130, 0, 100, 50);
        [self addSubview:self.textLabel];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = CGRectMake(0, 0, 120, 90);
        [self addSubview:self.imageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
