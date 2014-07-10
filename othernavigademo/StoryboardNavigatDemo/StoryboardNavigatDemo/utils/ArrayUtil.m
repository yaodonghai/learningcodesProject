//
//  ArrayUtil.m
//  youcoach
//
//  Created by June on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArrayUtil.h"

@implementation ArrayUtil

+ (NSArray*)appendString:(NSString*)string inArray:(NSArray*)array
{
	NSMutableArray *result = [NSMutableArray array];
	for (id value in array) {
		[result addObject:[NSString stringWithFormat:@"%@%@", value, string]];
	}
	return result;
}

+ (NSArray*)wrapperWithLeftString:(NSString*)leftString rightString:(NSString*)rightString inArray:(NSArray*)array
{
	NSMutableArray *result = [NSMutableArray array];
	for (id value in array) {
		[result addObject:[NSString stringWithFormat:@"%@%@%@", leftString, value, rightString]];
	}
	return result;
}

+ (NSArray*)insertBeforeWithString:(NSString*)string inArray:(NSArray*)array
{
	NSMutableArray *result = [NSMutableArray array];
	for (id value in array) {
		[result addObject:[NSString stringWithFormat:@"%@%@", string, value]];
	}
	return result;
}

+ (int)findIndexBesizeNumber:(NSNumber*)targetNumber inArray:(NSArray*)array
{
    int i, index = 0, count = [array count];
    for (i=0; i< count; i++) {
		NSNumber *number = (NSNumber*)[array objectAtIndex:i];
        NSComparisonResult result = [number compare:targetNumber];
        if (result < 0) {
            index = i;
        } else if (result == 0) {
            index = i;
            break;
        }
    }
    return index;
}

+ (NSArray*)rangeWithStartNumber:(CGFloat)start count:(int)count step:(CGFloat)step
{
	NSMutableArray *array = [NSMutableArray array];
	for (int i = 0; i < count; i++) {
		NSNumber *number = [NSNumber numberWithFloat:(start + step * i)];
		[array addObject:number];
	}
	return array;
}

+ (NSArray*)rangeWithStartNumber:(CGFloat)start endNumber:(CGFloat)end step:(CGFloat)step
{
	NSMutableArray *array = [NSMutableArray array];
	for (CGFloat i = start; i <= end ; i+= step) {
		NSNumber *number = [NSNumber numberWithFloat:i];
		[array addObject:number];
	}
	return array;
}

// find object in array which key equal value.
+ (NSArray*)filterObjectsWithKey:(NSString*)key equal:(id)value inArray:(NSArray*)allObjects
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ == %@", key, value];
    return [allObjects filteredArrayUsingPredicate:predicate];
}

+ (void)updateAllValueWithKey:(NSString*)key value:(id)value inArray:(NSArray*)allObjects
{
    for (id object in allObjects) {
        [object setValue:value forKey:key];
    }
}

+ (void)updateValueWithKey:(NSString*)key manyValues:(NSArray*)allValues inArray:(NSArray*)allObjects
{
    if ([allValues count] != [allObjects count]) {
        NSLog(@"Error: updateAllValueWithKey, count is not equal!");
        return;
    }
    for (int i=0; i < [allObjects count]; i++) {
        id object = [allObjects objectAtIndex:i];
        id value = [allValues objectAtIndex:i];
        [object setValue:value forKey:key];
    }
}

// 排重
+ (NSArray*)uniqueWithArray:(NSArray*)array
{
    NSSet *set = [NSSet setWithArray:array];
    return [set allObjects];
}

// 排重但保留原来的顺序
+ (NSArray*)uniqueForOriginalOrderWithArray:(NSArray*)array
{
    NSMutableArray *result = [NSMutableArray array];
    for (id object in array) {
        if ([result indexOfObject:object] == NSNotFound) {
            [result addObject:object];
        }
    }
    return result;
}

+ (NSArray*)getValuesFromEntitiesWithKey:(NSString*)key inArray:(NSArray*)array
{
    NSMutableArray *result = [NSMutableArray array];
    for (id entity in array) {
        id value = [entity valueForKey:key];
        if (value != nil) {
            [result addObject:value];
        }
    }
    return result;
}

