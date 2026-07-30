# Software Requirements Specification
# PeakLift

> **Versione:** 1.0  
> **Stato:** Draft  
> **Piattaforma:** iOS  
> **Nome prodotto:** PeakLift  
> **Tecnologie previste:** Swift, SwiftUI, SwiftData, CloudKit, HealthKit, AI API  
> **Documento di riferimento:** Product Vision e Product Requirements Document  

---

## 1. Introduction

### 1.1 Scopo

Questo documento definisce i requisiti software di PeakLift, un'applicazione iOS AI-first dedicata allo strength training.

PeakLift consente agli utenti di registrare gli allenamenti, analizzare progressione, volume, frequenza ed equilibrio muscolare, e ricevere insight contestuali tramite un AI Coach.

Il documento descrive:

- Comportamenti attesi del sistema;
- Requisiti funzionali;
- User stories;
- Criteri di accettazione;
- Requisiti non funzionali;
- Limiti e confini dell'MVP.

---

### 1.2 Obiettivi

PeakLift deve:

- Consentire una registrazione rapida e affidabile degli allenamenti;
- Salvare workout, esercizi, serie e preferenze dell'utente;
- Calcolare metriche allenanti utili;
- Mostrare dati e trend attraverso dashboard e analytics;
- Fornire insight AI contestuali, spiegabili e prudenti;
- Supportare sincronizzazione sicura tramite CloudKit;
- Integrare opzionalmente dati di attività tramite HealthKit;
- Offrire all'utente controllo su privacy, consensi, esportazione ed eliminazione dei dati;
- Restare utilizzabile offline per le funzionalità core di tracking.

---

### 1.3 Ambito del sistema

PeakLift è un'applicazione mobile iOS progettata principalmente per utenti che praticano allenamento con pesi, bodybuilding o strength training.

Il sistema comprende:

- Onboarding e profilo utente;
- Autenticazione tramite Sign in with Apple;
- Workout logging;
- Libreria esercizi;
- Gestione serie, ripetizioni, carichi e RPE/RIR;
- Storico allenamenti;
- Dashboard;
- Analytics;
- AI Coach;
- Import CSV;
- HealthKit;
- CloudKit;
- Gestione privacy e dati.

---

### 1.4 Stakeholder

| Stakeholder | Ruolo | Interesse |
|---|---|---|
| Utente finale | Persona che usa PeakLift per allenarsi | Registrare workout, capire progressi e ricevere suggerimenti |
| Product Owner | Responsabile della direzione prodotto | Validare proposta di valore e KPI |
| Product Manager | Responsabile requisiti e roadmap | Definire priorità, scope e comportamento prodotto |
| iOS Developer | Sviluppatore dell'app | Implementare interfaccia, persistenza e integrazioni Apple |
| Backend / AI Engineer | Responsabile servizi AI e dati | Gestire AI API, sicurezza e qualità degli insight |
| UX/UI Designer | Responsabile esperienza utente | Garantire interfaccia nativa, semplice e accessibile |
| QA Engineer | Responsabile qualità | Verificare requisiti, test e regressioni |
| Privacy / Legal | Responsabile conformità | Verificare gestione dati personali e sanitari |
| Apple | Provider piattaforma | App Store, iCloud, CloudKit, HealthKit e Sign in with Apple |
| Provider AI | Servizio esterno | Elaborazione delle conversazioni e degli insight AI |

---

### 1.5 Definizioni

| Termine | Definizione |
|---|---|
| Workout | Sessione di allenamento composta da uno o più esercizi |
| Esercizio | Movimento allenante, ad esempio panca piana o squat |
| Serie | Insieme di ripetizioni eseguite consecutivamente per un esercizio |
| Volume carico | Somma di `carico × ripetizioni` delle serie completate |
| Serie allenante | Serie di lavoro completata, esclusi riscaldamenti se configurati |
| RPE | Rating of Perceived Exertion, percezione dello sforzo |
| RIR | Repetitions in Reserve, ripetizioni teoricamente ancora eseguibili |
| 1RM stimato | Stima del carico massimo per una ripetizione |
| Insight | Informazione interpretativa generata da regole analitiche o AI |
| AI Coach | Assistente conversazionale che usa il contesto autorizzato dell'utente |
| HealthKit | Framework Apple per accesso controllato ai dati salute e attività |
| CloudKit | Servizio Apple per sincronizzazione e persistenza cloud |
| MVP | Minimum Viable Product, prima versione con funzionalità essenziali |

---

## 2. Functional Requirements

## 2.1 Authentication e Account

### FR-AUTH-001 — Sign in with Apple

Il sistema deve consentire all'utente di autenticarsi tramite **Sign in with Apple**.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter accedere con il proprio Apple ID;
- Il sistema deve utilizzare l'identificativo utente fornito da Apple;
- L'utente può scegliere di condividere o nascondere il proprio indirizzo email;
- L'app deve gestire correttamente l'eventuale email relay fornita da Apple;
- L'autenticazione non deve richiedere credenziali aggiuntive gestite direttamente da PeakLift;
- In caso di autenticazione annullata, l'utente deve poter riprovare senza perdita dei dati locali.

---

### FR-AUTH-002 — Profilo utente

Il sistema deve permettere all'utente di creare e modificare il proprio profilo.

**Priorità:** Must  
**Versione:** MVP

#### Dati gestiti

- Nickname o nome visualizzato;
- Unità di misura preferita: kg o lb;
- Livello di esperienza;
- Obiettivo principale;
- Frequenza di allenamento desiderata;
- Gruppi muscolari prioritari;
- Preferenze attrezzatura;
- Lingua applicazione;
- Preferenze notifiche;
- Stato onboarding;
- Consensi AI e HealthKit.

#### Comportamento

- Il profilo deve essere creato durante o dopo l'onboarding;
- I campi opzionali devono poter essere aggiornati in qualsiasi momento;
- La modifica dell'unità di misura deve aggiornare la visualizzazione, senza alterare il valore originario archiviato;
- L'utente deve poter usare il core tracking anche con profilo incompleto;
- L'utente deve poter eliminare l'account e richiedere la cancellazione dei dati.

---

### FR-AUTH-003 — Gestione sessione

Il sistema deve mantenere una sessione utente valida dopo l'autenticazione.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente autenticato deve restare connesso tra riavvii dell'app;
- L'app deve verificare lo stato della sessione all'apertura;
- L'utente deve poter disconnettersi volontariamente;
- La disconnessione non deve eliminare automaticamente i dati locali;
- L'app deve spiegare all'utente l'impatto della disconnessione sulla sincronizzazione CloudKit.

---

## 2.2 Onboarding

### FR-ONB-001 — Introduzione al prodotto

