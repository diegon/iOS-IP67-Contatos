//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"
#import "AppDelegate.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

- (id)init {
    self = [super init];
    if(self) {
        // Com persistencia em array local
        //_contatos = [NSMutableArray new];
        
        // Com persistencia em banco de dados
        // -- insere dados default para o app
        [self inserirDados];
        [self carregarContatos];
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

// -- Usando core data
- (Contato *)criaNovo {
    AppDelegate *appDelegate = [ContatoDao obterAppDelegate];
    
    Contato *novo = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                  inManagedObjectContext:appDelegate.managedObjectContext];
    
    return novo;
}

- (void)saveContext {
    [[ContatoDao obterAppDelegate] saveContext];
}

+ (AppDelegate *)obterAppDelegate {
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *appDelegate = (AppDelegate *) app.delegate;
    
    return appDelegate;
}

- (void)inserirDados {
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    if(!dadosInseridos) {
        Contato *caelumSP = [self criaNovo];
        caelumSP.nome = @"Caelum SP";
        caelumSP.email = @"contato@caelum.com.br";
        caelumSP.endereco = @"Rua Vergueiro, 3185 - Sao Paulo";
        caelumSP.telefone = @"1155712751";
        caelumSP.site = @"http://www.caelum.com.br";
        caelumSP.latitude = [NSNumber numberWithDouble:-23.5883034];
        caelumSP.longitude = [NSNumber numberWithDouble:-46.632369];
        caelumSP.foto = [UIImage imageNamed:@"default_user.png"];
        
        [self saveContext];
        [configuracoes setBool:YES forKey:@"dados_inseridos"];
        [configuracoes synchronize];
    }
}

- (void)carregarContatos {
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    buscaContatos.sortDescriptors = @[ordenarPorNome];
    NSArray *contatosImutaveis = [[[ContatoDao obterAppDelegate] managedObjectContext] executeFetchRequest:buscaContatos error:nil];
    _contatos = [contatosImutaveis mutableCopy];
}
// --

@end
