# Product Requirements Document
# PeakLift

> **Versione:** 1.0  
> **Stato:** Draft  
> **Owner:** Product Management  
> **Piattaforma:** iOS  
> **Nome provvisorio:** PeakLift  
> **Tecnologie previste:** Swift, SwiftUI, SwiftData, CloudKit, HealthKit, AI API  

---

## 1. Product Overview

### 1.1 Descrizione del prodotto

PeakLift è un'applicazione iOS AI-first dedicata allo strength training.

Il prodotto non è progettato come un semplice diario per registrare serie, ripetizioni e carichi. PeakLift agisce come un **AI Fitness Coach personale**, capace di trasformare i dati degli allenamenti in insight comprensibili e suggerimenti pratici.

L'app analizza:

- Allenamenti completati;
- Serie, ripetizioni e carichi;
- Volume di allenamento;
- Frequenza per gruppo muscolare;
- Progressione degli esercizi;
- Equilibrio muscolare;
- Dati di attività e recupero disponibili tramite HealthKit;
- Trend storici dell'utente.

La domanda principale a cui PeakLift deve rispondere è:

> Cosa dovrei fare oggi per avvicinarmi al mio obiettivo?

---

### 1.2 Problema da risolvere

Gli utenti fitness raccolgono dati ma spesso non riescono a interpretarli.

Le applicazioni esistenti tendono a registrare workout e mostrare grafici, ma raramente aiutano l'utente a capire:

- Se sta progredendo davvero;
- Se il volume è adeguato;
- Se un esercizio è in stallo;
- Se alcuni gruppi muscolari sono trascurati;
- Se il recupero potrebbe essere insufficiente;
- Se sia opportuno aumentare, mantenere o ridurre il carico;
- Come adattare il programma ai risultati reali.

PeakLift colma il divario tra **workout tracking** e **coaching personalizzato basato sui dati**.

---

### 1.3 Target utenti

#### Persona primaria: Lifter orientato ai progressi

Utente tra 20 e 35 anni, con alcuni mesi o anni di esperienza in palestra, che si allena 3–6 volte a settimana con obiettivi di forza, ipertrofia o ricomposizione corporea.

Ha già abitudini di tracking, ma necessita di una lettura più semplice e utile dei propri dati.

#### Persona secondaria: Principiante strutturato

Utente tra 18 e 30 anni che vuole seguire un percorso di allenamento serio, ma non possiede ancora solide competenze su volume, progressione, RPE, frequenza e recupero.

Cerca una guida educativa e non eccessivamente tecnica.

#### Persona terziaria: Atleta autonomo avanzato

Utente con esperienza significativa, abituato a costruire e adattare autonomamente i propri programmi.

Non cerca prescrizioni rigide, ma analisi profonde, configurabili e rapide da consultare.

---

### 1.4 Obiettivi di prodotto

#### Obiettivi principali

- Consentire la registrazione semplice e affidabile degli allenamenti;
- Rendere visibile la progressione per esercizio e gruppo muscolare;
- Calcolare automaticamente volume, frequenza e distribuzione muscolare;
- Offrire insight contestuali basati sui dati dell'utente;
- Fornire un AI Coach che spieghi dati e suggerisca azioni;
- Creare un'esperienza iOS nativa, veloce e coerente;
- Proteggere i dati personali e sanitari con un approccio privacy-first.

#### Obiettivi misurabili

- Ridurre il tempo necessario per registrare una serie;
- Aumentare il numero di workout registrati per utente attivo;
- Aumentare la retention a 7, 30 e 90 giorni;
- Aumentare il tasso di consultazione e interazione con gli insight AI;
- Fare in modo che gli utenti percepiscano PeakLift come uno strumento di coaching e non solo di tracking.

---

### 1.5 Non-obiettivi MVP

Le seguenti funzionalità non fanno parte dell'MVP:

- Analisi tecnica video in tempo reale;
- Correzione automatica della forma degli esercizi;
- Diagnosi mediche, fisioterapiche o nutrizionali;
- Social network pubblico;
- Piani alimentari;
- Marketplace per personal trainer;
- Integrazione Apple Watch completa;
- Generazione automatica completa di programmi di allenamento;
- Import diretto da tutte le app fitness di terze parti.

---

## 2. Feature List

### 2.1 MVP

Le funzionalità MVP devono validare il valore principale del prodotto: **registrare un allenamento, comprenderne l'impatto e ricevere insight utili.**

| ID | Feature | Descrizione sintetica | Priorità |
|---|---|---|---|
| MVP-01 | Onboarding | Raccolta obiettivi, esperienza, preferenze e consenso dati | Must |
| MVP-02 | Account e sincronizzazione | Account iCloud e sincronizzazione sicura tramite CloudKit | Must |
| MVP-03 | Libreria esercizi | Ricerca, selezione e creazione di esercizi personalizzati | Must |
| MVP-04 | Workout logging | Creazione, esecuzione e salvataggio di allenamenti | Must |
| MVP-05 | Gestione serie | Registrazione di carico, ripetizioni, RPE e stato della serie | Must |
| MVP-06 | Workout history | Storico allenamenti e dettaglio delle sessioni | Must |
| MVP-07 | Dashboard | Riepilogo attività, statistiche e insight prioritari | Must |
| MVP-08 | Analytics | Analisi di volume, frequenza, progressione ed equilibrio muscolare | Must |
| MVP-09 | AI Coach base | Insight testuali e chat con contesto dello storico allenamenti | Must |
| MVP-10 | HealthKit base | Lettura opzionale di passi, calorie attive e workout | Should |
| MVP-11 | Import CSV | Import manuale di workout da file CSV strutturato | Should |
| MVP-12 | Privacy controls | Consensi, gestione dati, esportazione ed eliminazione account | Must |
| MVP-13 | Notifiche | Promemoria workout e insight settimanali configurabili | Could |

