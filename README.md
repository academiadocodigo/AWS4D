<p align="center">
  <a href="https://www.pngitem.com/pimgs/m/175-1759149_aws-amazon-hd-png-download.png">
    <img alt="AWS" height="150" src="https://www.pngitem.com/pimgs/m/175-1759149_aws-amazon-hd-png-download.png">
  </a>  
</p><br>
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

```pascal
uses
  AWS4D;

implementation


const
  //Informações geradas no AWS Console
  AccountKey = 'Chave da sua Credencial IAM';
  AccountName = 'Name da sua Credencial IAM ';
  StorageEndPoint = 'EndPoint da Region do seu Bucket S3 Ex: s3.sa-east-1.amazonaws.com';
  Bucket = 'Nome do seu bucket s3'

  TAWS4D
      .New
        .S3
          .Credential
            .AccountKey(AccountKey)
            .AccountName(AccountName)
            .StorageEndPoint(StorageEndPoint)
            .Bucket(Bucket)
          .&End
          .SendFile
            .FileName('nome do arquivo para ser salvo no s3 incluindo a extensão')
            .ContentType('content type do arquivo Ex: 'image/jpeg')
            .FileStream('Variavel do Tipo TBytesStream do seu arquivo e/ou Componente TImage')
          .Send
        .ToString; //Retornar o Endereço do Arquivo no S3 para você acessar diretamente
```