+ (NSArray*)padArrayWithObject:(NSObject*)object totalCount:(int)total inArray:(NSArray*)array
{
    int otherCount = total - [array count];
    if (otherCount <= 0) {
        return array;
    }
    
    NSMutableArray *result = [array isKindOfClass:[NSMutableArray class]] ? array : [array mutableCopy];
    for (int i=0; i < otherCount; i++) {
        [result addObject:object];
    }
    
    return result;
}

+ (NSArray*)filterArrayWithEachBoolValues:(NSArray*)eachBoolValues inArray:(NSArray*)array
{
    if ([eachBoolValues count] != [array count]) {
        NSLog(@"EROOR filterArrayWithEachBoolValues got different length array!");
        return array;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    int index = 0;
    for (NSNumber *number in eachBoolValues) {
        if ([number boolValue]) {
            [result addObject:[array objectAtIndex:index]];
        }
        index++;
    }
    
    return result;
}

+ (NSMutableArray*)fillArrayWithValue:(id)value count:(NSUInteger)count
{
    if (value == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        [array addObject:value];
    }
    return array;
}

// 合并两个数组，原则是newEnities会覆盖oldEnitites中相同key的对象，如果newEntities中有oldEntities没有对象，则会直接添加进结果数组中。
+ (NSArray*)mergeEntitiesWithKey:(NSString*)key oldEnities:(NSArray*)oldEnitites newEnities:(NSArray*)newEnitities
{
    if ([newEnitities count] == 0) {
        return oldEnitites;
    }
        
    if ([oldEnitites count] == 0) {
        return newEnitities;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *leftNewEntites = [NSMutableArray array];
    
    [[self class] eachOneWithArray:newEnitities doing:^(id object, int i) {
        [leftNewEntites addObject:object];
    }];
    
    id oldEnity, newEnity;
    for (oldEnity in oldEnitites) {
        id oldValue = [oldEnity valueForKey:key];
        
        BOOL compared = NO;
        for (id enity in leftNewEntites) {
            newEnity = enity;
            id newValue = [newEnity valueForKey:key];
            
            if ([oldValue isKindOfClass:[NSNumber class]]) {
                compared = [oldValue isEqualToNumber:newValue];
            } else {
                compared = [oldValue isEqual:newValue];
            }
            
            if (compared) {
                break;
            }
        }
        
        if (compared) {
            [array addObject:newEnity];
            [leftNewEntites removeObject:newEnity];
        } else {
            [array addObject:oldEnity];
        }
    }
    
    [array addObjectsFromArray:leftNewEntites];
    
    return array;
}

+ (NSArray*)arrayForEachWithArray:(NSArray*)array doing:(ArrayUtilForEach)doing
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id object in array) {
        id result = doing(object);
        if (result != nil) {
            [resultArray addObject:result];
        }
    }
    return resultArray;
}

+ (NSArray*)arrayForEachWithArray:(NSArray*)array decompressArray:(BOOL)decompressArray doing:(ArrayUtilForEach)doing
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id object in array) {
        id result = doing(object);
        if (result != nil) {
            if (decompressArray == YES && [result isKindOfClass:[NSArray class]]) {
                [resultArray addObjectsFromArray:result];
            } else {
                [resultArray addObject:result];
            }
        }
    }
    return resultArray;
}

+ (void)eachOneWithArray:(NSArray*)array doing:(ArrayUtilEachOne)doing
{
    int i=0;
    for (id object in array) {
        doing(object, i);
        i++;
    }
}

+ (void)repeat:(int)count doing:(ArrayUtilForRepeat)doing
{
    for (int i=0; i < count; i++) {
        doing(i);
    }
}

+ (NSMutableArray*)arrayWithRepeat:(NSUInteger)count eachOne:(ArrayUtilForArrayRepeat)doEach
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i < count; i++) {
        id object = doEach(i);
        [array addObject:object];
    }
    return array;
}