---

### 2.2 Versione 2

| ID | Feature | Descrizione sintetica | Priorità |
|---|---|---|---|
| V2-01 | Workout templates | Template riutilizzabili e duplicazione delle sessioni | Must |
| V2-02 | Program builder | Creazione di programmi multi-settimana personalizzati | Should |
| V2-03 | Suggerimenti progressione | Raccomandazioni su carico, ripetizioni o volume | Must |
| V2-04 | Deload detection | Identificazione di segnali di stallo o possibile affaticamento | Should |
| V2-05 | Muscle balance avanzato | Analisi dettagliata della distribuzione del volume | Should |
| V2-06 | HealthKit avanzato | Uso opzionale di sonno, frequenza cardiaca e recovery signals | Could |
| V2-07 | Import migliorato | Mapping CSV guidato e import da fonti supportate | Should |
| V2-08 | Widget iOS | Widget per streak, workout successivo e insight | Could |
| V2-09 | Apple Watch companion | Registrazione essenziale e timer di recupero da Watch | Could |
| V2-10 | Export dati | Esportazione CSV/JSON dello storico e delle metriche | Should |

---

### 2.3 Future

| ID | Feature | Descrizione sintetica |
|---|---|---|
| F-01 | AI Coach proattivo | Coaching adattivo basato su trend e check-in giornalieri |
| F-02 | Generazione programmi | Creazione e adattamento di programmi periodizzati |
| F-03 | Vision Framework | Analisi opzionale di postura, movimento e progressi fisici |
| F-04 | Form analysis | Feedback educativo su tecnica tramite video |
| F-05 | Social privato | Gruppi, challenge e condivisione controllata dei progressi |
| F-06 | Coach mode | Accesso per trainer e condivisione selettiva dei dati |
| F-07 | Integrazioni API | Connessione con app, wearable e servizi fitness esterni |
| F-08 | Insights predittivi | Stima del rischio di stallo o riduzione dell'aderenza |
| F-09 | Multi-platform | iPad, Apple Watch completo ed eventuale supporto macOS |
| F-10 | Gamification | Badge, milestone, streak e challenge personalizzate |

---

## 3. Feature Specification

## 3.1 Onboarding

### Descrizione

Flusso iniziale che raccoglie le informazioni minime necessarie per configurare PeakLift e personalizzare la prima esperienza.

### Obiettivo

Permettere all'utente di raggiungere rapidamente il primo valore senza richiedere un questionario troppo lungo.

### Priorità

**Must — MVP**

### Dati coinvolti

- Nome o nickname;
- Età opzionale;
- Unità preferita: kg/lb;
- Livello di esperienza;
- Obiettivo principale;
- Frequenza settimanale desiderata;
- Attrezzatura disponibile;
- Gruppi muscolari prioritari;
- Consenso HealthKit;
- Consenso trattamento dati e AI.

### Comportamento

1. L'utente apre PeakLift per la prima volta.
2. Visualizza una breve introduzione al valore dell'app.
3. Seleziona obiettivo e livello di esperienza.
4. Configura unità di misura e preferenze base.
5. Può autorizzare HealthKit oppure ignorare il passaggio.
6. Può importare un CSV, iniziare un workout o esplorare una dashboard inizialmente vuota.
7. L'app comunica chiaramente che gli insight AI migliorano con la raccolta dei dati.

### Requisiti di accettazione

- Il flusso deve essere completabile in meno di 3 minuti;
- HealthKit deve essere opzionale;
- L'utente deve poter modificare ogni preferenza successivamente;
- L'utente deve poter iniziare un workout anche senza compilare tutti i dati opzionali;
- I consensi devono essere espliciti e revocabili.

---

## 3.2 Account, dati e sincronizzazione

### Descrizione

Sistema di persistenza e sincronizzazione dei dati utente tramite SwiftData locale e CloudKit.

### Obiettivo

Garantire che i dati rimangano disponibili, privati e sincronizzati tra dispositivi Apple associati allo stesso account.

### Priorità

**Must — MVP**

### Dati coinvolti

- Profilo utente;
- Esercizi;
- Workout;
- Serie;
- Template;
- Insight;
- Preferenze;
- Dati di consenso;
- Metadati di sincronizzazione.

### Comportamento

- I dati vengono salvati localmente sul dispositivo;
- Quando disponibile, CloudKit sincronizza in background;
- L'app deve essere utilizzabile offline per logging e consultazione dello storico locale;
- Al ritorno della connessione, le modifiche devono essere sincronizzate;
- In caso di conflitto, il prodotto deve preferire la modifica più recente e registrare eventuali conflitti rilevanti.

