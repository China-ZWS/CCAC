//
//  DDObject.m
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDObject.h"
#import <objc/runtime.h>

@implementation DDObject

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"%@", [super description]];

    Class class = [self class];
    unsigned int count;

    objc_property_t *properties = class_copyPropertyList(class, &count);
    if (count <= 0) {
        return [super description];
    }

    NSString *descString = [NSString string];

    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *propertyNameSt = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyNameSt];
        NSString *valueString = nil;

        if ([value isKindOfClass:[NSString class]]) {
            valueString = value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            valueString = [NSString stringWithFormat:@"%f", [value floatValue]];
        } else {
            valueString = [value description];
        }

        descString = [descString stringByAppendingFormat:@"\n%@:%@;", propertyNameSt, valueString];
    }

    free(properties);

    return [desc stringByAppendingFormat:@"\n{%@\n}", descString];
}

@end
