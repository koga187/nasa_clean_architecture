# Data sources

Trabalha com os modelos externos, um data source sempre retornará um modelo.

Ele trata da conversão dos dados dos modelos do app para os modelos da API e vice versa, retornando sempre um modelo, ou disparando uma Exception em caso de erro.

## Inputs

Recebe o modelos da camanda de dominio do app ou input de filtros.

## Processamento

Pega os inputs e transforma eles para o modelo de dominio externo.
Envia para o gateway externo pega o retorno.

## Outputs

Ele só retorna modelos conhecidos pela camada de dominio do app.

## Retorno Sucesso

Retorna um modelo conhecido pela camada de dominio do app.

## Retorno Erro

Dispara Exception que deverá ser tratada na camada do repository.
