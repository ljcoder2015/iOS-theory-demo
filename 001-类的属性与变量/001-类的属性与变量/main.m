//
//  main.m
//  001-类的属性与变量
//
//  Created by cooci on 2020/9/12.
//  Copyright © 2020 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#ifdef DEBUG
#define LGLog(format, ...) printf("%s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define LGLog(format, ...);
#endif

void lgObjc_copyIvar_copyProperies(Class pClass){
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(pClass, &count);
    for (unsigned int i=0; i < count; i++) {
        Ivar const ivar = ivars[i];
        //获取实例变量名
        const char*cName = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:cName];
        LGLog(@"class_copyIvarList:%@",ivarName);
    }
    free(ivars);

    unsigned int pCount = 0;
    objc_property_t *properties = class_copyPropertyList(pClass, &pCount);
    for (unsigned int i=0; i < pCount; i++) {
        objc_property_t const property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //获取属性值
        LGLog(@"class_copyProperiesList:%@",propertyName);
    }
    free(properties);
}

// 成员变量 vs 属性
@interface LGPerson : NSObject
{
    NSString *hobby;
    NSObject *objc;
}
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) NSString *name;

@end


@implementation LGPerson

@end

#pragma mark - 各种类型编码
void lgTypes(){
    NSLog(@"char --> %s",@encode(char));
    NSLog(@"int --> %s",@encode(int));
    NSLog(@"short --> %s",@encode(short));
    NSLog(@"long --> %s",@encode(long));
    NSLog(@"long long --> %s",@encode(long long));
    NSLog(@"unsigned char --> %s",@encode(unsigned char));
    NSLog(@"unsigned int --> %s",@encode(unsigned int));
    NSLog(@"unsigned short --> %s",@encode(unsigned short));
    NSLog(@"unsigned long --> %s",@encode(unsigned long long));
    NSLog(@"float --> %s",@encode(float));
    NSLog(@"bool --> %s",@encode(bool));
    NSLog(@"void --> %s",@encode(void));
    NSLog(@"char * --> %s",@encode(char *));
    NSLog(@"id --> %s",@encode(id));
    NSLog(@"Class --> %s",@encode(Class));
    NSLog(@"SEL --> %s",@encode(SEL));
    int array[] = {1,2,3};
    NSLog(@"int[] --> %s",@encode(typeof(array)));
    typedef struct person{
        char *name;
        int age;
    }Person;
    NSLog(@"struct --> %s",@encode(Person));
    
    typedef union union_type{
        char *name;
        int a;
    }Union;
    NSLog(@"union --> %s",@encode(Union));

    int a = 2;
    int *b = {&a};
    NSLog(@"int[] --> %s",@encode(typeof(b)));
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        
         LGPerson *person = [LGPerson alloc];
         Class pClass     = object_getClass(person);
        lgTypes();
         lgObjc_copyIvar_copyProperies(pClass);

        
        NSLog(@"Hello, World!");
    }
    return 0;
}