+ (void)copyValuesFromEntity:(id)fromEntity toEntity:(id)toEntity forProperties:(NSArray*)properties
{
    for (NSString* key in properties) {
        id value = [fromEntity valueForKey:key];
        [toEntity setValue:value forKey:key];
    }
}

+ (id)filterFirstObjectInArray:(NSArray*)array checking:(ArrayUtilCheckFirstObject)checking
{
    id result = nil;
    int i=0;
    for (id object in array) {
        if (checking(object, i) == YES) {
            result = object;
            break;
        }
        i++;
    }
    return result;
}

+ (NSArray*)filterObjectsInArray:(NSArray*)array checking:(ArrayUtilFilterObjects)checking
{
    NSMutableArray *result = [NSMutableArray array];
    
    int i = 0;
    for (id object in array) {
        if (checking(object, i)) {
            [result addObject:object];
        }
        i++;
    }
    return result;
}

+ (void)eachWithArray1:(NSArray*)array1 array2:(NSArray*)array2 doing:(ArrayUtilEachForTwoArrays)doing
{
    assert([array1 count] == [array2 count]);
    
    int i=0;
    for (id object1 in array1) {
        id object2 = [array2 objectAtIndex:i];
        doing(object1, object2, i);
        i++;
    }
}

+ (NSNumber*)sumEntities:(NSArray*)entities forKey:(NSString*)key
{
    NSArray *array = [[self class] getValuesFromEntitiesWithKey:key inArray:entities];
    return [[self class] sumWithArray:array];
}

+ (NSNumber*)sumEntities:(NSArray*)entities forKey:(NSString*)key checking:(ArrayUtilSumEnities)checking
{
    NSArray *array = [[self class] arrayForEachWithArray:entities doing:^id(id object) {
        if (checking(object)) {
            return object;
        }
        return nil;
    }];
    return [[self class] sumWithArray:array];
}

+ (NSNumber*)sumWithArray:(NSArray*)array
{
    double result = 0;
    for (NSNumber *number in array) {
        result += [number doubleValue];
    }
    return @(result);
}

+ (NSArray*)copyArray:(NSArray*)array forCount:(NSUInteger)count doing:(ArrayUtilCopyArrayForCount)doing
{
    NSMutableArray *result = [NSMutableArray array];
    
    [[self class] repeat:count doing:^(int i) {
        [result addObjectsFromArray:[[self class] arrayForEachWithArray:array doing:^id(id object) {
            return doing(object, i);
        }]];
    }];
    
    return result;
}

+ (NSMutableArray*)splitFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex inArray:(NSArray*)array
{
    NSMutableArray *result = [NSMutableArray array];
    
    if (toIndex >= [array count]) {
        toIndex = [array count] - 1;
    }
    
    for (int i=fromIndex; i<=toIndex; i++) {
        [result addObject:[array objectAtIndex:i]];
    }
    
    return result;
}

+ (int)findIndexInArray:(NSArray*)array doing:(ArrayUtilFindIndex)doing
{
    int i = 0;
    for (id object in array) {
        if (doing(object, i)) {
            return i;
        }
        i++;
    }
    return NSNotFound;
}

// 根据key，比较newArray跟baseArray,得到newArray中不在baseArray中的新对象。
+ (NSMutableArray*)diffArrayWithBaseArray:(NSArray*)baseArray newArray:(NSArray*)newArray forKey:(NSString*)key
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (id newObject in newArray) {
        NSString *value = [newObject valueForKey:key];
        
        BOOL isFound = NO;
        
        for (id baseObject in baseArray) {
            if ([value isEqual:[baseObject valueForKey:key]]) {
                isFound = YES;
                break;
            }
        }
        
        if (isFound == NO) {
            [result addObject:newObject];
        }
    }
    
    return result;
}

// 根据index获取数组中的值，如果超过边界，则循环从数组的开头取值
+ (id)getLoopValueInArray:(NSArray*)array atIndex:(NSUInteger)index
{
    int count = [array count];
    if (count == 0) {
        return nil;
    }
    
    int loopIndex = index > count - 1 ?  (index % count) : index;
    
    return [array objectAtIndex:loopIndex];
}