Il sistema deve presentare una breve introduzione al valore di PeakLift.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'introduzione deve chiarire che PeakLift combina workout tracking e AI coaching;
- L'utente deve poter proseguire, tornare indietro o saltare contenuti non obbligatori;
- Il flusso non deve contenere testi tecnici eccessivamente lunghi;
- Il completamento dell'onboarding deve essere raggiungibile in meno di tre minuti.

---

### FR-ONB-002 — Configurazione preferenze

Il sistema deve raccogliere le informazioni minime per personalizzare l'esperienza iniziale.

**Priorità:** Must  
**Versione:** MVP

#### Campi richiesti

- Obiettivo principale;
- Livello di esperienza;
- Unità di misura.

#### Campi opzionali

- Frequenza desiderata;
- Attrezzatura disponibile;
- Muscoli prioritari;
- Nickname;
- Età.

#### Comportamento

- I dati opzionali non devono bloccare il completamento dell'onboarding;
- L'utente deve poter modificare tutte le preferenze successivamente;
- L'app deve spiegare che una maggiore quantità di dati può migliorare gli insight.

---

### FR-ONB-003 — Consensi

Il sistema deve raccogliere e salvare consensi distinti per AI Coach e HealthKit.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Il consenso AI deve essere separato dal consenso HealthKit;
- Il sistema deve spiegare quali dati sono utilizzati e per quale finalità;
- L'utente deve poter negare o revocare un consenso;
- Il rifiuto del consenso non deve impedire workout logging, storico e analytics locali;
- La data e la versione dell'informativa accettata devono essere registrate.

---

## 2.3 Workout Management

### FR-WRK-001 — Creazione workout

Il sistema deve consentire la creazione di un nuovo workout.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter avviare un workout vuoto;
- L'utente deve poter assegnare un titolo opzionale al workout;
- Il sistema deve registrare data e ora di inizio;
- Il workout deve essere inizialmente salvato come bozza o `in corso`;
- Il workout deve poter essere ripreso dopo la chiusura dell'app;
- L'utente deve poter annullare un workout in corso.

---

### FR-WRK-002 — Aggiunta esercizi

Il sistema deve consentire di aggiungere esercizi a un workout.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter cercare esercizi per nome;
- L'utente deve poter filtrare esercizi per gruppo muscolare e attrezzatura;
- L'utente deve poter aggiungere più esercizi allo stesso workout;
- L'utente deve poter riordinare, rimuovere e duplicare esercizi;
- L'utente deve poter creare un esercizio personalizzato;
- Un esercizio personalizzato deve richiedere almeno nome e gruppo muscolare primario.

---

### FR-WRK-003 — Gestione serie

Il sistema deve consentire la registrazione delle serie per ogni esercizio.

**Priorità:** Must  
**Versione:** MVP

#### Dati per serie

- Numero della serie;
- Carico;
- Unità;
- Ripetizioni;
- RPE opzionale;
- RIR opzionale;
- Tipologia della serie;
- Stato della serie;
- Timestamp di completamento;
- Durata recupero opzionale.

#### Tipologie supportate

- Riscaldamento;
- Lavoro;
- Drop set;
- Failure;
- Serie personalizzata.

#### Stati supportati

- Pianificata;
- Completata;
- Saltata.

#### Comportamento

- L'app deve precompilare carico e ripetizioni dall'ultima esecuzione dello stesso esercizio, se disponibile;
- L'utente deve poter modificare valori precompilati;
- L'utente deve poter aggiungere o rimuovere serie;
- Le serie completate devono essere chiaramente distinguibili;
- Le serie saltate non devono contribuire al volume;
- Le serie di riscaldamento devono poter essere escluse dalle metriche di volume;
- Il sistema deve supportare carichi decimali;
- Il sistema non deve accettare valori negativi per carico o ripetizioni.

---

### FR-WRK-004 — Timer di recupero

Il sistema deve offrire un timer di recupero opzionale.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter avviare manualmente il timer;
- Il timer può avviarsi automaticamente dopo il completamento di una serie;
- L'utente deve poter mettere in pausa, riprendere, modificare o interrompere il timer;
- Il timer deve continuare, ove consentito dalla piattaforma, quando l'app passa in background;
- Il timer deve poter mostrare una notifica locale alla scadenza;
- Il mancato utilizzo del timer non deve influire sul workout.

---

### FR-WRK-005 — Completamento workout

Il sistema deve consentire il completamento esplicito di un workout.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve confermare la conclusione del workout;
- Il sistema deve registrare data e ora di fine;
- Il sistema deve calcolare durata e metriche riepilogative;
- Il sistema deve mostrare un riepilogo della sessione;
- Un workout completato deve aggiornare storico, dashboard, analytics e insight;
- Il workout deve restare modificabile dopo il completamento;
- La modifica successiva di un workout completato deve attivare il ricalcolo delle metriche interessate.

---

### FR-WRK-006 — Annullamento workout

Il sistema deve consentire l'annullamento di un workout in corso.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Il sistema deve chiedere conferma prima dell'annullamento;
- Un workout annullato non deve contribuire a volume, frequenza, progressione o streak;
- L'utente deve poter eliminare definitivamente il workout annullato;
- L'utente deve poter mantenere una bozza invece di annullarla.

---

### FR-WRK-007 — Workout history

Il sistema deve fornire uno storico di workout completati.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Lo storico deve mostrare workout in ordine cronologico decrescente;
- Ogni elemento deve mostrare almeno data, titolo, durata, numero di esercizi e volume;
- L'utente deve poter filtrare per periodo;
- L'utente deve poter filtrare per esercizio;
- L'utente deve poter filtrare per gruppo muscolare;
- L'utente deve poter cercare workout o esercizi;
- L'utente deve poter aprire il dettaglio di ciascun workout;
- L'utente deve poter modificare, duplicare o eliminare un workout storico.

---

### FR-WRK-008 — Dettaglio workout

Il sistema deve mostrare il dettaglio completo di un workout.

**Priorità:** Must  
**Versione:** MVP

#### Dati mostrati

- Titolo workout;
- Data;
- Ora di inizio e fine;
- Durata;
- Volume totale;
- Esercizi;
- Serie completate, saltate e di riscaldamento;
- Carichi;
- Ripetizioni;
- RPE/RIR se presenti;
- Note;
- Gruppi muscolari coinvolti.

---

### FR-WRK-009 — Note workout

Il sistema deve consentire l'aggiunta di note a workout ed esercizi.

**Priorità:** Should  
**Versione:** MVP

#### Comportamento

- Le note workout devono essere modificabili;
- Le note devono essere associate al workout o all'esercizio;
- Le note non devono essere inviate all'AI se l'utente non ha autorizzato l'AI Coach;
- Le note devono poter essere eliminate dall'utente.

---

## 2.4 Import CSV

