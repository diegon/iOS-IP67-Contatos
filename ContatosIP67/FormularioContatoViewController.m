//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()
//@property (strong) NSMutableArray *contatos; // poderia colocar aqui
@end

@implementation FormularioContatoViewController

// SOBRESCRITA DE CONSTRUTOR DEFAULT
// storyboard NAO CHAMA este
// xib CHAMA este
// um typedef de NSObject * é o id
- (id) init {
    self = [super init];
    if(self) {
        // Movido para ContatoDao
        //self.contatos = [NSMutableArray new];
    }
    return self;
}

// CONSTRUTOR COM PARAMETROS
// storyboard CHAMA este
// xib NAO CHAMA este
- (id) initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if(self) {
        // Movido para ContatoDao
        //self.contatos = [NSMutableArray new];
        self.dao = [ContatoDao contatoDaoInstance];
    }
    return self;
}
//--

- (void)viewDidLoad {
    // é rodado uma unica vez no ciclo de vida do formulario
    //self.contatos = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pegaDadosDoFormulario {
    
    Contato *contato = [Contato new];
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    //[self.contatos addObject:contato];
    [self.dao adicionaContato:contato];
    
    // para um array o description já itera automaticamente.
    //NSLog(@"Array: %@", self.contatos);
    // poderia ser:
    /*
    for (NSString *contato in contatos) {
        NSLog(@"%@", contato);
    }
    */
    NSLog(@"Array: %@", self.dao.contatos);
    //NSLog(@"Array lenght: %lu", self.contatos.count);
    NSLog(@"Array lenght: %lu", self.dao.contatos.count);
    
    /*
    NSLog(@"Dados: %@", [contato description]); // o metodo description é análogo ao toString
    // podemos fazer NSLog(@"Dados: %@", contato) que vai invocar o description automaticamente
    */
}

@end