### Requisiti di accettazione

- L'utente può utilizzare il core logging senza connessione;
- I dati non devono andare persi alla chiusura dell'app;
- Lo stato di sincronizzazione deve essere consultabile;
- L'utente deve poter richiedere esportazione o cancellazione dei dati.

---

## 3.3 Libreria esercizi

### Descrizione

Catalogo di esercizi predefiniti e personalizzati, organizzati per gruppo muscolare, attrezzatura e pattern di movimento.

### Obiettivo

Ridurre il tempo di creazione del workout e garantire coerenza nell'analisi dei dati.

### Priorità

**Must — MVP**

### Dati coinvolti

- Nome esercizio;
- Gruppo muscolare primario;
- Gruppi muscolari secondari;
- Pattern di movimento;
- Attrezzatura;
- Tipo: bilanciere, manubri, macchina, corpo libero, cavi;
- Note personali;
- Stato: predefinito o personalizzato.

### Comportamento

- L'utente può cercare un esercizio per nome;
- Può filtrare per muscolo e attrezzatura;
- Può creare esercizi personalizzati;
- Un esercizio personalizzato deve richiedere almeno nome e muscolo primario;
- L'app deve mantenere la cronologia e i record per esercizio;
- La modifica dei metadati di un esercizio non deve alterare retroattivamente dati storici già consolidati.

### Requisiti di accettazione

- La ricerca esercizi deve restituire risultati immediati;
- L'utente deve poter aggiungere un esercizio al workout con pochi tap;
- L'app deve indicare chiaramente se l'esercizio è personalizzato;
- I gruppi muscolari devono essere utilizzabili nelle analytics.

---

## 3.4 Workout logging

### Descrizione

Flusso principale per creare, avviare, gestire e completare una sessione di allenamento.

### Obiettivo

Permettere una registrazione rapida, affidabile e utilizzabile direttamente in palestra.

### Priorità

**Must — MVP**

### Dati coinvolti

- Identificativo workout;
- Titolo workout;
- Data e ora di inizio;
- Data e ora di fine;
- Durata;
- Esercizi;
- Serie;
- Note sessione;
- Valutazione percepita della sessione;
- Stato: bozza, in corso, completato, annullato.

### Comportamento

- L'utente può creare un workout vuoto o partire da uno precedente;
- Può aggiungere, rimuovere, riordinare e duplicare esercizi;
- Può avviare un timer di recupero;
- Può salvare automaticamente una bozza durante la sessione;
- Può uscire e riprendere un workout in corso;
- Alla conclusione, visualizza un riepilogo della sessione;
- Un workout completato aggiorna dashboard, storico e analytics.

### Requisiti di accettazione

- L'inserimento di una serie deve richiedere il minor numero possibile di interazioni;
- L'app deve conservare i dati anche se viene chiusa accidentalmente;
- Il completamento workout deve essere esplicito;
- Un workout annullato non deve influenzare le metriche;
- Le modifiche a un workout completato devono ricalcolare le metriche interessate.

---

## 3.5 Gestione serie e recupero

### Descrizione

Modulo per registrare ogni serie con metriche fondamentali e facilitare il recupero tra serie.

### Obiettivo

Raccogliere dati di qualità senza rallentare l'utente.

### Priorità

**Must — MVP**

### Dati coinvolti

- Esercizio;
- Numero serie;
- Carico;
- Ripetizioni;
- RPE o RIR opzionale;
- Tipo serie: riscaldamento, lavoro, drop set, failure;
- Stato: completata, saltata;
- Timestamp;
- Durata recupero opzionale.

### Comportamento

- L'app precompila carico e ripetizioni dall'ultima esecuzione dell'esercizio;
- L'utente può modificare rapidamente i valori;
- Una serie può essere marcata come completata o saltata;
- Dopo il completamento di una serie, l'app può avviare un timer di recupero;
- L'utente può aggiungere RPE/RIR facoltativamente;
- Le serie di riscaldamento devono poter essere escluse dalle metriche di volume configurabili.

### Requisiti di accettazione

- Il sistema deve supportare carichi decimali;
- Le unità kg/lb devono rispettare le preferenze utente;
- I dati inseriti devono essere modificabili prima e dopo il completamento workout;
- Le serie non completate non devono essere incluse nel volume totale;
- Il timer deve continuare in background tramite meccanismi iOS consentiti.

---

## 3.6 Workout history

### Descrizione

Archivio cronologico dei workout completati, con visualizzazione sintetica e dettaglio modificabile.

### Obiettivo

Permettere all'utente di rivedere ciò che ha fatto e confrontare facilmente sessioni passate.

### Priorità

**Must — MVP**

### Dati coinvolti

- Data e durata workout;
- Titolo;
- Esercizi;
- Serie;
- Volume totale;
- Gruppi muscolari coinvolti;
- Note;
- Valutazione della sessione.

### Comportamento

- Lo storico mostra workout ordinati dal più recente;
- L'utente può filtrare per periodo, esercizio e gruppo muscolare;
- Ogni workout apre una schermata dettagliata;
- L'utente può duplicare un workout passato;
- La modifica di uno storico deve aggiornare analytics e insight.

