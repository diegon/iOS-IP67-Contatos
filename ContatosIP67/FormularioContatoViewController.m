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
//@property Contato *contato;
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
    UIBarButtonItem *botaoAdd = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
    
    // @[] é um atalho para criar um array imutavel
    // @"" é um atalho para criar uma string
    // obtendo o navigation bar e adicionando botao na direita
    self.navigationItem.rightBarButtonItems = @[botaoAdd];
    self.navigationItem.title = @"Novo";
    
    if(self.contato) {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pegaDadosDoFormulario {
    
    // movido para metodo criaContato
    //Contato *contato = [Contato new];
    
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    
    //[self.contatos addObject:contato];
    // movido para metodo criaContato
    //[self.dao adicionaContato:contato];
    
    // para um array o description já itera automaticamente.
    //NSLog(@"Array: %@", self.contatos);
    // poderia ser:
    /*
    for (NSString *contato in contatos) {
        NSLog(@"%@", contato);
    }
    */
    //NSLog(@"Array: %@", self.dao.contatos);
    //NSLog(@"Array lenght: %lu", self.contatos.count);
    //NSLog(@"Array lenght: %lu", self.dao.contatos.count);
    
    /*
    NSLog(@"Dados: %@", [contato description]); // o metodo description é análogo ao toString
    // podemos fazer NSLog(@"Dados: %@", contato) que vai invocar o description automaticamente
    */
}

- (void)criaContato {
    
    // adicionando o contato
    self.contato = [Contato new];
    [self pegaDadosDoFormulario];
    [self.dao adicionaContato:self.contato];
    
    NSLog(@"Array lenght: %lu", self.dao.contatos.count);
    
    // criando e apresentando um alert
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Titulo" message:@"Mensagem" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    */
    
    // removendo eu mesmo da pilha de telas, para retornar a anterior
    [self.navigationController popViewControllerAnimated:YES];
    
    // Volta para o root view controller destruindo todas as janelas empurradas (pushed)
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
