# 003 - Scelta di PostgreSQL Flexible Server e VNet Integration

## Data
2026-07-09

## Status
Accettata

## Contesto
Abbiamo bisogno di un database relazionale per il progetto, che sia gestito e non richieda manutenzione operativa (es. patching OS, backup manuali), ma che garantisca alta sicurezza isolandosi dalla rete pubblica.

## Decisione
Abbiamo scelto di utilizzare **Azure Database for PostgreSQL Flexible Server**. 
Per quanto riguarda la sicurezza di rete, abbiamo optato per la **VNet Integration** (tramite subnet delegation `Microsoft.DBforPostgreSQL/flexibleServers`) accoppiata a una **Private DNS Zone**. 

## Conseguenze
- **Sicurezza:** Il database non avrà un IP pubblico. Sarà raggiungibile esclusivamente dalle risorse presenti all'interno della Virtual Network (come la VM Bastion o futuri nodi AKS).
- **Integrazione:** Richiede che una subnet dedicata (data-subnet) sia delegata a PostgreSQL, e la risoluzione del nome host (FQDN) avverrà tramite Private DNS Zone collegata alla VNet.
- **Costi:** Flexible Server offre l'opzione Burstable (es. `B_Standard_B1ms`) che è ideale e molto economica per gli ambienti di sviluppo.

## Note aggiuntive (Post-Implementazione)
- **Gestione Segreti:** La password di amministrazione del database (`admin_password`) è stata definita come variabile marcata `sensitive` in Terraform. In uno scenario di produzione reale, questa password dovrebbe essere generata e gestita tramite **Azure Key Vault** (utilizzando ad esempio una data source Terraform per leggerla), evitando di passarla in chiaro tramite file `tfvars`.
- **Disponibilità SKU:** A differenza delle macchine virtuali della serie B, è stato confermato che la SKU `B_Standard_B1ms` per PostgreSQL Flexible Server è pienamente disponibile nella region *Italy North*.
- **Isolamento di Rete:** Sono stati effettuati e verificati test architetturali per l'isolamento di rete (NSG validation): un NSG con regole esplicite sulla `data_subnet` permette esclusivamente connessioni in ingresso sulla porta 5432 provenienti dalla `compute_subnet`, bloccando per default tutto il resto. L'accesso tramite reti pubbliche è stato esplicitamente disabilitato (`public_network_access_enabled = false`).
