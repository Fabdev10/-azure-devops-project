# ADR 001: Architettura Networking di Base

## Contesto
Abbiamo bisogno di una base di rete sicura, segmentata e scalabile su Azure per ospitare i nostri servizi di compute (VM e AKS) e i nostri servizi gestiti (PostgreSQL).

## Decisione
- **Segmentazione**: Abbiamo separato la Virtual Network in due subnet principali:
  - `compute-subnet`: Dedicata a Virtual Machines (Fase 2) e al cluster Kubernetes AKS (Fase 6). Questo garantisce che il traffico e l'allocazione degli IP dei worker node siano isolati in una porzione di rete ben definita.
  - `data-subnet`: Dedicata ai servizi dati gestiti (come PostgreSQL Flexible Server in Fase 3). Separare i dati dal compute ci permette di applicare regole di rete molto più restrittive in futuro.
- **Network Security Groups (NSG)**: Abbiamo applicato gli NSG a livello di *subnet* (non a livello di singola NIC). Questo centralizza la gestione delle regole di sicurezza e le rende chiare e manutenibili. Nella `compute-subnet` abbiamo aperto HTTP/HTTPS (per il traffico web del cluster AKS) e SSH (per il jump server/bastion VM).
- **Public IP (Standard SKU)**: È stato creato un IP Pubblico statico per la VM Bastion (Fase 2). Lo SKU Standard è stato scelto perché è quello di default moderno in Azure, offre maggiore sicurezza di default e si integra meglio con gli Standard Load Balancer (che verranno utilizzati da AKS).
- **Naming e Tagging**: Abbiamo adottato lo schema coerente `{progetto}-{ambiente}-{risorsa}-{regione}` per garantire l'immediata identificazione delle risorse e abbiamo inserito tag obbligatori di default (`Project`, `Environment`, `ManagedBy=terraform`).
- **State Remoto**: La configurazione prevede un backend `azurerm` nello storage account per condividere in sicurezza il lock e lo state tra il team e le future pipeline CI/CD (Fase 7).

## Conseguenze (Trade-off)
- **Sicurezza vs Praticità**: Attualmente `allowed_ssh_ips` è impostato a `"0.0.0.0/0"` in `terraform.tfvars` per facilitare il primo approccio, ma la best-practice richiede di bloccare questa variabile sugli IP pubblici noti del team di sviluppo.
- **Preparazione preliminare**: L'uso del backend remoto implica che lo Storage Account e il Resource Group definiti in `backend.tf` debbano essere creati *manualmente* (via portale o tramite script di bootstrap Bash/PowerShell) prima di lanciare il primissimo `terraform init`.
