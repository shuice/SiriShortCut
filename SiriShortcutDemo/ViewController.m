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
#import <IntentsUI/IntentsUI.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self addSiriShortCut];
    [self addSiriSuggestion];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToSiri:(id)sender {
    
    INUIAddVoiceShortcutViewController *vc = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:[[INShortcut alloc] initWithUserActivity:[self addSiriShortCut]]];
    [self presentViewController:vc animated:YES completion:nil];
}

// 文档https://developer.apple.com/documentation/sirikit/donating_shortcuts
- (NSUserActivity *)addSiriShortCut
{
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.tencent.xiaoyi.temp.activity"];
    activity.persistentIdentifier = [NSString stringWithFormat:@"%d", arc4random()];    // 唯一ID，未来删除activity用它
    activity.title = @"activity_title";
    activity.eligibleForSearch = YES;// 表示此处仅用于CoreSpotlight搜索，而不进行应用间数据传递处理
    activity.userInfo = @{@"key_1": @"value_1"};
    if (@available(iOS 12.0, *))
    {
        activity.eligibleForPrediction = YES;   // 有了它，可以在spotlight下方显示siri建议
        activity.suggestedInvocationPhrase = @"Ting Ge Shi Qu";
    }
    self.userActivity = activity;   // 文档说same as [activity becomeCurrent]，实际上两个都需要调用
    [activity becomeCurrent]; // donates the activity to Siri
    return activity;
}


- (void)addSiriSuggestion
{
    INMediaItem *mediaItem = [[INMediaItem alloc] initWithIdentifier:@"Identifier"
                                                               title:@"title_凉凉"
                                                                type:INMediaItemTypeSong
                                                             artwork:nil];
    INPlayMediaIntent *intent = [[INPlayMediaIntent alloc] initWithMediaItems:@[mediaItem]
                                                               mediaContainer:mediaItem
                                                                 playShuffled:@(YES)
                                                           playbackRepeatMode:INPlaybackRepeatModeAll
                                                               resumePlayback:@(NO)];
    intent.suggestedInvocationPhrase = @"播放凉凉";
    INInteraction *action = [[INInteraction alloc] initWithIntent:intent response:nil];
    [action donateInteractionWithCompletion:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}
@end
