# ADR 002: Architettura Compute (Bastion VM)

## Contesto
Nella Fase 2, avevamo bisogno di una risorsa di calcolo base (Bastion/Jump-box) situata all'interno della Virtual Network per amministrare in sicurezza i cluster (Fase 6) e validare il comportamento della rete, limitando al massimo la superficie d'attacco.

## Decisione
- **Sistema Operativo**: È stata scelta un'immagine `Ubuntu 22.04 LTS` fornita da Canonical. È lo standard di mercato, perfettamente supportata in Azure, e compatibile con tutti i tool cloud-native.
- **SKU della Macchina Virtuale**: Per l'ambiente di sviluppo (`dev`), abbiamo optato per `Standard_B1s`. Si tratta di un'istanza "Burstable" estremamente economica, sufficiente per fare da jump-box o per lanciare container di test a basso consumo.
- **Autenticazione SSH**: Disabilitato completamente l'accesso tramite password, l'unico metodo supportato è l'accesso con chiave pubblica SSH. La chiave viene passata dinamicamente tramite le variabili Terraform.
- **Identità (Managed Identity)**: Abbiamo abilitato un'identità assegnata dal sistema (`SystemAssigned`). Questo permetterà alla VM in futuro di accedere alle risorse di Azure (es. Azure Key Vault o Azure Storage) senza dover gestire e iniettare staticamente credenziali e secret.
- **Estensione Custom Script**: La VM esegue al boot uno script minimo che installa e abilita il demone Docker, aggiungendo l'utente di base al gruppo `docker`. In questo modo la macchina è già pronta per ospitare test veloci con container non appena viene provisionata.

## Conseguenze (Trade-off)
- **Prestazioni vs Costo**: La F2ads_v7 è una soluzione di compromesso a causa della mancanza della serie B, e i costi potrebbero essere leggermente superiori al previsto.
- **Tempi di provisioning**: La presenza dell'estensione "CustomScript" aggiunge 1-2 minuti al tempo di esecuzione di `terraform apply`. In scenari di produzione più complessi, si dovrebbe optare per strumenti come Packer per creare immagini "Golden" pre-configurate, ma per ora il Custom Script è un ottimo compromesso tra semplicità ed efficienza per un ambiente di dev.

## Problemi incontrati e risoluzioni
- **SKU VM**: La region `Italy North` non dispone della serie B (inizialmente avevamo scelto `Standard_B1s`). Abbiamo quindi dovuto optare per `Standard_F2ads_v7` che era disponibile.
- **Generazione Immagine (Gen2)**: La VM della serie v7 richiede obbligatoriamente un'immagine Gen2. Abbiamo modificato l'SKU dell'immagine Ubuntu aggiungendo il suffisso `-gen2` (`22_04-lts-gen2`).
- **Indirizzo IP Dinamico (NSG)**: La regola Network Security Group per autorizzare l'accesso SSH è ristretta al nostro IP. Poiché spesso le connessioni domestiche hanno IP dinamico, occorre ricordarsi di aggiornare la variabile Terraform qualora l'IP dovesse cambiare, per evitare timeout della connessione.
