//
//  ExploreLeaderboardHeader.m
//  iNaturalist
//
//  Created by Alex Shepard on 2/19/15.
//  Copyright (c) 2015 iNaturalist. All rights reserved.
//

#import "ExploreLeaderboardHeader.h"

@implementation ExploreLeaderboardHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            visualEffectView.frame = self.bounds;
            visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            [self addSubview:visualEffectView];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        
        self.title = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont boldSystemFontOfSize:12.0f];
            
            label;
        });
        [self addSubview:self.title];
        
        self.subTitle = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont boldSystemFontOfSize:12.0f];
            
            label;
        });
        [self addSubview:self.subTitle];

        
        UILabel *spanLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textAlignment = NSTextAlignmentCenter;
            label.text = NSLocalizedString(@"Time Period", @"Label for the time period selector in the explore leaderboard header.");
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12.0f];
            
            label;
        });
        [self addSubview:spanLabel];
        
        UILabel *sortLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textAlignment = NSTextAlignmentCenter;
            label.text = NSLocalizedString(@"Sort", @"Label for the sort selector in the explore leaderboard header.");
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12.0f];
            
            label;
        });
        [self addSubview:sortLabel];
        
        
        self.spanSelector = ({
            NSDate *date = [NSDate date];
            
            NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
            monthFormatter.dateFormat = @"MMM";
            NSString *month = [monthFormatter stringFromDate:date];
            
            NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
            yearFormatter.dateFormat = @"yyyy";
            NSString *year = [yearFormatter stringFromDate:date];
            
            UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[month, year]];
            control.translatesAutoresizingMaskIntoConstraints = NO;
            
            control;
        });
        [self addSubview:self.spanSelector];
        
        self.sortSelector = ({
            UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[ NSLocalizedString(@"Obs", @"Observation option for explore leaderboard sorting. Must be short."),
                                                                                       NSLocalizedString(@"Species", @"Species optino for explore leaderboard sorting. Must be short.")] ];
            control.translatesAutoresizingMaskIntoConstraints = NO;
            
            control;
        });
        [self addSubview:self.sortSelector];
        
        UIView *bottomEdge = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.backgroundColor = [UIColor grayColor];
            view;
        });
        [self addSubview:bottomEdge];

        NSDictionary *views = @{
                                @"title": self.title,
                                @"subTitle": self.subTitle,
                                @"spanLabel": spanLabel,
                                @"sortLabel": sortLabel,
                                @"span": self.spanSelector,
                                @"sort": self.sortSelector,
                                @"bottomEdge": bottomEdge,
                                };
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[title]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[subTitle]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[spanLabel]-[sortLabel(==spanLabel)]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[span]-[sort(==span)]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bottomEdge]-0-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[title]-[subTitle]-[spanLabel]-[span]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[title]-[subTitle]-[sortLabel]-[sort]-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomEdge(==0.5)]-0-|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views]];
        
        self.clipsToBounds = NO;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 1.5f;
        
    }
    
    return self;
}

@end
