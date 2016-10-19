//
//  ViewController.m
//  PinyinSort
//
//  Created by WangHong on 2016/10/20.
//  Copyright © 2016年 WangHong. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *old = @[@"单元88888",@"呀",@"9",@"a",@"a这种",@"啊在哪里88",@"z",@"波",@"防",@"6",@"yyy",@"a3",@"智障",@"啊啊啊",@"6哈哈哈",@"5",@"六"];
    
    NSMutableArray *users = [NSMutableArray array];
    for (NSString *s in old) {
        User *user = [[User alloc]init];
        user.name = s;
        user.firstLetter = [self toPinyin:s];
        [users addObject:user];
    }
    
    NSArray *sortedArray = [self userSorting:users];
    for (User *user in sortedArray) {
        NSLog(@"name %@",user.name);
    }
}


- (NSString *)toPinyin:(NSString *)str{
    NSMutableString *ms = [[NSMutableString alloc]initWithString:str];
    // 会有音调的拼音，由于这里只用了第一个字符的拼音，所以没必要去掉音调
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformMandarinLatin, NO)) {
//        NSLog(@"pinyin: ---- %@", ms);
        NSString *bigStr = [ms uppercaseString];
        NSString *cha = [bigStr substringToIndex:1];
        return cha;
    }
    //    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO)) {
    //        NSLog(@"pinyin22: ---- %@", ms);
    //
    //        NSString *bigStr = [ms uppercaseString];
    //        NSString *cha = [bigStr substringToIndex:1];
    //        return cha;
    //    }
    return str;
}


-(NSArray *)userSorting:(NSArray *)sortArray{
    NSMutableArray *modelArray = [sortArray mutableCopy];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i='A';i<='Z';i++)
    {
        NSMutableArray *rulesArray = [[NSMutableArray alloc] init];
        NSString *str1=[NSString stringWithFormat:@"%c",i];
        
        for(int j=0; j<modelArray.count; j++)
        {
            User *model = [modelArray objectAtIndex:j];
            if([model.firstLetter isEqualToString:str1])
            {
                [rulesArray addObject:model];
                [modelArray removeObject:model];
                j--;
                
            }else{
                
            }
        }
        if (rulesArray.count !=0) {
            [array addObject:rulesArray];
        }
    }
    
    if (modelArray.count !=0) {
        // 对于非字母内容排序
        [modelArray sortUsingComparator:^NSComparisonResult(User  *obj1, User *obj2) {
            return obj1.firstLetter > obj2.firstLetter;
        }];
        [array addObject:modelArray];
    }
    
    //最后整理数组
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:sortArray.count];
    for (NSArray *keyArray in array) {
        for (id item in keyArray) {
            [sortedArray addObject:item];
        }
    }
    
    return sortedArray;
}




@end