### Requisiti di accettazione

- Lo storico deve restare navigabile anche con un numero elevato di workout;
- Deve essere possibile cercare un esercizio nello storico;
- Il dettaglio deve mostrare carichi e ripetizioni registrati;
- L'utente deve poter eliminare un workout con conferma esplicita.

---

## 3.7 Dashboard

### Descrizione

Schermata principale che riassume la situazione corrente dell'utente e mette in evidenza le informazioni più importanti.

### Obiettivo

Mostrare valore già all'apertura dell'app, senza costringere l'utente a navigare in grafici complessi.

### Priorità

**Must — MVP**

### Dati coinvolti

- Workout recenti;
- Workout della settimana;
- Streak di allenamento;
- Volume settimanale;
- Frequenza per muscolo;
- Ultimo workout;
- Progressi per esercizio;
- Insight AI;
- Stato sincronizzazione;
- Dati HealthKit opzionali.

### Comportamento

La dashboard deve includere:

- Saluto contestuale;
- Call to action primaria: `Inizia workout`;
- Riepilogo dei workout della settimana;
- Volume totale e confronto con settimana precedente;
- Insight AI prioritario;
- Progresso di uno o più esercizi principali;
- Eventuale indicatore di squilibrio muscolare;
- Accesso rapido ad analytics, storico e coach.

### Stati vuoti

Se l'utente non ha ancora workout registrati, la dashboard deve:

- Spiegare brevemente il valore del tracking;
- Invitare a iniziare il primo workout;
- Consentire l'import CSV;
- Evitare grafici vuoti privi di contesto.

### Requisiti di accettazione

- La dashboard deve caricarsi rapidamente;
- Il contenuto deve essere prioritizzato, non solo elencato;
- Un insight deve essere mostrato solo quando esistono dati sufficienti;
- Ogni card deve essere apribile per consultare il dettaglio;
- L'utente deve poter aggiornare la dashboard con gesto pull-to-refresh.

---

## 3.8 Analytics

### Descrizione

Area dedicata all'analisi dei dati di allenamento nel tempo.

### Obiettivo

Consentire a utenti intermedi e avanzati di comprendere trend, progressione, volume e distribuzione del lavoro.

### Priorità

**Must — MVP**

### Dati coinvolti

- Volume per workout;
- Volume per esercizio;
- Volume per gruppo muscolare;
- Numero serie allenanti;
- Frequenza di allenamento;
- Carico massimo;
- Reps e carico per serie;
- Stima one-repetition maximum;
- Trend temporali;
- Distribuzione per pattern di movimento.

### Metriche MVP

| Metrica | Definizione |
|---|---|
| Volume carico | Somma di `carico × ripetizioni` per serie completata |
| Serie allenanti | Numero di serie di lavoro completate |
| Frequenza muscolare | Numero di giorni in cui un muscolo è stato allenato |
| Progressione esercizio | Variazione nel tempo di carico, ripetizioni, volume e stima 1RM |
| 1RM stimato | Stima basata su formula configurabile, mostrata come indicativa |
| Bilanciamento muscolare | Distribuzione relativa di serie o volume tra gruppi muscolari |
| Streak | Numero di settimane consecutive con almeno un workout completato |

### Comportamento

- L'utente può filtrare i dati per 7 giorni, 30 giorni, 90 giorni, anno e intervallo personalizzato;
- Può selezionare esercizi specifici;
- Può confrontare periodo corrente e periodo precedente;
- I grafici devono includere un breve testo interpretativo;
- L'app non deve presentare correlazioni come causalità;
- Le metriche devono distinguere dati completi da dati insufficienti.

### Requisiti di accettazione

- I grafici devono essere leggibili su iPhone;
- Ogni metrica deve mostrare definizione e periodo di calcolo;
- I filtri devono aggiornare i dati in modo coerente;
- L'app deve segnalare quando uno storico troppo breve rende una conclusione poco affidabile;
- L'utente deve poter accedere dal grafico al workout che ha generato un dato rilevante.

---

## 3.9 AI Coach

### Descrizione

Assistente conversazionale e sistema di insight che usa il contesto del profilo e dello storico workout per aiutare l'utente a interpretare i propri dati.

### Obiettivo

Trasformare analytics e storico in decisioni semplici, contestuali e spiegabili.

### Priorità

**Must — MVP**

### Dati coinvolti

- Profilo e obiettivi utente;
- Preferenze di allenamento;
- Workout recenti;
- Storico esercizi;
- Volume, frequenza e trend;
- Insight pre-calcolati;
- Dati HealthKit autorizzati;
- Messaggi conversazionali;
- Feedback utente sugli insight.

### Comportamento

L'AI Coach deve supportare due modalità.

#### Insight proattivi

L'app mostra insight brevi e prioritizzati, ad esempio:

- Progressione positiva o stabile su un esercizio;
- Possibile stallo;
- Aumento o riduzione significativa del volume;
- Gruppi muscolari allenati meno frequentemente;
- Costanza positiva;
- Dati insufficienti per formulare raccomandazioni.

Ogni insight deve includere:

- Titolo;
- Spiegazione semplice;
- Dati osservati;
- Periodo analizzato;
- Livello di confidenza;
- Azione suggerita;
- Disclaimer quando appropriato.