### FR-IMP-001 — Selezione file CSV

Il sistema deve permettere la selezione di un file CSV tramite il selettore file iOS.

**Priorità:** Should  
**Versione:** MVP

#### Comportamento

- L'utente deve poter scegliere un file CSV dal dispositivo o da provider file supportati;
- Il sistema deve rifiutare formati diversi da CSV;
- Il sistema deve mostrare un errore comprensibile se il file non è leggibile;
- L'importazione non deve modificare dati esistenti prima della conferma finale.

---

### FR-IMP-002 — Validazione CSV

Il sistema deve validare il contenuto del file CSV prima dell'importazione.

**Priorità:** Should  
**Versione:** MVP

#### Colonne minime supportate

| Colonna | Obbligatoria |
|---|---:|
| `date` | Sì |
| `exercise_name` | Sì |
| `set_number` | Sì |
| `weight` | Sì |
| `reps` | Sì |

#### Colonne opzionali

| Colonna | Obbligatoria |
|---|---:|
| `workout_name` | No |
| `unit` | No |
| `rpe` | No |
| `rir` | No |
| `notes` | No |

#### Comportamento

- Il sistema deve validare intestazioni, date, numeri e valori richiesti;
- Gli errori devono indicare riga e motivo;
- Il sistema deve fornire una preview prima della conferma;
- Il sistema deve segnalare record potenzialmente duplicati;
- L'utente deve poter annullare l'importazione;
- Ogni record importato deve mantenere il metadato `source = csv_import`.

---

### FR-IMP-003 — Mapping CSV

Il sistema dovrebbe consentire il mapping manuale di colonne non riconosciute.

**Priorità:** Should  
**Versione:** MVP

#### Comportamento

- Il sistema deve permettere di associare una colonna CSV a un campo PeakLift;
- Le colonne obbligatorie devono essere mappate prima della conferma;
- Il sistema deve mostrare un esempio del valore rilevato;
- Le configurazioni di mapping non devono alterare il file originale.

---

## 2.5 Dashboard

### FR-DSH-001 — Dashboard principale

Il sistema deve mostrare una dashboard come schermata principale dell'app.

**Priorità:** Must  
**Versione:** MVP

#### Contenuti

- Saluto contestuale;
- Pulsante `Inizia workout`;
- Numero workout della settimana;
- Volume settimanale;
- Confronto con periodo precedente, quando disponibile;
- Streak di allenamento;
- Insight prioritario;
- Progresso di esercizi rilevanti;
- Accesso rapido a Analytics, storico e AI Coach;
- Dati HealthKit opzionali;
- Stato sincronizzazione, se rilevante.

---

### FR-DSH-002 — Stato vuoto dashboard

Il sistema deve gestire correttamente gli utenti senza workout registrati.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Il sistema non deve mostrare grafici vuoti senza spiegazione;
- La dashboard deve spiegare come iniziare;
- L'utente deve poter avviare un workout;
- L'utente deve poter accedere all'import CSV;
- L'utente deve comprendere che gli insight diventeranno più utili nel tempo.

---

### FR-DSH-003 — Insight prioritario

Il sistema deve visualizzare un insight prioritario quando esistono dati sufficienti.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'insight deve includere un titolo e una spiegazione breve;
- L'insight deve mostrare periodo e dati analizzati;
- L'insight deve includere un'azione suggerita quando appropriato;
- L'utente deve poter aprire il dettaglio;
- L'utente deve poter fornire feedback;
- Se non esistono dati sufficienti, il sistema deve mostrare un messaggio educativo e non un insight speculativo.

---

## 2.6 Analytics

### FR-ANL-001 — Visualizzazione metriche

Il sistema deve calcolare e visualizzare metriche di allenamento.

**Priorità:** Must  
**Versione:** MVP

#### Metriche MVP

| Metrica | Regola di calcolo |
|---|---|
| Volume carico | Somma di `carico × ripetizioni` per serie completate |
| Serie allenanti | Numero serie completate di tipo lavoro, drop set o failure |
| Frequenza workout | Numero di giorni con almeno un workout completato |
| Frequenza muscolare | Numero di giorni in cui un gruppo muscolare è stato coinvolto |
| Volume per esercizio | Volume aggregato per esercizio nel periodo |
| Volume per muscolo | Volume o serie attribuite ai gruppi muscolari nel periodo |
| Progressione | Variazione di carico, ripetizioni, volume o 1RM stimato nel tempo |
| 1RM stimato | Valore indicativo calcolato da carico e ripetizioni |
| Streak | Settimane consecutive con almeno un workout completato |

---

### FR-ANL-002 — Filtri temporali

Il sistema deve permettere il filtraggio dei dati analytics per intervallo temporale.

**Priorità:** Must  
**Versione:** MVP

#### Intervalli minimi

- Ultimi 7 giorni;
- Ultimi 30 giorni;
- Ultimi 90 giorni;
- Ultimo anno;
- Intervallo personalizzato.

#### Comportamento

- Il cambio intervallo deve aggiornare metriche e grafici;
- Il sistema deve indicare chiaramente l'intervallo selezionato;
- L'utente deve poter confrontare il periodo selezionato con il periodo precedente equivalente;
- Se non sono presenti dati nel periodo, il sistema deve mostrare uno stato vuoto utile.

---

### FR-ANL-003 — Progressione esercizi

Il sistema deve mostrare la progressione per esercizio.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter selezionare un esercizio;
- Il sistema deve mostrare storico delle prestazioni;
- Il sistema deve mostrare almeno carico, ripetizioni, volume e 1RM stimato se applicabile;
- L'utente deve poter filtrare il periodo;
- Il sistema deve permettere di aprire il workout di origine da un punto del grafico;
- Il sistema deve indicare se il campione dati è insufficiente per interpretare il trend.

---

### FR-ANL-004 — Equilibrio muscolare

Il sistema deve mostrare la distribuzione del volume o delle serie tra gruppi muscolari.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Il sistema deve aggregare i dati in base ai muscoli associati agli esercizi;
- Il sistema deve distinguere muscoli primari e secondari secondo una logica definita;
- Il sistema deve indicare chiaramente il criterio di attribuzione utilizzato;
- Il sistema non deve presentare un presunto squilibrio come diagnosi sanitaria;
- L'utente deve poter selezionare l'intervallo di analisi.

---

### FR-ANL-005 — Grafici

Il sistema deve presentare dati analytics tramite grafici leggibili su iPhone.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- I grafici devono supportare tap per visualizzare dettagli;
- I grafici devono mostrare titolo, unità di misura e intervallo;
- I grafici non devono usare il colore come unico mezzo di comunicazione;
- I grafici devono essere accompagnati da una descrizione testuale accessibile;
- Il sistema deve adattare i grafici a Dark Mode e Dynamic Type.

