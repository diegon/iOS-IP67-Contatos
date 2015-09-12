//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface ContatoDao : NSObject

@property (readonly) NSMutableArray *contatos;
- (void)adicionaContato:(Contato *) contato;
+ (ContatoDao *)contatoDaoInstance;

@end