#### Chat AI

L'utente può fare domande come:

- `Sto progredendo nella panca piana?`
- `Quale muscolo sto allenando meno?`
- `Il mio volume per il petto è aumentato?`
- `Cosa potrei cambiare nel prossimo workout?`
- `Perché il mio squat è fermo?`

L'AI deve rispondere usando il contesto disponibile, dichiarando limiti e incertezza dei dati.

### Regole di sicurezza

- L'AI non deve diagnosticare infortuni o condizioni mediche;
- Non deve prescrivere trattamenti, farmaci o diete cliniche;
- Non deve incoraggiare comportamenti pericolosi;
- Deve consigliare di consultare professionisti qualificati quando l'utente riferisce dolore, infortuni, disturbi alimentari o condizioni cliniche;
- Deve distinguere suggerimenti generali da indicazioni mediche;
- Non deve inventare dati non presenti nello storico.

### Requisiti di accettazione

- Ogni risposta basata sui dati deve citare il periodo o i workout analizzati;
- L'AI deve indicare quando non esistono dati sufficienti;
- L'utente deve poter fornire feedback positivo o negativo a un insight;
- L'utente deve poter cancellare la cronologia chat;
- Nessuna risposta deve essere presentata come diagnosi o garanzia di risultato;
- L'utente deve poter disabilitare AI Coach senza perdere le funzioni base di tracking.

---

## 3.10 Workout Import CSV

### Descrizione

Funzione che permette di importare workout storici da un file CSV.

### Obiettivo

Ridurre la barriera di migrazione da fogli di calcolo o altre soluzioni di tracking.

### Priorità

**Should — MVP**

### Dati coinvolti

- File CSV;
- Data workout;
- Nome workout;
- Nome esercizio;
- Serie;
- Ripetizioni;
- Carico;
- RPE/RIR opzionale;
- Note opzionali.

### Formato CSV MVP

Il formato supportato deve includere le seguenti colonne:

| Colonna | Obbligatoria | Esempio |
|---|---:|---|
| `date` | Sì | `2026-07-30` |
| `workout_name` | No | `Push Day` |
| `exercise_name` | Sì | `Bench Press` |
| `set_number` | Sì | `1` |
| `weight` | Sì | `80` |
| `reps` | Sì | `8` |
| `unit` | No | `kg` |
| `rpe` | No | `8` |
| `notes` | No | `Good form` |

### Comportamento

1. L'utente seleziona un file CSV dal selettore file iOS.
2. L'app valida colonne e formati.
3. Mostra una preview dei dati e degli errori.
4. L'utente può mappare colonne non riconosciute.
5. L'app segnala possibili duplicati.
6. L'utente conferma l'importazione.
7. I workout importati aggiornano storico, analytics e AI Coach.

### Requisiti di accettazione

- Nessun dato deve essere importato senza conferma;
- Gli errori devono indicare riga e motivo;
- L'importazione deve essere annullabile prima della conferma;
- I duplicati devono essere segnalati;
- I record importati devono mantenere un metadato di origine `CSV Import`.

---

## 3.11 HealthKit

### Descrizione

Integrazione opzionale con Apple Health per arricchire il contesto di attività dell'utente.

### Obiettivo

Aggiungere segnali di attività e, in versioni successive, di recupero senza rendere HealthKit indispensabile.

### Priorità

**Should — MVP**

### Dati MVP

- Passi;
- Calorie attive;
- Workout registrati in Apple Health;
- Minuti di esercizio, se disponibili.

### Dati futuri possibili

- Sonno;
- Frequenza cardiaca a riposo;
- Heart rate variability;
- Dati cardio;
- Mindful minutes;
- Altri dati autorizzati dall'utente.

### Comportamento

- HealthKit è sempre opzionale;
- L'utente seleziona esplicitamente i permessi;
- L'app deve spiegare perché ogni categoria è richiesta;
- La dashboard può mostrare dati sintetici di attività;
- I dati HealthKit possono contestualizzare gli insight, senza generare conclusioni mediche;
- La revoca dell'autorizzazione non deve impedire l'uso del workout logging.

### Requisiti di accettazione

- Nessun dato HealthKit deve essere letto senza autorizzazione;
- L'utente deve poter modificare le autorizzazioni in qualsiasi momento;
- L'app deve funzionare correttamente se HealthKit è non disponibile;
- I dati mostrati devono distinguere origine PeakLift e origine Apple Health quando rilevante.

---

## 3.12 Privacy, controllo dati e sicurezza

### Descrizione

Insieme di controlli e requisiti per garantire trasparenza, consenso e controllo sui dati personali.

### Obiettivo

Costruire fiducia, rispettare i principi privacy-by-design e permettere l'uso consapevole delle funzionalità AI e HealthKit.

### Priorità

**Must — MVP**

### Requisiti funzionali

- Informativa privacy accessibile dall'onboarding e dalle impostazioni;
- Consensi separati per account, AI Coach e HealthKit;
- Possibilità di revocare i consensi;
- Esportazione dati utente;
- Eliminazione account e dati;
- Cancellazione cronologia chat AI;
- Controllo delle notifiche;
- Indicazione chiara delle fonti dati usate dagli insight.