---

## 2.7 AI Coach

### FR-AI-001 — Attivazione AI Coach

Il sistema deve richiedere un consenso esplicito prima di usare dati utente per l'AI Coach.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter attivare o disattivare AI Coach dalle impostazioni;
- Il sistema deve spiegare quali dati possono essere utilizzati;
- Il sistema deve funzionare senza AI Coach;
- La disattivazione deve impedire l'invio di nuovi dati verso il provider AI;
- L'utente deve poter cancellare la cronologia delle conversazioni AI.

---

### FR-AI-002 — Insight proattivi

Il sistema deve generare insight basati sui dati autorizzati dell'utente.

**Priorità:** Must  
**Versione:** MVP

#### Tipologie MVP

- Costanza allenamento;
- Variazione del volume;
- Progressione positiva;
- Possibile stallo;
- Frequenza per gruppo muscolare;
- Distribuzione muscolare;
- Dati insufficienti;
- Confronto con periodo precedente.

#### Struttura insight

Ogni insight deve contenere:

- Identificativo;
- Titolo;
- Descrizione;
- Categoria;
- Periodo analizzato;
- Dati osservati;
- Livello di confidenza;
- Azione suggerita, se disponibile;
- Disclaimer, se necessario;
- Timestamp;
- Stato letto/non letto;
- Feedback utente.

---

### FR-AI-003 — Chat AI

Il sistema deve consentire conversazioni con AI Coach.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve poter inviare domande testuali;
- L'AI deve usare esclusivamente il contesto autorizzato e pertinente;
- La risposta deve essere strutturata in dati osservati, interpretazione e suggerimento;
- La risposta deve indicare periodo o workout analizzati quando usa dati personali;
- L'AI deve dichiarare quando mancano dati sufficienti;
- Il sistema deve gestire errori di rete e indisponibilità del provider;
- L'utente deve poter eliminare singoli messaggi o tutta la cronologia.

---

### FR-AI-004 — Sicurezza AI

Il sistema deve applicare regole di sicurezza ai contenuti dell'AI Coach.

**Priorità:** Must  
**Versione:** MVP

#### Regole

- L'AI non deve diagnosticare patologie o infortuni;
- L'AI non deve prescrivere farmaci, trattamenti o diete cliniche;
- L'AI non deve garantire risultati fisici o prestazionali;
- L'AI non deve incoraggiare sovrallenamento, comportamenti pericolosi o pratiche dannose;
- L'AI deve invitare a consultare professionisti qualificati in presenza di dolore, sintomi, infortunio o condizioni mediche;
- L'AI non deve inventare valori o workout non presenti nei dati;
- L'AI deve distinguere tra osservazioni sui dati e raccomandazioni generali.

---

### FR-AI-005 — Feedback insight

Il sistema deve permettere all'utente di valutare gli insight AI.

**Priorità:** Should  
**Versione:** MVP

#### Comportamento

- L'utente deve poter indicare se un insight è utile o non utile;
- L'utente deve poter ignorare o salvare un insight;
- Il sistema deve associare il feedback all'insight;
- Il feedback può essere utilizzato per migliorare prioritizzazione e qualità, nel rispetto del consenso utente.

---

## 2.8 HealthKit

### FR-HK-001 — Autorizzazione HealthKit

Il sistema deve richiedere autorizzazione esplicita per accedere ai dati HealthKit.

**Priorità:** Should  
**Versione:** MVP

#### Dati MVP richiesti

- Passi;
- Calorie attive;
- Workout;
- Minuti di esercizio, se disponibili.

#### Comportamento

- Ogni tipo di dato deve essere richiesto in modo trasparente;
- Il rifiuto dell'autorizzazione non deve bloccare l'app;
- L'utente deve poter modificare i permessi dalle impostazioni di sistema;
- L'app deve gestire la revoca dell'autorizzazione senza errori.

---

### FR-HK-002 — Visualizzazione dati HealthKit

Il sistema deve mostrare dati HealthKit in modo opzionale e contestuale.

**Priorità:** Should  
**Versione:** MVP

#### Comportamento

- I dati HealthKit devono essere chiaramente identificati come provenienti da Apple Health;
- I dati devono essere mostrati nella dashboard o in sezioni dedicate;
- I dati possono essere usati come contesto per insight AI solo con consenso AI attivo;
- Il sistema non deve formulare conclusioni mediche o diagnosi.

---

## 2.9 CloudKit e sincronizzazione

### FR-CK-001 — Persistenza locale

Il sistema deve salvare localmente i dati core dell'utente.

**Priorità:** Must  
**Versione:** MVP

#### Dati locali

- Profilo;
- Esercizi;
- Workout;
- Serie;
- Note;
- Preferenze;
- Insight;
- Cronologia chat;
- Metadati di sincronizzazione.

#### Comportamento

- Il sistema deve salvare i dati dopo modifiche rilevanti;
- Il sistema deve mantenere i dati in caso di chiusura o interruzione dell'app;
- Il logging workout deve funzionare offline;
- I dati locali devono essere disponibili anche in assenza di CloudKit.

---

### FR-CK-002 — Sincronizzazione CloudKit

Il sistema deve sincronizzare i dati utente tramite CloudKit quando disponibile.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- La sincronizzazione deve avvenire in background quando possibile;
- Il sistema deve sincronizzare creazioni, modifiche ed eliminazioni;
- Il sistema deve aggiornare l'interfaccia dopo una sincronizzazione riuscita;
- Il sistema deve mostrare stato o errore di sincronizzazione quando rilevante;
- In assenza di rete, le modifiche devono essere accodate;
- Al ritorno della connessione, il sistema deve tentare la sincronizzazione.

---

### FR-CK-003 — Risoluzione conflitti

Il sistema deve gestire conflitti di sincronizzazione.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- Il sistema deve identificare modifiche concorrenti allo stesso record;
- Per campi non critici, il sistema può applicare una strategia `last write wins`;
- Per workout e serie, il sistema deve evitare cancellazioni silenziose di dati;
- Se il conflitto non è risolvibile automaticamente, il sistema deve conservare una versione recuperabile o segnalare la condizione all'utente;
- Il sistema deve registrare eventi tecnici di conflitto senza esporre dati personali nei log.

---

## 2.10 Privacy e Data Management

### FR-PRV-001 — Centro privacy

Il sistema deve fornire una sezione dedicata alla privacy.

**Priorità:** Must  
**Versione:** MVP

#### Funzioni

- Consultazione informative;
- Stato consensi;
- Attivazione/disattivazione AI Coach;
- Stato autorizzazioni HealthKit;
- Gestione notifiche;
- Esportazione dati;
- Eliminazione account;
- Eliminazione cronologia chat AI.

