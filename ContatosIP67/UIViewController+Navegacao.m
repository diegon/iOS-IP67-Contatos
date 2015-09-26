//
//  UIViewController+Navegacao.m
//  ContatosIP67
//
//  Created by ios5380 on 26/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "UIViewController+Navegacao.h"

@implementation UIViewController (Navegacao)

- (UINavigationController *)comBarrinha {
    UINavigationController *barrinha = [[UINavigationController alloc] initWithRootViewController:self];
    return barrinha;
}

@end
