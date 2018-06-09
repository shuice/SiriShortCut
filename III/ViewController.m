//
//  ViewController.m
//  III
//
//  Created by shuice on 2018/6/8.
//  Copyright © 2018年 shuice. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <Intents/Intents.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // [self addSiriShortCut];
    [self addSiriSuggestion];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSiriShortCut
{
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.tencent.xiaoyi.temp.activity"];
    self.userActivity = activity;
    activity.title = @"activity_title";
    activity.eligibleForSearch = true;// 表示此处仅用于CoreSpotlight搜索，而不进行应用间数据传递处理
    activity.expirationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:100000];
    activity.userInfo = @{@"key_1": @"value_1"};
    activity.needsSave = true;
    //   activity.eligibleForPublicIndexing = true;打开云索引功能，当很多用户都搜素时，所有安装过该应用的客户都能通过CoreSpotlight搜索到(即使用户没有打开过)
    // iOS12
    //   activity.suggestedInvocationPhrase = @"说点什么好呢？";
    {
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:CFBridgingRelease(kUTTypeItem)];
        attributeSet.contentDescription = @"contentDescription";
        attributeSet.relatedUniqueIdentifier = nil;
    }
    
    [activity becomeCurrent];
}


- (void)addSiriSuggestion
{
//    INIntent *inIntent = [[INSetClimateSettingsInCarIntent alloc] init];
//    inIntent.dat
//    //inIntent.
//    INInteraction *action = [[INInteraction alloc] initWithIntent:inIntent response:nil];
//    [action donateInteractionWithCompletion:^(NSError * _Nullable error) {
//        NSLog(@"%@", error);
//    }];
}
@end