---

### FR-PRV-002 — Esportazione dati

Il sistema deve permettere all'utente di esportare i propri dati.

**Priorità:** Should  
**Versione:** MVP

#### Dati esportabili

- Profilo;
- Workout;
- Esercizi;
- Serie;
- Metriche aggregate;
- Preferenze;
- Dati generati dall'utente.

#### Comportamento

- L'utente deve avviare esplicitamente l'esportazione;
- Il sistema deve generare un formato leggibile, come CSV o JSON;
- L'utente deve poter condividere o salvare il file tramite strumenti iOS;
- L'esportazione non deve includere segreti tecnici, token o dati di altri utenti.

---

### FR-PRV-003 — Eliminazione account

Il sistema deve consentire l'eliminazione dell'account e dei dati associati.

**Priorità:** Must  
**Versione:** MVP

#### Comportamento

- L'utente deve ricevere una spiegazione chiara delle conseguenze;
- L'eliminazione deve richiedere conferma esplicita;
- Il sistema deve eliminare o rendere irrecuperabili i dati secondo la policy definita;
- Il sistema deve invalidare l'accesso ai servizi cloud associati;
- Il sistema deve mostrare conferma dell'avvenuta richiesta o completamento.

---

## 3. User Stories

### US-001 — Primo accesso

**Come** nuovo utente  
**voglio** accedere con Sign in with Apple  
**per ottenere** un profilo sicuro senza dover creare una password.

---

### US-002 — Configurazione iniziale

**Come** nuovo utente  
**voglio** indicare obiettivo, livello ed unità di misura  
**per ottenere** un'esperienza iniziale personalizzata.

---

### US-003 — Avvio workout

**Come** utente che si sta allenando  
**voglio** avviare rapidamente un workout  
**per registrare la sessione senza perdere tempo.

---

### US-004 — Aggiunta esercizio

**Come** utente  
**voglio** cercare e aggiungere esercizi alla sessione  
**per tracciare correttamente il lavoro svolto.

---

### US-005 — Registrazione serie

**Come** utente in palestra  
**voglio** inserire rapidamente carico e ripetizioni  
**per monitorare le mie prestazioni tra una serie e l'altra.

---

### US-006 — Recupero

**Come** utente  
**voglio** usare un timer di recupero  
**per gestire meglio le pause tra le serie.

---

### US-007 — Storico workout

**Come** utente  
**voglio** consultare gli allenamenti passati  
**per confrontare le prestazioni e ripetere una sessione.

---

### US-008 — Progressione esercizio

**Come** lifter orientato ai progressi  
**voglio** visualizzare l'andamento di un esercizio  
**per capire se sto aumentando carico, ripetizioni o volume.

---

### US-009 — Analytics muscolari

**Come** utente  
**voglio** vedere come è distribuito il mio volume tra i muscoli  
**per individuare eventuali aree poco allenate.

---

### US-010 — Dashboard

**Come** utente  
**voglio** aprire una dashboard con i dati più importanti  
**per capire rapidamente a che punto sono.

---

### US-011 — AI Coach

**Come** utente  
**voglio** chiedere all'AI Coach se sto progredendo  
**per ottenere una lettura semplice dei miei dati.

---

### US-012 — Insight AI

**Come** utente  
**voglio** ricevere insight proattivi  
**per individuare trend e possibili problemi senza analizzare manualmente tutti i grafici.

---

### US-013 — Import CSV

**Come** nuovo utente proveniente da un foglio di calcolo  
**voglio** importare lo storico workout da CSV  
**per non perdere i dati raccolti in precedenza.

---

### US-014 — HealthKit

**Come** utente dell'ecosistema Apple  
**voglio** autorizzare facoltativamente l'accesso ai dati HealthKit  
**per aggiungere contesto di attività ai miei allenamenti.

---

### US-015 — Offline mode

**Come** utente in palestra con connessione instabile  
**voglio** registrare workout anche offline  
**per non perdere dati durante la sessione.

---

### US-016 — Sincronizzazione

**Come** utente con più dispositivi Apple  
**voglio** sincronizzare automaticamente i miei dati  
**per ritrovare workout e progressi ovunque.

---

### US-017 — Privacy

**Come** utente  
**voglio** controllare i consensi dati e l'uso dell'AI  
**per mantenere il controllo sulle informazioni personali.

---

### US-018 — Eliminazione dati

**Come** utente  
**voglio** esportare o eliminare i miei dati  
**per esercitare controllo sulla mia cronologia personale.

---

## 4. Acceptance Criteria

## 4.1 Authentication

### AC-AUTH-001 — Sign in with Apple

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| L'utente non è autenticato | Seleziona `Continua con Apple` e completa l'autenticazione | Il sistema crea o recupera il profilo associato all'Apple ID |
| L'utente annulla l'autenticazione | Chiude il flusso Apple | L'app resta utilizzabile nella schermata di accesso senza errori |
| L'utente è già autenticato | Riapre l'app | Il sistema ripristina la sessione senza richiedere nuovamente l'accesso |

---

### AC-AUTH-002 — Modifica profilo

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| L'utente è autenticato | Modifica unità da kg a lb | Le visualizzazioni usano lb e i dati salvati restano coerenti |
| L'utente è autenticato | Modifica obiettivo o livello | Le preferenze vengono salvate localmente e sincronizzate |
| L'utente ha profilo parziale | Apre dashboard | Può continuare a usare le funzionalità core |

---

## 4.2 Workout Management

### AC-WRK-001 — Creazione workout

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Utente autenticato o con profilo locale | Seleziona `Inizia workout` | Viene creato un workout in stato `in corso` |
| Workout in corso | L'utente chiude l'app | Il workout resta disponibile come bozza al riavvio |
| Workout in corso | L'utente aggiunge un titolo | Il titolo viene salvato e mostrato nello storico al completamento |

---

### AC-WRK-002 — Registrazione serie

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Un esercizio è presente nel workout | L'utente inserisce carico e ripetizioni validi | La serie può essere marcata come completata |
| Una serie è completata | Il sistema calcola il volume | Il volume è pari a carico moltiplicato per ripetizioni |
| Una serie è marcata come saltata | L'utente completa il workout | La serie non contribuisce al volume |
| L'utente inserisce un valore negativo | Conferma l'inserimento | Il sistema blocca il salvataggio e mostra un errore comprensibile |

---

### AC-WRK-003 — Timer recupero

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Una serie viene completata | L'utente avvia timer | Il conto alla rovescia viene visualizzato |
| Timer attivo | L'app passa in background | Il timer mantiene il tempo corretto al ritorno dell'app |
| Timer in scadenza | Notifiche autorizzate | L'utente riceve una notifica locale |

---

