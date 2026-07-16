# ADR 004: Architettura Storage (Azure Blob Storage)

## Contesto
Nella Fase 4, abbiamo aggiunto un livello di storage persistente al progetto. Serve un posto sicuro dove la VM Bastion (e futuri microservizi) possano archiviare artefatti, backup e altri file binari, senza esporre nulla al pubblico e sfruttando l'identità gestita (Managed Identity) già configurata nella Fase 2.

## Decisione

- **Storage Account**: `Standard_LRS` — la replica locale è sufficiente per un ambiente di sviluppo; per produzione si valuterà `GRS`.
- **TLS minimo 1.2**: Imposto per policy di sicurezza; versioni precedenti (TLS 1.0/1.1) sono deprecate e vulnerabili.
- **Accesso pubblico ai blob disabilitato** (`allow_nested_items_to_be_public = false`): Nessun container o blob può diventare pubblico per errore di configurazione.
- **Versioning abilitato**: Permette di recuperare versioni precedenti dei blob sovrascritti; prerequisito per la lifecycle policy sulle versioni.
- **Network Rules — default Deny**: Lo storage è raggiungibile solo dall'IP del team e dai servizi Azure fidati (`bypass = ["AzureServices"]`). Questo impedisce che sia accessibile da internet generico.
- **Due container privati**:
  - `uploads` — per file in ingresso (artefatti, immagini, asset generici)
  - `backups` — per backup automatici del database o di configurazioni
- **Lifecycle Management Policy**: Riduce i costi automaticamente:
  - Blob spostati in tier `Cool` dopo 1 giorno dall'ultima modifica
  - Blob eliminati dopo 7 giorni dall'ultima modifica
  - Versioni precedenti eliminate dopo 3 giorni
- **Role Assignment — Storage Blob Data Contributor**: La Managed Identity della VM Bastion riceve il ruolo direttamente sullo scope dello storage account, seguendo il principio del minimo privilegio (no Contributor sul Resource Group).

## Conseguenze (Trade-off)

- **Costo tier Cool**: Il passaggio a Cool dopo 1 solo giorno è aggressivo — ideale per un ambiente dev dove i file vengono raramente riletti. In produzione questa finestra andrebbe allargata (es. 30 giorni).
- **LRS vs GRS**: LRS non garantisce resilienza a failure a livello di datacenter. Accettabile per dev; da rivedere per staging/prod.
- **Naming dello storage account**: Il nome deve essere globalmente unico, massimo 24 caratteri, solo alfanumerici lowercase. La formula scelta (`<project><env>stor<location>`) può superare i 24 caratteri su regioni con nomi lunghi; in quel caso occorrerà troncare o abbreviare.
- **Network Rules e terraform apply**: Con `default_action = "Deny"`, la prima volta che si applica la configurazione la macchina Terraform deve avere il suo IP incluso in `allowed_storage_ips`, altrimenti le operazioni successive sul container (es. upload tramite AzCopy) falliranno.
