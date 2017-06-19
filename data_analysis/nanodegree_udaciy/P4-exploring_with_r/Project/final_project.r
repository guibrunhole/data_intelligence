# TÃTULO por SEU_NOME_AQUI
========================================================
  
  ```{r echo=FALSE, message=FALSE, warning=FALSE, packages}
# Carregue aqui todos os pacotes utilizados 
# na sua anÃ¡lise realizada neste arquivo fonte.

# Note que o parÃ¢metro "echo" foi definido como FALSE neste cÃ³digo.
# Isso previne que o cÃ³digo apresente resultados formatados em HTML.
# VocÃª deve definir echo=FALSE para todos os blocos de cÃ³digo no seu arquivo.

library('ggplot2')
```

```{r echo=FALSE, Load_the_Data}
# Carregamento dos dados
///
```

# SeÃ§Ã£o de GrÃ¡ficos Univariados
```{r echo=FALSE, Univariate_Plots}

```

# AnÃ¡lise Univariada

### Qual Ã© a estrutura do conjunto de dados?
str(wineQualityReds)
head(wineQualityReds)

### Quais sÃ£o os principais atributos de interesse deste conjunto de dados?
cor(wineQualityReds)[,'quality'] # três principais

### Quais outros atributos vocÃª acha que podem lhe auxiliar na investigaÃ§Ã£o destes atributos de interesse?
summary(wineQualityReds) ## criar um histograma com as variaveis

### VocÃª criou novas variÃ¡veis a partir dos atributos existentes no conjunto de dados?
summary(lm(quality~.,data=wineQualityReds[,c('pH','quality')])) 
        ## ver variaveis que influenciam na qualidade

### Dos atributos investigados, distribuiÃ§Ãµes incomuns foram encontradas? VocÃª aplicou operaÃ§Ãµes nos dados para limpÃ¡-los, ajustÃ¡-los ou mudar a forma dos dados? Se sim, por quÃª?
## provavelmente nao


# SeÃ§Ã£o de GrÃ¡ficos Bivariados
```{r echo=FALSE, Bivariate_Plots}
## plot de graficos juntos.. dispersao entre a qualidade e as demais variaveis
```

# AnÃ¡lise Bivariada

### Discuta sobre alguns dos relacionamentos observados nesta parte da investigaÃ§Ã£o. Como os atributos de interesse variaram no conjunto de dados?

### VocÃª observou algum relacionamento interessante entre os outros atributos (os que nÃ£o sÃ£o de interesse)?

### Qual foi o relacionamento mais forte encontrado?




# SeÃ§Ã£o de GrÃ¡ficos Multivariados

```{r echo=FALSE, Multivariate_Plots}

```

# AnÃ¡lise Multivariada

### Discuta sobre os relacionamentos observados nesta parte da investigaÃ§Ã£o. Quais atributos que fortaleceram os demais na observaÃ§Ã£o das variÃ¡veis de interesse?

### InteraÃ§Ãµes surpreendentes e/ou interessantes foram encontradas entre os atributos?

### OPCIONAL: Modelos foram criados usando este conjunto de dados? Discuta sobre os pontos fortes e as limitaÃ§Ãµes do seu modelo.

------
  
  # GrÃ¡ficos Finais e SumÃ¡rio
  
  ### Primeiro GrÃ¡fico
  ```{r echo=FALSE, Plot_One}

```

### DescriÃ§Ã£o do Primeiro GrÃ¡fico


### Segundo GrÃ¡fico
```{r echo=FALSE, Plot_Two}

```

### DescriÃ§Ã£o do Segundo GrÃ¡fico


### Terceiro GrÃ¡fico
```{r echo=FALSE, Plot_Three}

```

### DescriÃ§Ã£o do Terceiro GrÃ¡fico

------
  
  # ReflexÃ£o
  
  