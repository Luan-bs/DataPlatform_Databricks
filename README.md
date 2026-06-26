## Estrutura de Pastas

```
Workspace
└── Repos
    └── Data Platform
            ├── notebooks
            │   ├── glpi
            │   ├── senior
            │   ├── crm
            │   └── common
            ├── sql
            │   ├── glpi
            │   └── senior
            ├── jobs
            ├── dashboards
            ├── experiments
            └── docs

Catalog
└── workspace
    └── glpi (Schema)
          └── Volumes 
                ├── bronze_tickets
                ├── bronze_users
                ├── ...
                │
                ├── silver_tickets
                ├── silver_users
                ├── ...
                │
                ├── d_status
                ├── d_users
                ├── f_tickets
                ├── f_ticketsatisfaction
                └── p_tickets_users
        
```