### Requisiti di sicurezza

- Protezione dei dati locali tramite meccanismi di sicurezza iOS;
- Trasmissione dati su connessioni protette;
- Minimizzazione dei dati inviati a servizi AI esterni;
- Nessun uso dei dati utente per addestramento di modelli senza consenso esplicito;
- Logging tecnico privo di dati sanitari identificabili quando possibile.

---

## 4. User Journey

## 4.1 Primo avvio

1. L'utente scarica e apre PeakLift.
2. Visualizza una breve schermata introduttiva con la promessa di valore.
3. Comprende che l'app combina tracking e coaching AI.
4. Decide se creare un profilo o utilizzare la sincronizzazione iCloud.
5. Inizia l'onboarding.

### Successo del journey

L'utente comprende, entro pochi secondi, che PeakLift non è un tracker generico ma uno strumento per capire e migliorare i propri allenamenti.

---

## 4.2 Onboarding

1. L'utente seleziona il proprio obiettivo principale.
2. Specifica livello di esperienza e frequenza desiderata.
3. Seleziona unità di misura.
4. Indica eventuali preferenze di attrezzatura e muscoli prioritari.
5. Autorizza o ignora HealthKit.
6. Accetta o rifiuta l'uso dell'AI Coach.
7. Viene portato alla dashboard iniziale.

### Successo del journey

L'utente può iniziare a usare l'app senza blocchi, anche se non autorizza HealthKit o AI Coach.

---

## 4.3 Primo workout

1. Dalla dashboard l'utente seleziona `Inizia workout`.
2. Crea una sessione vuota oppure aggiunge esercizi dalla libreria.
3. Registra carico e ripetizioni per ogni serie.
4. Usa, se lo desidera, timer di recupero e RPE.
5. Completa il workout.
6. Visualizza un riepilogo con volume, esercizi e primo insight.
7. La dashboard e le analytics si aggiornano.

### Successo del journey

L'utente completa un primo workout senza bisogno di istruzioni esterne e percepisce immediatamente il valore del riepilogo.

---

## 4.4 Utilizzo quotidiano

1. L'utente apre l'app prima dell'allenamento.
2. Consulta il suggerimento o insight prioritario.
3. Avvia un nuovo workout o duplica una sessione precedente.
4. Registra le serie in palestra.
5. Completa il workout.
6. Riceve un riepilogo e, se disponibili, insight contestuali.
7. Nei giorni senza allenamento può consultare progressi e AI Coach.

### Successo del journey

PeakLift diventa parte della routine: apertura rapida, logging semplice e valore analitico progressivo.

---

## 4.5 Consultazione progressi

1. L'utente apre la sezione Analytics.
2. Seleziona un intervallo temporale.
3. Consulta volume, frequenza, equilibrio muscolare o trend di un esercizio.
4. Tocca un grafico per approfondire i workout coinvolti.
5. Apre AI Coach per fare una domanda sul trend.
6. Riceve una risposta basata sui propri dati e un'azione suggerita.

### Successo del journey

L'utente capisce come sta evolvendo il proprio allenamento e può prendere una decisione concreta per le sessioni successive.

---

## 5. UX Requirements

## 5.1 Principi di design

PeakLift deve riflettere un'esperienza Apple-like:

- Pulita;
- Veloce;
- Nativa;
- Accessibile;
- Chiara;
- Basata sulla gerarchia delle informazioni;
- Utilizzabile con una mano e durante una sessione in palestra.

L'interfaccia deve ridurre il carico cognitivo. Il prodotto deve mostrare prima l'azione più importante e rendere l'approfondimento progressivo.

---

## 5.2 Navigazione

La navigazione principale MVP deve usare una tab bar con cinque aree:

| Tab | Finalità |
|---|---|
| Oggi | Dashboard, insight e call to action workout |
| Workout | Avvio, gestione e storico allenamenti |
| Analytics | Grafici, volume, frequenza e progressi |
| Coach | Chat AI e archivio insight |
| Profilo | Preferenze, HealthKit, privacy e dati |

### Regole di navigazione

- Il pulsante `Inizia workout` deve essere sempre facilmente raggiungibile;
- Durante un workout, l'utente deve avere accesso rapido alle serie e al timer;
- Le azioni distruttive richiedono conferma;
- Le schermate devono supportare back navigation coerente;
- Gli stati di caricamento non devono bloccare il logging;
- Le funzioni AI devono degradare in modo elegante in caso di assenza rete.

---

## 5.3 UI requirements

### Workout logging

- Target touch ampi e facilmente raggiungibili;
- Inserimento numerico rapido;
- Precompilazione dell'ultima performance;
- Feedback visivo immediato quando una serie è completata;
- Timer leggibile e non invasivo;
- Salvataggio automatico della bozza.

### Dashboard

- Informazioni prioritizzate in card;
- Una sola call to action primaria;
- Insight concisi e azionabili;
- Nessuna saturazione di grafici;
- Empty state educativo per nuovi utenti.

### Analytics

- Grafici leggibili su schermi piccoli;
- Filtri temporali semplici;
- Tooltip con dettagli su tap;
- Spiegazione testuale della metrica;
- Colori accessibili e non utilizzati come unica fonte di significato.

