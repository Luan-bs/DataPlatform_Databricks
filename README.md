# Data Platform - GLPI (Databricks)

## Objetivo

Este projeto tem como objetivo construir uma plataforma de dados moderna utilizando o ecossistema Databricks, aplicando conceitos de Data Lakehouse, Delta Lake, Unity Catalog, Spark e Workflows.

Como caso de estudo foi utilizado o GLPI, porém toda a estrutura foi pensada para ser reutilizada futuramente com outras fontes de dados (Senior ERP, CRM, APIs, etc.).

---

# Arquitetura

```
 glpi(catalog)
    
       CSV
        │
        ▼
Volumes (Raw) -- Esta camada pode ser direta da fonte (glpi Mysql)
        │
        ▼
Bronze (Delta) 
        │
        ▼
Silver (Delta)
        │
        ▼
Gold (Modelo Dimensional)
        │
        ▼
Dashboards / Power BI / IA
```

---

# Tecnologias

* Databricks Free Edition
* Unity Catalog
* Delta Lake
* Apache Spark
* Spark SQL
* Databricks Workflows
* Databricks SQL
* Volumes

---

# Estrutura do Workspace

```
Workspace
├── Repos
│    └── Data Platform
│        ├── notebooks
│        │   ├── glpi
│        │   ├── senior
│        │   ├── crm
│        │   └── common
│        ├── sql
│        │   ├── glpi
│        │   └── senior
│        ├── jobs
│        ├── dashboards
│        ├── experiments
│        └── docs

```

---

# Unity Catalog

Foi utilizado um único catálogo chamado:

```
glpi
```

Schema:

```
glpi.bronze / glpi.silver / glpi.gold_chamados
```

Todas as tabelas nos schemas estão no padrão delta.

---

# Volumes

Foi criado apenas o volume Raw.

```
workspace (Espaço de trabalho)
    └──  Unity Catalog (seção sidebar = Catalog)
            └── glpi (catalog)
                │
                ├── bronze (Schema)
                │   ├── Volumes 
                │   │    └── raw
                │   │        ├── glpi_tickets.csv
                │   │        ├── glpi_users.csv
                │   │        ├── ...
                │   ├── glpi_tickets
                │   ├── glpi_users
                │   ├── ...               │   
                │   
                ├── silver (Schema)
                │        ├── tickets
                │        ├── users
                │        ├── ...
                │
                ├── gold_chamados (Schema)
                        ├── d_status
                        ├── d_users
                        ├── f_tickets
                        ├── f_ticketsatisfaction
                        └── p_tickets_users
```

Os arquivos Bronze, Silver e Gold **não** são armazenados em Volumes.

Essas camadas são gravadas diretamente como Delta Tables no Unity Catalog.

---

# Camada Bronze

Responsável apenas pela ingestão.

Processo:

* Leitura dos CSVs
* Inferência de schema (ambiente de estudo)
* Escrita em formato Delta

Tabelas:

```
glpi_tickets

glpi_users

glpi_tickets_users

glpi_tickets_tickets

glpi_ticketsatisfactions
```

Nenhuma transformação é realizada nesta etapa.

---

# Camada Silver

Responsável pela padronização dos dados.

Principais transformações:

* Remoção de duplicidades
* Seleção da versão mais recente dos registros
* Renomeação de colunas
* Padronização de tipos
* Conversão de datas
* Criação de atributos derivados
* Exclusão de chamados de teste

Tabelas:

```
tickets

users

ticket_users

tickets_tickets

ticketsatisfactions
```

Toda a lógica foi implementada utilizando Spark SQL.

---

# Camada Gold

Modelo dimensional para consumo analítico do modelo de negócio.

### Mart Chamados 

Dimensões

```
d_status

d_users
```

Fatos

```
f_tickets

f_ticketsatisfaction
```

Ponte

```
p_tickets_users
```

A modelagem preserva todos os relacionamentos entre tickets e usuários, permitindo análises de solicitantes, técnicos e demais participantes.

---

# Workflow

Foi criado um Workflow na seção Jobs and Pipelines chamado:

```
GLPI Pipeline
```

Fluxo:

```
 Bronze
    │
    ▼
 Silver
    │
    ▼
  Gold
```

O Workflow executa automaticamente todos os dias às 12:00.

---

# Dashboards

As consultas SQL são criadas no SQL Editor.

Arquivo json em dashboards/

Essas consultas alimentam os Dashboards do Databricks. 

Exemplos:

* Tickets por Status
* Tickets por Prioridade
* Tempo Médio de Resolução
* Tickets por Dia

---

# Consumo

Os dados podem ser consumidos por:

* Databricks Dashboards
* Power BI
* Ferramentas SQL
* Modelos de IA
* APIs

---

# Próximos Passos

* Auto Loader
* Data Quality
* SQL Warehouse dedicado
* Integração com Power BI
* Ingestão do Senior ERP
* Novas fontes de dados

---

# Estrutura Final

```
CSV

        │

        ▼

Volumes (Raw)

        │

        ▼

Bronze

        │

        ▼

Silver

        │

        ▼

Gold

        │

        ├────────► Dashboards Databricks

        ├────────► Power BI

        ├────────► IA

        └────────► APIs
```

---

## Objetivo do Projeto

Este projeto foi desenvolvido como uma base escalável para uma plataforma de dados. A arquitetura segue os princípios do Lakehouse utilizando Delta Lake e Unity Catalog, permitindo adicionar novas fontes de dados sem alterar a estrutura existente. Cada nova origem (como Senior ERP, CRM ou APIs) poderá reutilizar o mesmo padrão de ingestão, transformação, modelagem e orquestração implementado para o GLPI.
