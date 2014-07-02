//
//  Dialog.m
//  NUTheNord
//
//  Created by Sid on 2014/4/22.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Dialog.h"
#import "LeagueScene.h"
@implementation Dialog
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    userActInt = YES;
    
    _dialogtext.string = [NSString stringWithFormat:@"歡迎來到新手教學"];
    dialogInt = [[NSUserDefaults standardUserDefaults] integerForKey:@"DialogInt"];

}



-(void) update:(CCTime)delta
{
    //set delay time for dialog remove
    if (!userActInt) {
        CCLOG(@"!userActInt");
        if (!self.userInteractionEnabled) {
            userActInt = YES;
            CCLOG(@"!userInteractionEnabled");
            //[self scheduleBlock:^(CCTimer *timer) {
                self.userInteractionEnabled = YES;
                    dialogInt = dialogInt + 1;
                CCLOG(@"YYYYYYYEEEEEEEESSSSSSS");
            //} delay:0.0f];
        }
    }
    
    switch (dialogInt) {
        case 0:
        {

            _dialogtext.string = [NSString stringWithFormat:@"這裡是基地內的戰鬥實驗室\n接下來我會教你如何使用英靈戰鬥"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 1:
        {
            _dialogtext.string = [NSString stringWithFormat:@"觸碰遊戲空白處可以跳躍"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 2:
        {
            _dialogtext.string = [NSString stringWithFormat:@"按下右下角的按鈕可以使用普通攻擊"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 3:
        {
            _dialogtext.string = [NSString stringWithFormat:@"中下方的按鈕可以使用技能攻擊"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 4:
        {
            _dialogtext.string = [NSString stringWithFormat:@"接下來自己試試看吧！"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 5:
        {
            [self.delegate removeDialog];
            
            break;
        }
        case 10:
        {
            _dialogtext.string = [NSString stringWithFormat:@"點擊遊戲空白處跳躍！"];
            self.userInteractionEnabled = NO;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 11:
        {
            [self.delegate removeDialog];
            
            break;
        }

        case 12:
        {
            _dialogtext.string = [NSString stringWithFormat:@"小心！碰到火球會大量損耗HP\n點擊遊戲空白處跳躍閃避！！"];
            self.userInteractionEnabled = NO;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 13:
        {
            [self.delegate removeDialog];
            break;
        }
        case 14:
        {
            _dialogtext.string = [NSString stringWithFormat:@"攻擊！！"];
            self.userInteractionEnabled = NO;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 15:
        {
            [self.delegate removeDialog];
            break;
        }
        case 16:
        {
            _dialogtext.string = [NSString stringWithFormat:@"有老鼠！"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 17:
        {
            _dialogtext.string = [NSString stringWithFormat:@"嘻嘻\n最近實驗室常會有老鼠偷跑進來\n順便幫組織清理一下吧～"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 18:
        {
            _dialogtext.string = [NSString stringWithFormat:@"…………"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 19:
        {
            [self.delegate removeDialog];
            break;
        }
        case 20:
        {
            _dialogtext.string = [NSString stringWithFormat:@"前方有巨石！\n必須使用攻擊排除！"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = NO;
            _sciDia.visible= YES;
            break;
        }
        case 21:
        {
            [self.delegate removeDialog];
            break;
        }
        
            
            
            
            
            
            
            
            
            /// First Time Intro Dialog
        case 90:
        {
            _dialogtext.string = [NSString stringWithFormat:@"(身體無法動彈，警戒的望向聲音來源)"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 91:
        {
            _dialogtext.string = [NSString stringWithFormat:@"總算是醒了？算你命大，\n那個區域只找到你一個活人。"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 92:
        {
            _dialogtext.string = [NSString stringWithFormat:@"…活…人…?\n(猛然驚醒，想坐起身來，\n身體卻仍然使不上力)"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 93:
        {
            _dialogtext.string = [NSString stringWithFormat:@"喂喂，你還動不了吧，\n越是勉強死的越快喔！"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 94:
        {
            _dialogtext.string = [NSString stringWithFormat:@"只有我一個活人是什麼意思？\n其他人呢？"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 95:
        {
            _dialogtext.string = [NSString stringWithFormat:@"很遺憾，那裡除了你只剩下滿地屍體。"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 96:
        {
            _dialogtext.string = [NSString stringWithFormat:@"…席娜……不會的…怎麼會…"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 97:
        {
            _dialogtext.string = [NSString stringWithFormat:@"別露出這種表情，\n你可是唯一活下來的人，\n那種態度怎麼對得起那些死去的人？"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 98:
        {
            _dialogtext.string = [NSString stringWithFormat:@"(瞪向那人)"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 99:
        {
            _dialogtext.string = [NSString stringWithFormat:@"別瞪了，\n能活下來總是好事，我和你都一樣，\n對了，向你介紹，\n我叫凱莉絲，暫時是這裡的負責人，\n你呢？"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 100:
        {
            _dialogtext.string = [NSString stringWithFormat:@"…… ZERO…"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 101:
        {
            _dialogtext.string = [NSString stringWithFormat:@"ZERO是嗎？真是個特別的名字！\n先不說這個，\n你對你身邊這東西有什麼印象嗎？\n(拿起一個像護腕的裝置)"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 102:
        {
            _dialogtext.string = [NSString stringWithFormat:@"這個…？這是什麼？"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }

        case 103:
        {
            _dialogtext.string = [NSString stringWithFormat:@"看來你也不清楚嗎？根據初步的分析，\n這應該是運用某種能源的裝置。"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 104:
        {
            _dialogtext.string = [NSString stringWithFormat:@"能源…"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 105:
        {
            _dialogtext.string = [NSString stringWithFormat:@"這裝置太過複雜，我們暫時無法解析，\n本來以為你知道什麼，看來是沒戲了哪"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 106:
        {
            _dialogtext.string = [NSString stringWithFormat:@"此時裝置發出強光，光線匯成一直線，\n指向ZERO身上"];
            _zero.visible = NO;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 107:
        {
            _dialogtext.string = [NSString stringWithFormat:@"這？！"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 108:
        {
            _dialogtext.string = [NSString stringWithFormat:@"這個反應！我們不管做什麼，\n他都無動於衷，怎麼……"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 109:
        {
            _dialogtext.string = [NSString stringWithFormat:@"喂！快想想辦法！\n我現在動不了啊！"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 110:
        {
            _dialogtext.string = [NSString stringWithFormat:@"(露出微笑)不不！\n這可是一個契機哪！"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 111:
        {
            _dialogtext.string = [NSString stringWithFormat:@"！！什麼？"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 112:
        {
            _dialogtext.string = [NSString stringWithFormat:@"ZERO，\n你的身體就己給我們好好研究一番吧，\n當然會給你報酬啦！"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 113:
        {
            _dialogtext.string = [NSString stringWithFormat:@"別開玩笑，給我滾開！"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 114:
        {
            _dialogtext.string = [NSString stringWithFormat:@"(微笑)你以為你現在有說不的能耐?\n(把裝置強行裝到ZERO手上)"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 115:
        {
            _dialogtext.string = [NSString stringWithFormat:@"妳！！"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 116:
        {
            _dialogtext.string = [NSString stringWithFormat:@"碰到ZERO的一瞬間，\n從裝置上落下幾塊結晶"];
            _zero.visible = NO;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 117:
        {
            _dialogtext.string = [NSString stringWithFormat:@"果然有變化，看這東西，\n應該是某種能源的結晶，\n應該就是這個裝置需要的吧……"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 118:
        {
            _dialogtext.string = [NSString stringWithFormat:@"喂ZERO，\n過幾天你能動後我們再來做實驗吧，\n我先來研究這東西的用法。"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 119:
        {
            _dialogtext.string = [NSString stringWithFormat:@"……我的否決權呢?"];
            _zero.visible = YES;
            _npc.visible = NO;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 120:
        {
            _dialogtext.string = [NSString stringWithFormat:@"你認為有這種東西嗎？"];
            _zero.visible = NO;
            _npc.visible = YES;
            _blueDia.visible = YES;
            _sciDia.visible= NO;
            break;
        }
        case 121:
        {
            [self.delegate removeDialog];
            break;
        }
            
            
        default:
            break;
    }
}
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{

    self.userInteractionEnabled = NO;
    userActInt = NO;
    CCLOG(@"touchend! +1");

}


@end