### AC-WRK-004 — Completamento workout

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Workout in corso con almeno una serie completata | L'utente seleziona `Completa workout` | Il workout assume stato `completato` |
| Workout completato | Il sistema mostra riepilogo | Sono visualizzati durata, esercizi, serie e volume |
| Workout completato | L'utente apre dashboard | Dashboard e analytics includono il nuovo workout |
| Workout annullato | L'utente apre analytics | Il workout non influenza le metriche |

---

### AC-WRK-005 — Storico e dettaglio

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Esistono workout completati | L'utente apre storico | I workout sono ordinati dal più recente |
| Utente nello storico | Applica filtro per esercizio | Sono mostrati solo workout contenenti l'esercizio |
| Utente apre un workout | Seleziona modifica | Le modifiche vengono salvate e le metriche ricalcolate |
| Utente seleziona elimina | Conferma azione | Il workout viene rimosso da storico e analytics |

---

## 4.3 CSV Import

### AC-IMP-001 — Importazione valida

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| L'utente possiede un CSV valido | Seleziona e conferma importazione | I workout vengono creati nello storico |
| File valido importato | L'utente apre analytics | Le metriche includono i workout importati |
| File contiene colonne opzionali | Il sistema legge RPE, note o unità | I dati disponibili vengono associati ai record importati |

---

### AC-IMP-002 — Gestione errori CSV

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| CSV con data non valida | Avvio validazione | Il sistema indica riga e motivo dell'errore |
| CSV senza colonna obbligatoria | Avvio validazione | Il sistema blocca conferma fino a mapping o correzione |
| CSV con duplicati potenziali | Preview import | Il sistema segnala i record e richiede conferma |
| Utente annulla import | Seleziona annulla | Nessun workout viene creato o modificato |

---

## 4.4 Dashboard

### AC-DSH-001 — Dashboard con dati

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| L'utente ha workout completati | Apre la tab `Oggi` | Visualizza riepilogo attività e call to action |
| Esistono dati in almeno due periodi | Apre volume settimanale | Visualizza confronto con periodo precedente |
| Esistono dati sufficienti | Apre dashboard | Visualizza insight prioritario contestuale |
| L'utente tocca una card | Seleziona dettaglio | Viene aperta la sezione pertinente |

---

### AC-DSH-002 — Dashboard vuota

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| L'utente non ha workout | Apre dashboard | Visualizza messaggio educativo e pulsante `Inizia workout` |
| L'utente non ha workout | Seleziona import CSV | Viene avviato il flusso di importazione |
| Dati insufficienti per insight | Apre dashboard | Il sistema non mostra conclusioni non supportate dai dati |

---

## 4.5 Analytics

### AC-ANL-001 — Calcolo volume

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Esistono serie completate | L'utente seleziona un intervallo | Il sistema somma carico moltiplicato per ripetizioni |
| Esistono serie di riscaldamento | Configurazione esclude warm-up | Le serie warm-up non sono incluse nel volume allenante |
| Serie con carico zero e reps valide | Il sistema calcola volume | Il volume della serie è zero ma la serie può essere conteggiata secondo configurazione |

---

### AC-ANL-002 — Filtri analytics

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Esistono workout in periodi diversi | L'utente seleziona ultimi 30 giorni | Grafici e metriche includono solo i dati del periodo |
| L'utente cambia filtro | Seleziona ultimi 90 giorni | Tutti i componenti analytics si aggiornano coerentemente |
| Nessun workout nel periodo | Applica filtro | Il sistema mostra stato vuoto e non grafici errati |

---

### AC-ANL-003 — Progressione esercizio

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Un esercizio ha storico sufficiente | L'utente lo seleziona | Vengono mostrati trend di carico, reps, volume e 1RM stimato |
| L'utente tocca un punto grafico | Seleziona dettaglio | Visualizza data e workout di origine |
| Storico insufficiente | Apre progressione esercizio | Il sistema indica che non ci sono dati sufficienti per un trend affidabile |

---

## 4.6 AI Coach

### AC-AI-001 — Consenso AI

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| AI Coach non autorizzato | L'utente apre Coach | Il sistema richiede consenso o mostra modalità non attiva |
| AI Coach autorizzato | L'utente disattiva consenso | Nessun nuovo dato viene inviato al provider AI |
| AI Coach disattivato | L'utente registra workout | Workout tracking e analytics continuano a funzionare |

---

### AC-AI-002 — Insight contestuale

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Esistono dati sufficienti | Sistema genera insight | Insight include periodo, dati osservati e azione suggerita |
| Dati insufficienti | Sistema valuta insight | Viene mostrato messaggio educativo, non una conclusione speculativa |
| L'utente apre insight | Visualizza dettaglio | Può consultare dati origine e feedback |

---

### AC-AI-003 — Conversazione AI

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| AI Coach autorizzato | L'utente invia una domanda sui progressi | Riceve risposta basata sui dati disponibili |
| AI non trova dati rilevanti | L'utente chiede di un esercizio mai registrato | L'AI dichiara la mancanza di dati |
| Utente menziona dolore o infortunio | Invia messaggio | AI evita diagnosi e invita a consultare un professionista |
| Provider AI non disponibile | L'utente invia domanda | Sistema mostra errore e possibilità di riprovare |

---

## 4.7 HealthKit

### AC-HK-001 — Autorizzazione e revoca

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| HealthKit non autorizzato | L'utente attiva integrazione | iOS mostra la richiesta permessi |
| Utente rifiuta autorizzazione | Torna nell'app | PeakLift resta utilizzabile senza errori |
| Utente revoca autorizzazione | Apre dashboard | Dati HealthKit non vengono più aggiornati o mostrati come correnti |

---

### AC-HK-002 — Dati attività

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| HealthKit autorizzato | L'utente apre dashboard | Visualizza dati attività disponibili |
| Dati HealthKit non disponibili | Apre dashboard | Il sistema mostra stato informativo senza dati falsi |
| AI Coach autorizzato | Richiede analisi contestuale | I dati HealthKit autorizzati possono essere usati come contesto non medico |

---

## 4.8 CloudKit

### AC-CK-001 — Offline mode

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Dispositivo offline | L'utente registra un workout | I dati vengono salvati localmente |
| Dispositivo offline | L'utente consulta storico | Lo storico locale resta accessibile |
| Connessione ripristinata | App torna online | Il sistema tenta la sincronizzazione in background |

---

### AC-CK-002 — Sincronizzazione

| Condizione iniziale | Comportamento | Risultato atteso |
|---|---|---|
| Utente con CloudKit disponibile | Crea workout su un dispositivo | Il workout viene sincronizzato quando possibile |
| Stesso account su secondo dispositivo | Apre app dopo sync completata | Il workout è disponibile nello storico |
| Sync non riuscita | Errore temporaneo rete | Sistema conserva modifiche locali e riprova successivamente |