+ (CGFloat)getMaxFloatValueInArray:(NSArray*)array doing:(ArrayUtilGetMaxValueInArray)doing
{
    return [[self class] getMaxFloatValueInArray:array minValue:CGFLOAT_MIN doing:doing];
}

+ (CGFloat)getMaxFloatValueInArray:(NSArray*)array minValue:(CGFloat)minValue doing:(ArrayUtilGetMaxValueInArray)doing
{
    CGFloat value = minValue;
    
    int i = 0;
    for (id object in array) {
        value = MAX(value , doing(object, i));
        i++;
    }
    return value;
}

+ (CGFloat)getMinFloatValueInArray:(NSArray*)array doing:(ArrayUtilGetMinValueInArray)doing
{
    return [[self class] getMinFloatValueInArray:array maxValue:CGFLOAT_MAX doing:doing];
}

+ (CGFloat)getMinFloatValueInArray:(NSArray*)array maxValue:(CGFloat)maxValue doing:(ArrayUtilGetMinValueInArray)doing
{
    CGFloat value = maxValue;
    
    int i = 0;
    for (id object in array) {
        value = MIN(value , doing(object, i));
        i++;
    }
    return value;
}

+ (BOOL)existInArray:(NSArray*)array checking:(ArrayUtilExistInArray)checking
{
    int i = 0;
    for (id object in array) {
        if (checking(object, i)) {
            return YES;
        }
        i++;
    }
    return NO;
}

+ (NSMutableArray*)arrayWithJoinManyObjects:(id)array1, ...
{
    NSMutableArray *array = [NSMutableArray array];
    va_list args;
    va_start(args, array1);
    for (id arg = array1; arg != nil; arg = va_arg(args, id))    {
        if ([arg isKindOfClass:[NSArray class]]) {
            [array addObjectsFromArray:arg];
        } else {
            [array addObject:arg];
        }
    }
    va_end(args);
    
    return array;
}

+ (void)splitArray:(NSArray*)array countPerSection:(int)countPerSection doing:(ArrayUtilSplitArray)doing
{
    int total = [array count];
    if (total <= 0) {
        return;
    }
    
    int sectionTotal = ceilf((CGFloat)total / (CGFloat)countPerSection);
    for (int i=0; i<sectionTotal; i++) {
        int length = countPerSection;
        int fromIndex = countPerSection * i;
        int toIndex = countPerSection * (i + 1) - 1;
        if (toIndex >= total) {
            length = countPerSection - (toIndex+1 - total);
            toIndex = total - 1;
        }
        NSArray *sectionArray = [array subarrayWithRange:NSMakeRange(fromIndex, length)];
        doing(sectionArray, i, fromIndex, toIndex);
    }
    
}

+ (void)splitArray:(NSArray*)array countPerSection:(int)countPerSection step:(int)step doing:(ArrayUtilSplitArray)doing
{
    int total = [array count];
    if (total <= 0) {
        return;
    }
    
    int i = 0;
    int fromIndex = 0;
    int toIndex = countPerSection - 1;
    int length = countPerSection;
    
    while (fromIndex <= total - 1) {
        
        if (toIndex >= total) {
            length = length - (toIndex+1 - total);
            toIndex = total - 1;
        }
        
        // split:
        NSArray *sectionArray = [array subarrayWithRange:NSMakeRange(fromIndex, length)];
        doing(sectionArray, i, fromIndex, toIndex);
        
        // for next
        length += step;
        fromIndex = toIndex + 1;
        toIndex = fromIndex + length -1;
        i++;
    }
    
}

+ (int)findIndexInAllSectionsWithIndexPath:(NSIndexPath*)indexPath inArray:(NSArray*)array
{
    NSParameterAssert(indexPath != nil);
    int section = indexPath.section;
    int row = indexPath.row;
    
    if (section == 0) {
        return row;
    }
    
    int result = row;
    
    while (section--) {
        result += [[array objectAtIndex:section] count];
    }
    
    
    return result;
}

@end