### AI Coach

- Risposte strutturate e sintetiche;
- Distinzione visiva tra dati osservati, interpretazione e suggerimento;
- Disclaimer non invasivi ma chiari;
- Indicazione quando mancano dati sufficienti;
- Azioni suggerite facilmente salvabili o ignorabili.

---

## 5.4 Accessibilità

L'MVP deve supportare:

- Dynamic Type;
- VoiceOver;
- Contrasto adeguato;
- Supporto Dark Mode;
- Riduzione movimento;
- Etichette accessibili per controlli e grafici;
- Feedback non basato esclusivamente su colori;
- Localizzazione futura, con struttura testuale predisposta per italiano e inglese.

---

## 5.5 Performance

| Area | Requisito |
|---|---|
| Avvio app | Apertura percepita come rapida su dispositivi supportati |
| Logging serie | Risposta immediata alle interazioni principali |
| Salvataggio workout | Persistenza locale senza attese percepibili |
| Dashboard | Visualizzazione contenuto base anche senza rete |
| Analytics | Caricamento progressivo per storici molto lunghi |
| AI Coach | Stato di elaborazione chiaro, possibilità di riprovare in caso di errore |
| Offline mode | Logging e storico disponibili senza connessione |

---

## 6. Prioritization Framework

### Must

Funzionalità indispensabili per validare la proposta di valore e consentire il rilascio MVP.

- Onboarding;
- Persistenza e sincronizzazione dati;
- Libreria esercizi;
- Workout logging;
- Gestione serie;
- Storico workout;
- Dashboard;
- Analytics essenziali;
- AI Coach base;
- Privacy controls.

### Should

Funzionalità importanti, ma non necessarie al primo rilascio se compromettono qualità o tempi.

- HealthKit base;
- Import CSV;
- Template workout;
- Export dati;
- Notifiche configurabili.

### Could

Funzionalità utili, da considerare dopo la validazione dell'MVP.

- Widget;
- Apple Watch companion;
- Gamification;
- Insight recovery avanzati;
- Import da piattaforme esterne.

### Won't for now

Funzionalità esplicitamente escluse dalla fase iniziale.

- Social pubblico;
- Video form analysis;
- Diagnosi mediche;
- Piani nutrizionali;
- Marketplace coach;
- Generazione completa automatica dei programmi;
- Supporto Android.

---

## 7. Roadmap

> Le tempistiche sono indicative e devono essere adattate a team, capacità tecnica, beta feedback e vincoli di rilascio App Store.

| Fase | Obiettivo | Deliverable principali | Dipendenze |
|---|---|---|---|
| Discovery | Validare problema, utenti e flussi principali | User research, user flows, data model, prototipi UX | Product Vision |
| Foundation | Creare le basi del prodotto | SwiftData, CloudKit, modello dati, libreria esercizi, onboarding | Architettura iOS |
| MVP Core | Rendere possibile tracking completo | Workout logging, serie, timer, storico, dashboard base | Data model, UX |
| MVP Intelligence | Trasformare tracking in valore | Analytics, insight AI, chat base, privacy controls | Dati storici, AI API |
| MVP Beta | Validare con utenti reali | TestFlight, osservabilità, bug fixing, feedback loop | Core MVP completo |
| MVP Launch | Pubblicazione iniziale | App Store listing, supporto, analytics prodotto | App review, privacy policy |
| V2 Planning | Pianificare evoluzione | Template, progressione, import migliorato, export | Feedback MVP |
| V2 Delivery | Aumentare profondità e retention | Program builder, suggerimenti avanzati, HealthKit esteso | Dati e validazione |
| Future Expansion | Ecosistema e funzioni avanzate | Apple Watch, Vision Framework, social privato | Maturità prodotto, consenso utente |

---

## 8. Milestone di rilascio

### Milestone 1 — Product Definition

**Output**

- PRD approvato;
- Modello dati definito;
- Flussi principali validati;
- Design system iniziale;
- Scope MVP congelato.

**Criterio di uscita**

Il team può iniziare lo sviluppo senza ambiguità sui flussi core.

---

### Milestone 2 — Core Workout Experience

**Output**

- Onboarding;
- Libreria esercizi;
- Creazione workout;
- Registrazione serie;
- Timer recupero;
- Storico locale;
- Gestione bozza workout.

**Criterio di uscita**

Un utente può completare e rivedere un workout interamente offline.

---

### Milestone 3 — Insights Foundation

**Output**

- Dashboard;
- Metriche volume e frequenza;
- Progressione esercizi;
- Analytics MVP;
- Stati vuoti e dati insufficienti.

**Criterio di uscita**

Un utente con almeno alcune sessioni registrate può leggere trend comprensibili.

---

### Milestone 4 — AI Coach Beta

**Output**

- Insight proattivi;
- Chat AI contestuale;
- Safety guardrails;
- Feedback sugli insight;
- Gestione errori AI;
- Controlli privacy dedicati.

**Criterio di uscita**

L'AI Coach usa esclusivamente dati autorizzati, dichiara i limiti ed è valutabile da beta tester.

---

### Milestone 5 — MVP Release

**Output**