---

## 5. Non Functional Requirements

## 5.1 Performance

### NFR-PERF-001 — Avvio applicazione

L'app deve mostrare la schermata iniziale e consentire l'interazione principale in tempi percepiti come rapidi su dispositivi iOS supportati.

**Target:** schermata principale disponibile entro 2 secondi in condizioni normali, esclusi ritardi di rete per contenuti AI.

---

### NFR-PERF-002 — Registrazione serie

Il completamento o la modifica di una serie deve fornire feedback visivo immediato.

**Target:** aggiornamento UI entro 100 ms dalla conferma dell'azione, salvo limiti della piattaforma.

---

### NFR-PERF-003 — Persistenza workout

Il salvataggio locale di una serie o workout non deve bloccare l'interfaccia.

**Target:** persistenza non bloccante e completamento percepito entro 500 ms per le operazioni standard.

---

### NFR-PERF-004 — Dashboard e analytics

Dashboard e analytics devono restare reattive anche con uno storico consistente.

**Target:**

- Dashboard locale caricata entro 1 secondo dopo disponibilità dei dati;
- Analytics per intervalli standard visualizzate entro 2 secondi;
- Calcoli più onerosi eseguiti in background con stato di caricamento chiaro.

---

### NFR-PERF-005 — AI Coach

Il sistema deve mostrare uno stato di elaborazione mentre attende una risposta AI.

**Target:**

- Feedback visivo immediato dopo invio messaggio;
- Timeout e messaggio di errore gestiti se il provider non risponde;
- Possibilità di riprovare senza perdere il messaggio dell'utente.

---

### NFR-PERF-006 — Memoria e batteria

L'app deve evitare consumo eccessivo di memoria, CPU e batteria.

#### Requisiti

- Nessun polling continuo non necessario;
- Sincronizzazione CloudKit eseguita in modo efficiente;
- Grafici e dati caricati progressivamente;
- Timer recupero implementato con meccanismi nativi efficienti;
- Elaborazioni analytics pesanti eseguite fuori dal main thread;
- Nessuna elaborazione AI continua in background senza azione o consenso dell'utente.

---

## 5.2 Security e Privacy

### NFR-SEC-001 — Protezione dati

I dati locali devono essere protetti usando i meccanismi di sicurezza disponibili su iOS.

#### Requisiti

- I dati non devono essere salvati in chiaro in file accessibili ad altre app;
- Eventuali credenziali, token o chiavi devono essere gestiti tramite Keychain o servizi equivalenti;
- Le comunicazioni di rete devono usare connessioni sicure;
- I log tecnici non devono includere dati sanitari identificabili, salvo necessità esplicita e controllo.

---

### NFR-SEC-002 — Minimizzazione dati AI

Il sistema deve inviare al provider AI solo i dati necessari a generare la risposta o l'insight richiesto.

#### Requisiti

- Dati personali non necessari non devono essere inviati;
- I dati devono essere aggregati o pseudonimizzati quando possibile;
- L'utente deve poter disattivare AI Coach;
- I dati non devono essere usati per training di modelli senza consenso esplicito;
- Il sistema deve rispettare la configurazione di consenso vigente.

---

### NFR-SEC-003 — Dati HealthKit

I dati HealthKit devono essere trattati come sensibili.

#### Requisiti

- L'accesso avviene esclusivamente con permessi espliciti;
- Il sistema deve leggere solo i dati autorizzati;
- La revoca del consenso deve essere rispettata;
- I dati HealthKit non devono essere condivisi con terzi senza consenso;
- L'app non deve presentare dati HealthKit come diagnosi o valutazione medica.

---

### NFR-SEC-004 — Eliminazione dati

Il sistema deve fornire un percorso chiaro per eliminare dati e account.

#### Requisiti

- L'utente deve confermare le azioni distruttive;
- L'app deve spiegare quali dati saranno rimossi;
- Le richieste devono essere tracciate in modo sicuro;
- I dati eliminati non devono restare accessibili dall'interfaccia utente.

---

## 5.3 Reliability

### NFR-REL-001 — Disponibilità offline

Le funzionalità core devono essere disponibili offline.

#### Funzioni offline obbligatorie

- Creazione workout;
- Registrazione serie;
- Timer recupero;
- Salvataggio bozza;
- Completamento workout;
- Consultazione storico locale;
- Analytics basate su dati locali già disponibili.

---

### NFR-REL-002 — Integrità dati

Il sistema deve preservare i dati in caso di crash, chiusura improvvisa o perdita connessione.

#### Requisiti

- Bozze workout salvate automaticamente;
- Modifiche alle serie persistite progressivamente;
- Operazioni di import non parzialmente applicate senza conferma;
- Modifiche locali accodate in caso di assenza rete;
- Errori di sincronizzazione non devono eliminare record locali.

---

### NFR-REL-003 — Gestione errori

Il sistema deve fornire messaggi di errore comprensibili e azionabili.

#### Requisiti

- Gli errori non devono esporre dettagli tecnici sensibili;
- L'utente deve poter riprovare operazioni di rete;
- L'errore di un'integrazione opzionale non deve bloccare il workout logging;
- L'app deve mostrare chiaramente quando i dati possono essere non aggiornati.

---

### NFR-REL-004 — Sincronizzazione

La sincronizzazione deve essere idempotente e resistente a retry.

#### Requisiti

- Un retry non deve duplicare workout o serie;
- Il sistema deve identificare record già sincronizzati;
- Le eliminazioni devono essere gestite in modo coerente sui dispositivi;
- I conflitti devono essere registrati e gestiti secondo la strategia definita.

---

## 5.4 Usability e Accessibilità

### NFR-USE-001 — Esperienza in palestra

L'interfaccia deve essere utilizzabile rapidamente durante l'allenamento.

#### Requisiti

- Target touch adeguati;
- Inserimento numerico rapido;
- Precompilazione delle ultime performance;
- Accesso facile a `Inizia workout`;
- Feedback immediato per serie completate;
- Timer non invasivo;
- Nessun flusso obbligatorio troppo lungo durante una sessione.

---

### NFR-USE-002 — Design Apple-like

L'app deve seguire convenzioni iOS e offrire un'interfaccia coerente.

#### Requisiti

- Supporto Dark Mode;
- Navigazione coerente;
- Tab bar per aree principali;
- Feedback haptic quando appropriato;
- Gestione corretta di safe area e dimensioni schermo;
- Stati vuoti comprensibili;
- Progressive disclosure per metriche avanzate.

---

### NFR-USE-003 — Accessibilità

L'app deve supportare requisiti di accessibilità iOS.

#### Requisiti

