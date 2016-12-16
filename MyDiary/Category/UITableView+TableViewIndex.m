//
//  UITableView+TableViewIndex.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/14.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "UITableView+TableViewIndex.h"
#import <objc/runtime.h>

@implementation UITableView (TableViewIndex)

- (void)md_setLeftTableViewIndex {
    
////    NSMutableDictionary *props = [NSMutableDictionary dictionary];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i = 0; i<outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char* char_f =property_getName(property);
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        id propertyValue = [self valueForKey:(NSString *)propertyName];
////        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
//    }
//    free(properties);
    
//    NSLog(@"%@",class_getInstanceVariable([self class],"_index"));

//    for (id view in self.subviews) {
//        
//        if ([view isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
//            NSLog(@"1");
//        }
//        NSLog(@"%@",view);
//    }

}

@end