- Sincronizzazione CloudKit;
- HealthKit base opzionale;
- Import CSV opzionale;
- Privacy center;
- TestFlight completo;
- Bug fixing e ottimizzazione performance;
- Pubblicazione App Store.

**Criterio di uscita**

Il prodotto è stabile, utilizzabile e conforme ai requisiti di privacy definiti.

---

## 9. Dipendenze

| Area | Dipendenza | Impatto |
|---|---|---|
| Persistenza | SwiftData | Gestione dati offline e modello dominio |
| Sincronizzazione | CloudKit | Disponibilità dati su più dispositivi |
| Dati salute | HealthKit | Attività e contesto opzionale |
| AI Coach | Provider AI API | Chat, insight e analisi testuale |
| Sicurezza AI | Guardrails e filtering | Sicurezza risposte e limiti del coaching |
| UX | Design system SwiftUI | Coerenza visiva e velocità sviluppo |
| Privacy | Informativa e gestione consensi | Rilascio e fiducia utente |
| Import | CSV parser e validatore | Migrazione dati da fonti esterne |
| Qualità | Telemetria e crash reporting | Stabilità e analisi utilizzo |

---

## 10. Rischi e mitigazioni

| Rischio | Impatto | Mitigazione |
|---|---|---|
| Logging troppo lento | Abbandono durante l'allenamento | Precompilazione, UX test, azioni rapide |
| Dati insufficienti per insight | Percezione AI poco utile | Empty state educativi, soglie minime, import CSV |
| Insight AI poco affidabili | Perdita di fiducia | Risposte spiegabili, contesto dati, feedback, guardrails |
| Dipendenza da rete per AI | Esperienza interrotta | Analytics locali, retry, cache insight |
| Privacy percepita come invasiva | Rifiuto di HealthKit e AI | Consensi granulari, minimizzazione e trasparenza |
| Analytics troppo tecniche | Confusione utenti beginner | Progressive disclosure e linguaggio semplice |
| Scope MVP troppo ampio | Ritardi e bassa qualità | Prioritizzazione Must/Should/Could rigorosa |
| Ambiguità su recovery | Rischio di suggerimenti impropri | Linguaggio prudente, nessuna diagnosi, disclaimer |

---

## 11. Success Metrics

### North Star Metric

> Numero di utenti che completano almeno tre workout a settimana per quattro settimane consecutive e consultano almeno un insight AI rilevante nel periodo.

### KPI di prodotto

| Area | KPI | Definizione |
|---|---|---|
| Activation | First Workout Completion Rate | Utenti che completano il primo workout dopo onboarding |
| Time to Value | Tempo al primo workout completato | Tempo tra installazione e primo workout |
| Engagement | Workout per WAU | Numero medio di workout per utente attivo settimanale |
| Retention | D7, D30, D90 retention | Utenti che tornano dopo 7, 30 e 90 giorni |
| AI Adoption | AI Insight View Rate | Utenti attivi che visualizzano almeno un insight |
| AI Engagement | Coach Interaction Rate | Utenti che interagiscono con chat o insight AI |
| Actionability | Insight Action Rate | Insight salvati, accettati o seguiti |
| Consistency | Active Training Weeks | Settimane consecutive con almeno un workout |
| Data Quality | Workout Completion Quality | Workout con esercizi e serie validamente completati |
| Trust | AI Feedback Score | Valutazione esplicita degli insight |
| Growth | New Active Users | Nuovi utenti che completano almeno un workout |
| Monetization | Premium Conversion Rate | Da definire dopo validazione del modello free/premium |

---

## 12. Open Questions

- Quale modello di monetizzazione sarà adottato: freemium, abbonamento o acquisto una tantum?
- Quali metriche di volume saranno configurabili dall'utente?
- Quale formula di 1RM sarà usata come default?
- Il supporto RPE, RIR e training to failure sarà richiesto nell'MVP o introdotto gradualmente?
- Quale provider AI soddisfa requisiti di costo, qualità, privacy e latenza?
- I dati inviati all'AI saranno elaborati in forma aggregata, anonima o pseudonimizzata?
- Quali fonti CSV devono essere supportate per prime?
- HealthKit base deve essere incluso al lancio oppure dopo la validazione del core tracking?
- Quali soglie devono attivare un insight su stallo, aumento volume o squilibrio?
- L'app sarà inizialmente disponibile in italiano, inglese o entrambe le lingue?

---

## 13. Definition of Done MVP

L'MVP è pronto per il rilascio quando:

- Un nuovo utente completa onboarding e registra il primo workout senza assistenza;
- L'utente può creare, modificare, completare e rivedere workout;
- Volume, frequenza e trend base vengono calcolati correttamente;
- La dashboard mostra informazioni utili anche in presenza di pochi dati;
- L'AI Coach produce insight contestuali, prudenziali e spiegabili;
- L'utente può usare l'app senza HealthKit e può disabilitare l'AI;
- I dati vengono salvati localmente e sincronizzati quando possibile;
- Sono disponibili controlli per privacy, esportazione ed eliminazione dati;
- I principali flussi sono accessibili, performanti e testati su dispositivi iOS supportati;
- Non esistono bug bloccanti relativi a perdita dati, completamento workout o privacy.