- Dynamic Type;
- VoiceOver;
- Contrasto adeguato;
- Riduzione movimento;
- Etichette accessibili per controlli;
- Descrizioni testuali per grafici;
- Informazioni non dipendenti solo dal colore;
- Supporto per localizzazione futura in italiano e inglese.

---

### NFR-USE-004 — Chiarezza insight AI

Le risposte AI devono essere leggibili e non fuorvianti.

#### Requisiti

- Distinzione tra dato, interpretazione e suggerimento;
- Linguaggio semplice;
- Indicazione del periodo analizzato;
- Indicazione dell'incertezza quando necessaria;
- Nessuna affermazione medica;
- Nessuna promessa di risultati garantiti.

---

## 5.5 Compatibilità

### NFR-CMP-001 — Piattaforma

PeakLift deve essere disponibile su iOS.

#### Requisiti

- L'app deve supportare iPhone;
- L'architettura deve essere predisposta per evoluzione futura su iPad e Apple Watch;
- Il sistema deve usare framework Apple compatibili con la versione iOS minima definita dal team;
- Le funzionalità HealthKit devono degradare correttamente se non disponibili sul dispositivo.

---

### NFR-CMP-002 — Connessione

L'app deve funzionare sia online sia offline.

#### Requisiti

- Le funzioni locali devono restare disponibili senza connessione;
- CloudKit e AI Coach devono gestire assenza rete;
- L'app deve indicare chiaramente quando una funzione richiede connessione;
- Nessuna operazione AI deve bloccare il completamento di un workout.

---

## 6. MVP Scope

## 6.1 Incluso

| Area | Funzionalità MVP |
|---|---|
| Account | Sign in with Apple, gestione sessione e profilo |
| Onboarding | Obiettivi, livello, unità, consensi |
| Workout | Creazione, modifica, completamento, annullamento e bozza |
| Esercizi | Libreria, ricerca, filtri ed esercizi personalizzati |
| Serie | Carico, ripetizioni, RPE/RIR opzionali, tipologia e stato |
| Recupero | Timer opzionale con notifica locale |
| Storico | Lista workout, filtri, dettaglio, modifica e eliminazione |
| Dashboard | Riepilogo attività, volume, streak, insight e CTA workout |
| Analytics | Volume, serie, frequenza, progressione, 1RM stimato e distribuzione muscolare |
| AI Coach | Insight proattivi, chat contestuale, consensi e guardrail |
| Import | Import CSV strutturato con preview e validazione |
| HealthKit | Lettura opzionale di passi, calorie attive e workout |
| CloudKit | Persistenza locale, sincronizzazione e gestione retry |
| Privacy | Centro privacy, consensi, cancellazione chat, export ed eliminazione account |
| UX | Dark Mode, Dynamic Type, VoiceOver, offline mode e stati vuoti |

---

## 6.2 Escluso

Le seguenti funzionalità non fanno parte dell'MVP:

- Supporto Android;
- Social network pubblico;
- Feed di contenuti;
- Challenge social pubbliche;
- Video form analysis;
- Analisi tecnica in tempo reale;
- Analisi immagini corporee;
- Vision Framework;
- Diagnosi mediche, fisioterapiche o nutrizionali;
- Piani alimentari;
- Tracking calorie e macronutrienti;
- Marketplace di personal trainer;
- Generazione completamente automatica di programmi;
- Apple Watch companion completo;
- Integrazione diretta con tutte le app fitness di terze parti;
- Dati avanzati di sonno, HRV e recupero clinico;
- Gamification avanzata;
- Accesso trainer o coach esterni.

---

## 6.3 Futuro

| Area | Funzionalità pianificate |
|---|---|
| Workout | Template riutilizzabili, duplicazione avanzata e program builder |
| AI | Suggerimenti di progressione, deload detection e coaching proattivo |
| Analytics | Bilanciamento muscolare avanzato e insight predittivi |
| Health | Sonno, HRV, resting heart rate e recovery contestuale |
| Apple Watch | Registrazione serie, timer e check-in dall'orologio |
| Vision | Analisi opzionale di postura, movimento e cambiamenti fisici |
| Social | Gruppi privati, challenge tra amici e milestone condivise |
| Coach Mode | Condivisione selettiva dati con personal trainer |
| Export | Export esteso CSV e JSON |
| Multi-platform | iPad, Apple Watch completo e possibile macOS companion |
| Gamification | Badge, streak e obiettivi personalizzati |

---

## 7. Assunzioni e Vincoli

### 7.1 Assunzioni

- L'utente possiede un dispositivo iOS compatibile;
- L'utente può utilizzare PeakLift anche senza HealthKit;
- L'utente può utilizzare workout tracking senza AI Coach;
- I dati inseriti manualmente sono responsabilità dell'utente;
- I suggerimenti AI sono informativi e non sostituiscono professionisti qualificati;
- La qualità degli insight aumenta con quantità e coerenza dei dati raccolti.

---

### 7.2 Vincoli tecnici

- L'app deve essere sviluppata con Swift e SwiftUI;
- I dati locali devono usare SwiftData o tecnologia equivalente;
- La sincronizzazione cloud deve usare CloudKit;
- I dati salute devono essere acquisiti tramite HealthKit;
- L'accesso utente deve supportare Sign in with Apple;
- Le funzionalità AI richiedono una AI API e connessione Internet;
- I flussi AI devono rispettare consenso, minimizzazione dei dati e regole di sicurezza.

---

### 7.3 Vincoli di sicurezza

- Il sistema non deve diagnosticare patologie o infortuni;
- Il sistema non deve prescrivere trattamenti medici;
- Il sistema non deve trattare gli insight come raccomandazioni cliniche;
- L'utente deve poter revocare i consensi;
- L'utente deve poter richiedere esportazione ed eliminazione dati;
- Le funzionalità sensibili devono essere opzionali.

---

## 8. Definition of Done MVP

L'MVP può essere considerato pronto al rilascio quando:

- Un nuovo utente può completare onboarding e autenticazione;
- L'utente può avviare, registrare, completare e consultare un workout;
- Esercizi, serie, carichi, ripetizioni e RPE/RIR vengono salvati correttamente;
- Il sistema conserva una bozza in caso di chiusura improvvisa;
- Dashboard e analytics calcolano correttamente le metriche previste;
- Gli insight AI sono contestuali, spiegabili e rispettano i guardrail di sicurezza;
- L'utente può disattivare AI Coach e HealthKit senza perdere le funzionalità core;
- CSV import valida, mostra preview e importa dati solo dopo conferma;
- I dati sono disponibili offline e vengono sincronizzati quando possibile;
- L'utente può gestire consensi, esportare dati ed eliminare account;
- L'interfaccia rispetta requisiti minimi di accessibilità;
- Non sono presenti bug bloccanti relativi a perdita dati, completamento workout, privacy o sincronizzazione.