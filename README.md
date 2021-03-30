<p align="center">
  <a href="https://github.com/bittencourtthulio/AWS4D/blob/main/assets/logo.fw.png">
    <img alt="router4d" src="https://github.com/bittencourtthulio/AWS4D/blob/main/assets/logo.fw.png">
  </a>  
</p>
<br>
<p align="center">
  <img src="https://img.shields.io/github/v/release/bittencourtthulio/AWS4D?style=flat-square">
  <img src="https://img.shields.io/github/stars/bittencourtthulio/AWS4D?style=flat-square">
  <img src="https://img.shields.io/github/forks/bittencourtthulio/AWS4D?style=flat-square">
  <img src="https://img.shields.io/github/contributors/bittencourtthulio/AWS4D?color=orange&style=flat-square">
   <img src="https://tokei.rs/b1/github/bittencourtthulio/AWS4D?color=red&category=lines">
  <img src="https://tokei.rs/b1/github/bittencourtthulio/AWS4D?color=green&category=code">
  <img src="https://tokei.rs/b1/github/bittencourtthulio/AWS4D?color=yellow&category=files">
</p>


<p align="center">
  <b>AWS4Delphi</b> é uma biblioteca Delphi desenvolvida para consumo dos recursos da API de serviços da <a href="https://aws.com/">AWS</a>, dando a possibilidade de integração simples com diversos serviços. Atualmente homologado apenas o envio de arquivos para o AWS S3, porém com possibilidade de expansão, fique a vontade para enviar suas contribuições.

# AWS4D
Biblioteca para trabalhar com Recursos da Amazon AWS no Delphi


## ⚙️ Instalação 

*Pré requisitos: Delphi XE2


* **Instlação manual**: Adicione as seguintes pastas ao seu projeto, em *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*

```
../AWS4D/src
```

## ⚡️ Como utilizar para Enviar uma Imagem para o AWS S3
#### Pode ser usado para qualquer tipo de arquivo, basta alterar o ContentType

```pascal
uses
  AWS4D;

implementation


const
  //Informações geradas no AWS Console
  AccountKey = 'Chave da sua Credencial IAM';
  AccountName = 'Name da sua Credencial IAM';
  StorageEndPoint = 'EndPoint da Region do seu Bucket S3 Ex: s3.sa-east-1.amazonaws.com';
  Bucket = 'Nome do seu bucket s3'

  TAWS4D
      .New
        .Credential
            .AccountKey(AccountKey)
            .AccountName(AccountName)
            .StorageEndPoint(StorageEndPoint)
            .Bucket(Bucket)
          .&End
        .S3
          .SendFile
            .FileName('nome do arquivo para ser salvo no s3 incluindo a extensão')
            .ContentType('content type do arquivo Ex: 'image/jpeg')
            .FileStream('Variavel do Tipo TBytesStream do seu arquivo e/ou Componente TImage')
          .Send
        .ToString; //Retornar o Endereço do Arquivo no S3 para você acessar diretamente
```


## ⚡️ Como utilizar para Baixar uma Imagem para o AWS S3
#### Pode ser usado para qualquer arquivo, basta no final chamar a função ToBytesStream no lugar do FromImage e tratar o Stream da forma que desejar

```pascal
uses
  AWS4D;

implementation


const
  //Informações geradas no AWS Console
  AccountKey = 'Chave da sua Credencial IAM';
  AccountName = 'Name da sua Credencial IAM';
  StorageEndPoint = 'EndPoint da Region do seu Bucket S3 Ex: s3.sa-east-1.amazonaws.com';
  Bucket = 'Nome do seu bucket s3'

  TAWS4D
      .New
        .Credential
            .AccountKey(AccountKey)
            .AccountName(AccountName)
            .StorageEndPoint(StorageEndPoint)
            .Bucket(Bucket)
          .&End
        .S3
          .GetFile
            .FileName('Endereço completo do arquivo na aws')
          .Get
        .FromImage(aImage); //Carrega automaticamente o Retorno dentro de um TImage
```
