//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

- (id)init {
    self = [super init];
    if(self) {
        _contatos = [NSMutableArray new];
    }
    return self;
}

// SINGLETON
+ (ContatoDao *)contatoDaoInstance {
    if(!defaultDao) {
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}
// --

- (void)adicionaContato: (Contato *) contato {
    [self.contatos addObject:contato];
    NSLog(@"Contato adicionado: %@", contato);
}

- (void)removeContatoDaPosicao: (NSInteger) posicao {
    [self.contatos removeObjectAtIndex:posicao];
}

- (NSInteger)total {
    return self.contatos.count;
}

- (Contato *)contatoDaPosicao:(NSInteger) index {
    //return [_contatos objectAtIndex:index];
    return _contatos[index];
}

- (NSInteger)buscaPosicaoDoContato:(Contato *) contato {
    return [self.contatos indexOfObject:contato];
}

- (NSArray *)lista {
    return self.contatos;
}

@end
