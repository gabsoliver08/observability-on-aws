# Trilha de Observabilidade com Particionamento de Dados

Esta é uma trilha de observabilidade que utiliza uma combinação de serviços da AWS para coletar, processar e analisar logs, métricas e eventos, proporcionando insights valiosos sobre o estado e o desempenho dos sistemas.

## Visão Geral

Esta trilha de observabilidade é composta por diversos componentes e serviços da AWS, trabalhando juntos para fornecer uma solução completa de monitoramento e análise de dados. Os principais componentes incluem:

- Amazon CloudWatch: Utilizado para coletar logs, métricas e eventos.
- Amazon Kinesis Data Firehose: Responsável por receber os logs do CloudWatch, processar os registros com uma função Lambda e enviá-los para o Amazon S3, mantendo o particionamento dos dados.
- AWS Lambda: Função de transformação que processa e transforma os registros antes de serem enviados para o Kinesis Data Firehose.
- Amazon S3: Armazena os dados brutos de log e métrica, particionados de acordo com as chaves geradas.
- AWS Glue: Cria um catálogo de metadados para os dados armazenados no S3.
- Amazon Athena: Permite executar consultas SQL interativas para análise de dados no S3.

## Configuração

Siga os passos abaixo para configurar e implantar a trilha de observabilidade com particionamento de dados:

1. **Crie um Token de Acesso Pessoal**: Crie um token de acesso pessoal no GitHub para autenticação ao fazer push do código.

2. **Clonar o Repositório**: Clone este repositório em sua máquina local:

   ```bash
   git clone https://github.com/gabsoliver08/observability-on-aws.git

Infraestrutura como Código: Utilize o Terraform para criar a infraestrutura necessária na AWS. Certifique-se de ter as credenciais da AWS configuradas corretamente.

```
cd terraform
terraform init
terraform apply
```

Implantação da Função Lambda: Implemente sua função Lambda de transformação para processar os registros antes de serem enviados para o Kinesis Data Firehose.

Configuração do Kinesis Data Firehose: Configure o Amazon Kinesis Data Firehose para consumir dados do CloudWatch Logs Subscription Filter, usar a função Lambda de transformação e enviar os dados particionados para o Amazon S3.

Execução e Análise: Após a configuração, seus logs serão coletados, processados, particionados e armazenados no S3. Você poderá usar o Athena para executar consultas SQL e analisar os dados particionados.

Contribuição
Sinta-se à vontade para contribuir com melhorias, correções ou novos recursos para esta trilha de observabilidade. Abra uma issue para discutir ideias ou envie um pull request com suas alterações.

Licença
Este projeto está licenciado sob a licença MIT.

