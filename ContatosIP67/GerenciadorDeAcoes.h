//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by ios5380 on 19/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contato.h"

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate>

@property Contato *contato;
@property UIViewController *controller;
- (id)initWithContato:(Contato *) contato;
- (void)acoesDoController:(UIViewController *) controller;

@end
