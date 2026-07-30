# AI Architecture Documentation
# PeakLift

> **Versione:** 1.0  
> **Stato:** Draft  
> **Piattaforma:** iOS  
> **Provider iniziale:** OpenAI API tramite AI Gateway sicuro  
> **Architettura:** Local-first analytics, provider abstraction, server-side orchestration  
> **Destinatari:** Software Architect, iOS Engineer, Backend/AI Engineer, QA, AI coding agent  
> **Documenti correlati:** Vision, PRD, SRS, TDD, Design System Documentation  

---

## 1. AI Vision

### 1.1 Obiettivo

PeakLift usa l’intelligenza artificiale per trasformare dati di allenamento in decisioni più chiare e personali.

L’AI non sostituisce il tracking tradizionale. Lo completa attraverso analisi contestuali, spiegazioni leggibili e suggerimenti prudenti basati sui dati effettivamente disponibili.

Il prodotto deve essere percepito come un:

> **AI Fitness Coach personale basato sui dati dell’utente**

L’obiettivo non è creare una chat generica sul fitness. L’obiettivo è aiutare l’utente a comprendere:

- come stanno evolvendo carichi, ripetizioni e volume;
- quali esercizi stanno progredendo o rallentando;
- come è distribuito il volume tra gruppi muscolari;
- se la frequenza di allenamento è coerente con l’obiettivo dichiarato;
- quali aspetti del proprio storico meritano attenzione;
- quale piccola azione pratica può considerare nel prossimo allenamento.

---

### 1.2 Valore rispetto a un tracker tradizionale

| App di tracking tradizionale | PeakLift AI Fitness Coach |
|---|---|
| Registra carichi e ripetizioni | Registra e interpreta carichi, ripetizioni e trend |
| Mostra grafici | Spiega i grafici in linguaggio naturale |
| Mostra volume e frequenza | Evidenzia variazioni e possibili implicazioni |
| Lascia l’interpretazione all’utente | Fornisce insight contestuali e azionabili |
| Offre dati statici | Adatta il contesto a storico, obiettivi e preferenze |
| Chat generica opzionale | Coach conversazionale basato su dati autorizzati |

---

### 1.3 Principi AI

- **Data-grounded:** ogni insight deve derivare da dati misurabili o da una dichiarazione esplicita di dati insufficienti.
- **Explainable:** le risposte devono distinguere dati osservati, interpretazione e azione suggerita.
- **Conservative:** l’AI non deve trasformare correlazioni incomplete in certezze.
- **Privacy-first:** il contesto inviato al modello deve essere minimizzato e autorizzato.
- **Offline-resilient:** tracking, analytics locali e storico restano disponibili senza AI.
- **User-controlled:** AI Coach, utilizzo dati HealthKit e cronologia chat sono opzionali.
- **Provider-agnostic:** il dominio applicativo non dipende direttamente da un singolo LLM provider.
- **Safe by default:** richieste mediche, diagnostiche o pericolose richiedono fallback prudente.

---

### 1.4 Limiti del sistema

L’AI di PeakLift non deve:

- inventare workout, metriche, personal record o tendenze non presenti nel contesto;
- dichiarare di aver osservato dati non inclusi nella richiesta;
- diagnosticare infortuni, patologie, disturbi o condizioni cliniche;
- prescrivere trattamenti medici, fisioterapici, nutrizionali o farmacologici;
- sostituire medico, fisioterapista, dietista o trainer qualificato;
- offrire suggerimenti pericolosi o eccessivamente categorici;
- fornire indicazioni di allenamento senza dichiarare eventuali limiti dei dati;
- memorizzare o utilizzare dati oltre il consenso accordato dall’utente;
- bloccare il workout logging se il servizio AI non è disponibile.

---

## 2. AI System Architecture

### 2.1 Architettura generale

```text
Utente
    │
    ▼
iOS Application
    │
    ├── SwiftUI Views
    ├── ViewModels
    └── AI Use Cases
    │
    ▼
Fitness Data Layer
    │
    ├── SwiftData
    ├── CloudKit Sync State
    ├── HealthKit Aggregates
    └── User Preferences and Consents
    │
    ▼
Local Analytics Engine
    │
    ├── Volume
    ├── Frequency
    ├── Progression
    ├── Personal Records
    ├── Muscle Distribution
    └── Data Sufficiency Evaluation
    │
    ▼
AI Context Builder
    │
    ├── Consent Filter
    ├── Data Minimizer
    ├── Context Selector
    ├── Token Budget Manager
    └── Context Snapshot
    │
    ▼
AI Orchestration Layer
    │
    ├── Prompt Manager
    ├── Safety Pre-check
    ├── Request Router
    ├── Provider Adapter
    ├── Cost and Rate Control
    └── Observability
    │
    ▼
AI Gateway Backend
    │
    ├── Authentication
    ├── Request Validation
    ├── Prompt Execution
    ├── Provider Routing
    ├── Output Validation
    └── Audit Events
    │
    ▼
LLM Provider
    │
    ├── OpenAI API
    ├── Future: Anthropic Claude
    ├── Future: Google Gemini
    ├── Future: Apple Intelligence
    └── Future: On-device Model
    │
    ▼
Response Validation
    │
    ├── Schema Validation
    ├── Safety Validation
    ├── Grounding Validation
    ├── Confidence Assessment
    └── Fallback Handler
    │
    ▼
User Interface
    ├── Insight Cards
    ├── Coach Chat
    ├── Workout Analysis
    └── Dashboard Summary
```

---

### 2.2 Layer responsibility

| Layer | Responsabilità |
|---|---|
| iOS Application | Invia richieste AI, mostra stati UI, gestisce consensi, persiste risultati e non espone segreti |
| Fitness Data Layer | Fornisce dati locali validati provenienti da SwiftData, CloudKit e HealthKit |
| Local Analytics Engine | Calcola metriche deterministiche, query, trend e indicatori di dati insufficienti |
| AI Context Builder | Seleziona, aggrega e riduce i dati autorizzati per una specifica richiesta |
| AI Orchestration Layer | Applica prompt, policy, routing provider, limiti e monitoraggio |
| AI Gateway Backend | Protegge API key, autentica richieste, esegue policy e comunica con provider esterni |
| LLM Provider | Genera output strutturato in base a prompt, contesto e schema |
| Response Validation | Valida struttura, sicurezza, grounding e coerenza della risposta |
| User Interface | Mostra risposte leggibili, spiegabili, opzionali e accessibili |

---

### 2.3 Flusso di una domanda Coach

```text
1. Utente invia una domanda al Coach
2. App verifica consenso AI
3. App verifica connettività e disponibilità servizio
4. App identifica intent della domanda
5. Context Builder seleziona dati pertinenti
6. Analytics Engine produce metriche locali richieste
7. App minimizza e serializza il contesto
8. App invia richiesta autenticata all’AI Gateway
9. Gateway applica prompt e policy
10. Gateway chiama il provider LLM
11. Gateway valida output strutturato e sicurezza
12. App riceve risposta validata
13. App salva conversazione e metadati locali
14. UI visualizza dati osservati, interpretazione e suggerimento
```

---

### 2.4 Principio local-first

Le operazioni che possono essere calcolate in modo deterministico devono rimanere locali.

| Operazione | Esecuzione primaria |
|---|---|
| Calcolo volume | Locale |
| Serie allenanti | Locale |
| Frequenza workout | Locale |
| Frequenza muscolare | Locale |
| Personal record | Locale |
| 1RM stimato | Locale |
| Distribuzione volume | Locale |
| Streak | Locale |
| Filtri e query storico | Locale |
| Riconoscimento di pattern base | Locale |
| Spiegazione in linguaggio naturale | AI |
| Prioritizzazione qualitativa insight | AI o sistema ibrido |
| Risposta a domanda conversazionale | AI |
| Riassunto di un periodo | AI con metriche locali |
| Generazione futura programma | AI con validazione regole locali |

L’AI non deve ricalcolare metriche core dai raw data quando l’app può fornire valori già validati.

---

## 3. AI Components

## 3.1 AI Service Layer

### Scopo

L’AI Service Layer definisce l’astrazione usata dal dominio PeakLift per richiedere insight, analisi e conversazioni AI.

Il layer non deve dipendere da OpenAI direttamente. Deve dipendere da un protocollo o contratto provider-agnostic.

### Responsabilità

- Inviare richieste al gateway AI.
- Gestire autenticazione della richiesta.
- Gestire timeout, retry controllati e rete assente.
- Convertire request domain in DTO di rete.
- Ricevere e decodificare risposte strutturate.
- Restituire errori tipizzati al layer superiore.
- Supportare provider mock per test e preview.
- Supportare provider disabilitato quando il consenso manca.
- Salvare metadati necessari per osservabilità e costo.

### Tipologie di servizio

| Servizio | Responsabilità |
|---|---|
| `AIService` | Contratto principale provider-agnostic |
| `RemoteAIService` | Implementazione che comunica con gateway backend |
| `MockAIService` | Risposte deterministiche per test, preview e UI test |
| `DisabledAIService` | Fallback quando AI è disattivata, non autorizzata o offline |
| `CachedAIService` | Restituisce insight cache validi quando disponibili |
| `LocalAIService` | Futura implementazione per modelli on-device |

---

### Error taxonomy

| Errore | Descrizione | UX richiesta |
|---|---|---|
| `consentMissing` | AI non autorizzata | Mostrare spiegazione e CTA consenso |
| `offline` | Connessione assente | Mostrare fallback locale e azione riprova |
| `rateLimited` | Limite richieste superato | Mostrare attesa e spiegazione breve |
| `timeout` | Provider o gateway non risponde | Consentire retry |
| `serviceUnavailable` | AI temporaneamente disabilitata | Mostrare insight locali disponibili |
| `invalidResponse` | Output non valido | Non mostrare risposta parziale; usare fallback |
| `safetyBlocked` | Richiesta o risposta non sicura | Mostrare messaggio prudente |
| `authenticationFailed` | Token utente non valido | Richiedere ri-autenticazione o riprova |
| `unknown` | Errore non classificato | Messaggio generico e logging tecnico |

---

## 3.2 Context Builder

### Scopo

Il Context Builder costruisce un contesto minimale, verificabile e specifico per l’intento della richiesta.

Non deve serializzare indiscriminatamente tutto lo storico utente. Deve selezionare solo dati rilevanti, autorizzati e necessari.

### Responsabilità

- Verificare consensi AI e HealthKit.
- Identificare domanda, area funzionale e priorità.
- Selezionare range temporale pertinente.
- Recuperare metriche locali già calcolate.
- Ridurre raw data in aggregati leggibili.
- Applicare data minimization.
- Gestire limite token e dimensione richiesta.
- Creare un context snapshot auditabile.
- Escludere dati non necessari o non autorizzati.
- Etichettare qualità e completezza dei dati.

### Context types

| Tipo | Quando usarlo |
|---|---|
| `dashboardInsightContext` | Insight proattivo Dashboard |
| `postWorkoutContext` | Riepilogo al completamento workout |
| `exerciseAnalysisContext` | Domanda o insight su un esercizio |
| `muscleBalanceContext` | Analisi volume e distribuzione muscolare |
| `weeklyReviewContext` | Riepilogo settimanale |
| `coachChatContext` | Conversazione libera ma contestualizzata |
| `programReviewContext` | Futuro: valutazione di una scheda |
| `recoveryContext` | Futuro: dati HealthKit autorizzati |

---

### Data minimization rules

- Inviare metriche aggregate prima di inviare singole serie.
- Inviare solo gli esercizi pertinenti alla domanda.
- Limitare workout recenti a una finestra configurabile.
- Escludere note utente, salvo consenso AI esplicito e rilevanza diretta.
- Non inviare email, Apple user identifier, device ID, token o log.
- Non inviare file CSV originali.
- Non inviare dati HealthKit senza consenso HealthKit e AI distinti.
- Non inviare dati di altri utenti o contenuti condivisi senza autorizzazione.
- Non includere intere conversazioni passate se è sufficiente un summary locale.

---

## 3.3 Prompt Manager

### Scopo

Il Prompt Manager gestisce prompt di sistema, template, versioni, configurazioni modello e policy associate a ogni funzionalità AI.

### Responsabilità

- Conservare prompt versionati.
- Separare system prompt, developer instruction e dati utente.
- Associare un prompt a una feature e a un output schema.
- Gestire rollout graduale delle versioni prompt.
- Supportare A/B test controllati, se autorizzati.
- Permettere rollback immediato a prompt stabile.
- Registrare `promptVersion` nei risultati AI.
- Garantire che policy di sicurezza non siano modificabili dal testo utente.

### Prompt catalog

| Prompt ID | Funzione | Output |
|---|---|---|
| `insight.dashboard.v1` | Insight principale Dashboard | Insight strutturato |
| `insight.postWorkout.v1` | Riepilogo post workout | Insight e azione |
| `coach.chat.v1` | Conversazione Coach | Risposta conversazionale strutturata |
| `exercise.analysis.v1` | Analisi trend esercizio | Analisi esercizio |
| `muscle.balance.v1` | Commento distribuzione muscolare | Insight equilibrio |
| `weekly.review.v1` | Riepilogo settimanale | Review sintetica |
| `safety.redirect.v1` | Fallback medico o rischio | Risposta prudente |

---

## 3.4 Response Parser

### Scopo

Il Response Parser converte output del provider in modelli validati utilizzabili dalla UI e dal dominio.

### Responsabilità

- Verificare conformità allo schema.
- Rifiutare campi obbligatori mancanti.
- Validare enum e categorie consentite.
- Verificare limiti di lunghezza.
- Rimuovere markup non previsto.
- Validare riferimenti a metriche e periodi.
- Applicare safety check finale.
- Convertire response DTO in `AIInsight`, `CoachMessage` o `WorkoutAnalysis`.
- Generare fallback se la risposta è incompleta o non sicura.

### Regole parser

- Nessuna risposta libera deve essere mostrata direttamente alla UI.
- Ogni risposta deve contenere una categoria e almeno una sezione di evidenza o dichiarazione di insufficienza dati.
- Le raccomandazioni devono essere opzionali e formulate con linguaggio prudente.
- Il parser deve rifiutare claim clinici.
- Il parser deve rifiutare citazioni di metriche non presenti nel context snapshot.
- Il parser deve rifiutare istruzioni pericolose o non conformi alla safety policy.

---

## 3.5 Insight Engine

### Scopo

L’Insight Engine decide quando generare, aggiornare, cacheare, ordinare o ignorare insight.

È un sistema ibrido: regole locali deterministiche individuano candidati e l’AI può fornire spiegazione, priorità e formulazione contestuale.

### Responsabilità

- Generare insight rule-based senza rete.
- Identificare eventi candidati per AI.
- Applicare soglie di dati minimi.
- Limitare frequenza di generazione.
- Evitare insight ripetitivi.
- Memorizzare insight e relativi context snapshot.
- Definire scadenza e invalidazione.
- Ordinare insight per rilevanza, novità e azionabilità.
- Registrare feedback utente.

### Prioritization factors

| Fattore | Descrizione |
|---|---|
| Relevance | Quanto l’insight è collegato a obiettivi e dati recenti |
| Evidence | Qualità, quantità e coerenza dei dati |
| Novelty | Evita di ripetere lo stesso messaggio |
| Actionability | Presenza di una possibile azione concreta |
| Risk | Priorità per segnali da comunicare con prudenza |
| Freshness | Quanto il dato è recente |
| User feedback | Insight salvati o valutati utili hanno maggiore valore futuro |

---

## 4. AI Data Pipeline

## 4.1 Input Layer

Il sistema riceve dati da fonti diverse. Ogni fonte deve essere classificata, validata e soggetta a consenso.

| Fonte | Dati | Stato consenso | Uso AI |
|---|---|---|---|
| SwiftData | Workout, esercizi, serie, metriche, preferenze | Core app | Disponibile solo con consenso AI |
| CloudKit | Replica dati utente sincronizzati | Account e sync | Non inviato direttamente; usato tramite source locale |
| HealthKit | Passi, calorie attive, workout e future metriche recovery | HealthKit + AI | Solo dati aggregati e autorizzati |
| Input utente | Domande Coach, preferenze, note autorizzate | AI consent | Usato per richiesta corrente |
| CSV import | Workout importati e normalizzati | Core app | Solo dopo validazione e consenso AI |
| AI feedback | Utile, non utile, salva, ignora | AI consent | Usato per migliorare prioritizzazione interna |

CloudKit non deve essere interrogato direttamente dall’AI Gateway per ricostruire lo storico. L’app iOS deve usare i dati locali sincronizzati e inviare esclusivamente un context snapshot minimizzato.

---

## 4.2 Data normalization

Prima dell’uso AI, i dati devono essere normalizzati.

| Campo | Regola |
|---|---|
| Carico | Archiviazione interna in kg |
| Unità UI | Conversione kg/lb solo in presentazione o contesto localizzato |
| Date | Archiviazione UTC; interpretazione nel timezone utente |
| Esercizi | Nome normalizzato e snapshot storico preservato |
| Serie | Identificazione chiara di warm-up, working, skipped e drop set |
| Volume | Calcolo standardizzato `carico × ripetizioni` |
| Muscoli | Relazioni primarie e secondarie con pesi di contribuzione |
| Dati mancanti | Esplicitamente marcati, mai sostituiti con ipotesi |
| HealthKit | Preferire aggregati giornalieri e intervalli, non campioni grezzi |

---

## 4.3 Analytics Layer

Le metriche locali sono la fonte di verità per numeri, confronti e trend.

### Metriche locali richieste

| Categoria | Metriche |
|---|---|
| Consistenza | Workout per settimana, streak, frequenza |
| Volume | Volume totale, per esercizio, per muscolo, per periodo |
| Serie | Serie completate, allenanti, warm-up e skipped |
| Progressione | Carico massimo, ripetizioni, volume, 1RM stimato |
| Personal record | Max weight, max reps, max volume, estimated 1RM |
| Distribuzione | Volume e serie per gruppo muscolare |
| Comparazione | Variazione rispetto al periodo precedente |
| Dati | Numero workout, numero serie, qualità campione |
| HealthKit opzionale | Passi, calorie attive, workout esterni aggregati |

### Analisi locali obbligatorie

- Calcolo volume.
- Conteggio serie allenanti.
- Calcolo frequenza.
- Confronto tra periodi.
- Identificazione PR.
- Identificazione esercizi con dati insufficienti.
- Identificazione trend quantitativi.
- Rilevazione di workout annullati o incompleti.
- Verifica qualità dati e anomalie evidenti.

### Analisi delegate all’AI

- Formulazione in linguaggio naturale.
- Collegamento ragionato tra metriche multiple.
- Prioritizzazione tra insight concorrenti.
- Sintesi di periodo.
- Risposta a domande aperte.
- Spiegazione di un grafico o trend.
- Proposta prudente di prossima azione.
- Personalizzazione tono e profondità in base all’esperienza utente.

---

## 4.4 AI request pipeline

```text
Raw App Data
    │
    ▼
Validation and Normalization
    │
    ▼
Local Analytics Calculation
    │
    ▼
Consent Filtering
    │
    ▼
Intent Classification
    │
    ▼
Context Selection
    │
    ▼
Aggregation and Token Reduction
    │
    ▼
AI Context Snapshot
    │
    ▼
Safety Pre-check
    │
    ▼
Gateway Request
    │
    ▼
Provider Response
    │
    ▼
Schema and Safety Validation
    │
    ▼
Persisted Insight or Coach Message
```

---

## 4.5 Context snapshot lifecycle

| Stato | Descrizione |
|---|---|
| Created | Contesto creato dal Context Builder |
| Sent | Contesto inviato al gateway |
| Processed | Risposta provider ricevuta |
| Validated | Output validato e utilizzabile |
| Rejected | Risposta non valida, non sicura o non grounded |
| Expired | Context non più rilevante per insight cache |
| Deleted | Rimosso in seguito a eliminazione chat o revoca consenso |

Il context snapshot deve poter essere collegato a insight e messaggi per spiegabilità, ma non deve contenere identificativi non necessari.

---

## 5. AI Context Design

## 5.1 Principio generale

Il contesto deve essere:

- **Minimo:** contiene solo ciò che serve alla richiesta.
- **Rilevante:** evita storia completa quando basta una finestra breve.
- **Strutturato:** usa campi e metriche, non lunghi testi non controllati.
- **Aggiornato:** generato al momento della richiesta o da cache ancora valida.
- **Autorizzato:** filtrato da consenso AI e HealthKit.
- **Tracciabile:** associato a versione prompt, periodo e origine dati.
- **Spiegabile:** i dati usati devono essere mostrabili in UI in forma comprensibile.

---

## 5.2 User Profile Context

| Campo | Inclusione | Note |
|---|---|---|
| Obiettivo principale | Sì | Forza, ipertrofia, ricomposizione, fitness generale |
| Livello esperienza | Sì | Regola tono e profondità |
| Unità preferita | Sì | Localizza output e metriche |
| Frequenza desiderata | Se disponibile | Utile per costanza |
| Muscoli prioritari | Se disponibili | Utile per insight mirati |
| Attrezzatura | Se rilevante | Utile per future raccomandazioni |
| Età | Solo se necessaria e consensuale | Non necessaria per MVP standard |
| Peso | Solo se rilevante e consensuale | Non inviare per default |
| Altezza | Solo se rilevante e consensuale | Non inviare per default |
| Nickname | No | Non necessario alla qualità insight |
| Email | Mai | Non necessaria |
| Apple user identifier | Mai | Identificativo sensibile |
| Device information | Mai | Non necessaria |

---

## 5.3 Training Profile Context

| Campo | Inclusione | Note |
|---|---|---|
| Workout per settimana | Sì | Aggregato |
| Split stimato | Se dati sufficienti | Deve essere definito come inferenza, non fatto assoluto |
| Esercizi principali | Sì, limitato | Solo quelli rilevanti |
| Frequenza muscolare | Sì | Aggregata |
| Volume per muscolo | Sì | Intervallo esplicito |
| Serie allenanti | Sì | Specificare esclusioni warm-up |
| Preferenze allenamento | Se utente le ha fornite | Non inferire senza dati |
| Programma futuro | Solo se inserito dall’utente | Futuro V3+ |

---

## 5.4 Recent Activity Context

| Dato | Regola |
|---|---|
| Ultimi workout | Limitare a 3–8, in base all’intento |
| Periodo | Usare range esplicito |
| Esercizi rilevanti | Includere solo quelli collegati alla domanda |
| Performance | Preferire aggregati, top set e set rappresentativi |
| Progressioni | Includere trend locali già calcolati |
| Regressioni | Esplicitare evidenza e dimensione campione |
| Note | Solo se AI consent e rilevanza diretta |
| Workout annullati | Escludere da analytics standard |
| Workout incompleti | Segnalare come incompleti, non trattare come sessioni valide |

---

## 5.5 Fitness Metrics Context

| Metrica | Inclusione | Fonte |
|---|---|---|
| Volume settimanale | Sì | Analytics locale |
| Variazione volume | Sì se confronto valido | Analytics locale |
| Frequenza workout | Sì | Analytics locale |
| Frequenza per muscolo | Se rilevante | Analytics locale |
| Serie allenanti | Sì se rilevante | Analytics locale |
| Personal record | Se nuovo o rilevante | Personal record engine |
| 1RM stimato | Se campione sufficiente | Analytics locale |
| Streak | Se rilevante | Analytics locale |
| Recovery | Solo dati disponibili e non clinici | HealthKit / user input |
| Passi e calorie | Solo se doppio consenso | HealthKit aggregato |
| Confidence dati | Sì | Data quality evaluator |

---

## 5.6 Cosa evitare nel contesto

Non includere:

- Token di autenticazione.
- API key.
- Email o dati di contatto.
- Apple user identifier.
- Device identifier.
- Intere esportazioni CSV.
- Log applicativi.
- Informazioni non pertinenti alla domanda.
- Dati HealthKit non autorizzati.
- Conversazioni complete non necessarie.
- Dati di altri utenti.
- Dati medici o informazioni cliniche non necessarie.
- Istruzioni provenienti dall’utente che tentano di modificare policy o system prompt.

---

## 5.7 Token management

| Strategia | Descrizione |
|---|---|
| Aggregazione | Inviare metriche aggregate invece di ogni set |
| Finestra temporale | Ridurre periodo ai giorni o workout pertinenti |
| Selezione esercizi | Limitare a esercizi citati o rilevanti |
| Riassunto conversazioni | Salvare summary strutturato, non chat completa |
| Priorità contesto | Obiettivo, intent, metriche, workout recenti, note |
| Budget dinamico | Domande brevi ricevono contesti più compatti |
| Cache summary | Riutilizzare summary validi di settimana o mese |
| Troncamento sicuro | Eliminare dati meno rilevanti prima di tagliare metriche core |

---

## 5.8 Confidence data model

Ogni risposta AI deve ricevere un livello di confidenza basato prima sulla qualità dei dati, non su un’autovalutazione libera del modello.

| Livello | Condizioni indicative |
|---|---|
| High | Campione consistente, trend chiaro, più workout e dati recenti |
| Medium | Dati utilizzabili ma con campione limitato o periodo breve |
| Low | Dati scarsi, incompleti, poco recenti o con variabilità elevata |
| Insufficient | Nessun dato sufficiente per una conclusione utile |

Il livello di confidenza deve essere visibile nella UI quando influenza significativamente l’interpretazione.

---

## 6. AI Features Architecture

## 6.1 AI Insights

### Scopo

Gli AI Insights sono messaggi proattivi, concisi e basati su eventi o trend reali. Devono aiutare l’utente senza generare rumore, ansia o sovraccarico cognitivo.

### Trigger

| Trigger | Azione |
|---|---|
| Completamento workout | Genera insight post-workout se dati sufficienti |
| Apertura Dashboard | Recupera insight cache valido o genera candidato |
| Fine settimana | Genera review settimanale opzionale |
| Nuovo PR | Genera achievement insight |
| Variazione volume rilevante | Genera insight volume |
| Stallo quantitativo | Genera insight prudente con evidenza |
| Squilibrio distribuzione | Genera insight informativo |
| Dati insufficienti | Suggerisce raccolta dati, non raccomandazioni |

### Categorie

| Categoria | Descrizione |
|---|---|
| `progress` | Evoluzione positiva di carico, ripetizioni, volume o costanza |
| `achievement` | Personal record, milestone o streak |
| `recommendation` | Suggerimento prudente e contestuale |
| `warning` | Situazione che merita attenzione senza claim clinici |
| `balance` | Distribuzione volume e frequenza muscolare |
| `consistency` | Costanza, aderenza e frequenza |
| `insufficientData` | Spiegazione di dati mancanti |
| `recoveryContext` | Futuro: segnali non clinici da dati autorizzati |

### Insight lifecycle

```text
Candidate
    │
    ▼
Rule-based eligibility check
    │
    ▼
Context building
    │
    ▼
AI generation or local fallback
    │
    ▼
Validation
    │
    ▼
Priority scoring
    │
    ▼
Display on Dashboard / Coach
    │
    ▼
User feedback
    │
    ▼
Expiration or refresh
```

### Frequency rules

- Massimo un insight prioritario sulla Dashboard.
- Evitare insight uguali entro un periodo configurabile.
- Non generare insight AI ogni volta che l’utente apre l’app.
- Non generare insight su dati inferiori alla soglia minima.
- Usare cache per insight settimanali.
- Consentire refresh manuale con rate limit.
- Disattivare insight AI quando consenso revocato.

---

## 6.2 AI Coach Chat

### Scopo

L’AI Coach permette domande conversazionali basate sui dati personali autorizzati.

Esempi:

- “Come sta andando la mia panca piana?”
- “Ho aumentato troppo il volume questa settimana?”
- “Quale gruppo muscolare ho allenato meno negli ultimi 30 giorni?”
- “Cosa posso osservare nel mio ultimo workout?”
- “Perché il mio volume è cambiato rispetto alla settimana scorsa?”

### Conversation model

```text
CoachConversation
├── Conversation ID
├── User ID
├── Title
├── Created At
├── Updated At
├── Summary Context
└── Messages
    ├── User Message
    ├── Assistant Message
    ├── Context Reference
    ├── Prompt Version
    ├── Safety Flag
    └── Delivery Status
```

### Memoria conversazionale

| Tipo memoria | Strategia |
|---|---|
| Messaggio corrente | Sempre incluso |
| Ultimi messaggi | Finestra limitata |
| Summary conversazione | Estratto strutturato locale |
| Profilo utente | Incluso solo se rilevante |
| Metriche correnti | Rigenerate per richiesta |
| Insight salvati | Inclusi solo se rilevanti |
| Note utente | Solo con consenso AI e pertinenza |
| Dati HealthKit | Solo con doppio consenso |

La memoria non deve essere trattata come una fonte affidabile equivalente ai dati fitness. Quando esistono conflitti, le metriche locali aggiornate devono prevalere.

---

## 6.3 Workout Analysis

### Scopo

Analizzare un singolo workout o una sequenza di workout per fornire un riepilogo utile.

### Input

- Durata workout.
- Esercizi eseguiti.
- Serie completate, saltate e warm-up.
- Carico, ripetizioni, RPE/RIR se disponibili.
- Volume totale.
- Confronto con workout precedenti.
- PR rilevati.
- Gruppi muscolari coinvolti.
- Eventuali dati HealthKit autorizzati e pertinenti.

### Output previsto

- Riepilogo oggettivo.
- Dati osservati.
- Elemento più significativo.
- Possibile interpretazione prudente.
- Prossimo passo opzionale.
- Livello confidenza.
- Disclaimer se necessario.

### Regole

- Non dichiarare affaticamento o recupero insufficiente come fatto clinico.
- Non suggerire aumento carico se i dati mostrano qualità insufficiente o valori incoerenti.
- Non usare una singola sessione per affermare uno stallo.
- Distinguere warm-up e working set.
- Indicare quando il confronto con storico non è disponibile.

---

## 6.4 Workout Program Review

Questa feature è futura e non appartiene al MVP iniziale.

### Input futuro

- Programma inserito dall’utente.
- Split settimanale.
- Obiettivi.
- Disponibilità allenamento.
- Attrezzatura.
- Storico performance.
- Preferenze allenamento.
- Vincoli e limitazioni dichiarate dall’utente.

### Output futuro

- Copertura esercizi e gruppi muscolari.
- Distribuzione volume.
- Frequenza stimata.
- Sovrapposizioni evidenti.
- Opzioni di modifica.
- Livello confidenza.
- Richiamo a professionista quando la richiesta riguarda dolore o infortunio.

---

## 6.5 Future AI Features

| Feature | Descrizione | Dipendenze |
|---|---|---|
| Program generation | Generazione assistita di programma | Regole locali, profilo, validazione umana |
| Adaptive progression | Suggerimenti su carico, rep e volume | Storico sufficiente, soglie di sicurezza |
| Deload detection | Segnalazione prudente di trend potenzialmente rilevanti | Dati coerenti e HealthKit opzionale |
| Proactive coach | Check-in e insight personalizzati | Notifiche, consenso, caching |
| On-device summarization | Riassunto locale analytics | Modelli locali o Apple Intelligence |
| Vision analysis | Analisi movimento opzionale | Consenso media, Vision Framework |
| Form education | Feedback educativo su video | Policy safety, disclaimer, dati locali |
| Apple Watch coach | Prompt e check-in durante workout | Watch app, HealthKit, sync |
| Coach mode | Condivisione selettiva con trainer | ACL, shared CloudKit, audit log |

---

## 7. Prompt Engineering Architecture

## 7.1 Prompt composition

Ogni richiesta AI è composta da livelli separati.

```text
System Prompt
    │
    ├── Product role
    ├── Safety rules
    ├── Grounding policy
    ├── Tone rules
    └── Output schema
    │
Developer Instructions
    │
    ├── Feature-specific objective
    ├── Context interpretation rules
    ├── Validation constraints
    └── Locale instructions
    │
Context Snapshot
    │
    ├── User profile
    ├── Relevant metrics
    ├── Recent activity
    ├── Data quality
    └── Consent metadata
    │
User Prompt
    │
    ├── User question
    ├── Requested timeframe
    └── Optional focus
```

Il testo utente non deve poter sovrascrivere prompt di sistema, policy, schema o limiti di sicurezza.

---

## 7.2 System prompt principles

Il system prompt deve definire l’AI come coach fitness prudente e data-grounded.

### Personalità

- Calma.
- Motivante.
- Precisa.
- Non giudicante.
- Concisa per default.
- Tecnica quando l’utente mostra esperienza o lo richiede.
- Educativa per utenti principianti.
- Trasparente sui limiti.

### Regole fondamentali

- Usa esclusivamente i dati contenuti nel context snapshot.
- Non inventare metriche o workout.
- Dichiara dati insufficienti quando necessario.
- Distingui sempre osservazione, interpretazione e suggerimento.
- Usa formulazioni probabilistiche quando non esiste certezza.
- Non fare diagnosi o prescrizioni.
- Suggerisci supporto professionale per dolore, infortunio o sintomi.
- Non fornire piani nutrizionali o medici.
- Rispetta output schema.
- Rispetta lingua e unità preferite dall’utente.

---

## 7.3 User prompt structure

Il prompt utente deve restare semplice e naturale nella UI, ma essere arricchito dal sistema in modo strutturato.

```text
Intent:
- coach_question
- exercise_analysis
- workout_review
- weekly_review
- muscle_balance_analysis

User question:
- testo originale utente

Requested scope:
- esercizio, periodo o area richiesta

Context availability:
- high, medium, low, insufficient

Relevant context:
- snapshot strutturato

Output constraints:
- schema previsto
- lingua
- livello dettaglio
```

---

## 7.4 Output schema

Il provider deve produrre JSON strutturato o un equivalente schema-constrained.

### Generic AI response schema

```json
{
  "response_type": "insight | coach_answer | workout_analysis",
  "category": "progress | achievement | recommendation | warning | balance | consistency | insufficient_data",
  "title": "string",
  "summary": "string",
  "observed_facts": [
    {
      "fact": "string",
      "metric_reference": "string",
      "period": "string"
    }
  ],
  "interpretation": "string",
  "suggested_action": "string | null",
  "confidence": "high | medium | low | insufficient",
  "data_limitations": [
    "string"
  ],
  "safety_note": "string | null",
  "follow_up_questions": [
    "string"
  ]
}
```

### Regole output

- `observed_facts` deve contenere solo metriche disponibili nel contesto.
- `summary` deve essere breve e utile nella UI.
- `interpretation` non deve essere presentata come diagnosi.
- `suggested_action` deve essere opzionale e non imperativa.
- `data_limitations` è obbligatorio quando confidence è low o insufficient.
- `safety_note` è obbligatorio se la richiesta è potenzialmente medica o rischiosa.
- `follow_up_questions` deve contenere massimo tre opzioni pertinenti.

---

## 7.5 Output schema per AI Insight

```json
{
  "category": "progress",
  "priority": 1,
  "title": "Progressione costante nella panca piana",
  "summary": "Il carico migliore è aumentato nel periodo analizzato.",
  "observed_facts": [
    {
      "fact": "Top set aumentato da 75 kg a 80 kg",
      "period": "ultimi 30 giorni"
    }
  ],
  "interpretation": "I dati indicano una progressione positiva nell'esercizio.",
  "suggested_action": "Puoi continuare con una progressione graduale, monitorando qualità delle serie e recupero.",
  "confidence": "medium",
  "data_limitations": [],
  "safety_note": null
}
```

---

## 7.6 Prompt versioning

| Campo | Descrizione |
|---|---|
| `promptId` | Identificativo stabile |
| `promptVersion` | Versione semantica o incrementale |
| `feature` | Feature collegata |
| `modelProfile` | Modello e configurazione |
| `schemaVersion` | Versione output schema |
| `status` | Draft, internal, beta, production, deprecated |
| `rolloutPercentage` | Percentuale utenti coinvolti |
| `createdAt` | Data creazione |
| `approvedBy` | Responsabile tecnico/prodotto |
| `rollbackTarget` | Versione stabile precedente |

Ogni insight o messaggio AI persistito deve contenere almeno `promptVersion`, `modelProfile` e `schemaVersion`.

---

## 8. AI Quality Control

## 8.1 Obiettivo

Il quality control deve ridurre hallucination, output non sicuri, inconsistenze, costi inutili e regressioni causate da aggiornamenti modello o prompt.

### Strategia

```text
Local deterministic metrics
    │
    ▼
Context validation
    │
    ▼
Safety pre-check
    │
    ▼
Constrained LLM generation
    │
    ▼
Schema validation
    │
    ▼
Grounding validation
    │
    ▼
Safety post-check
    │
    ▼
UI presentation or fallback
```

---

## 8.2 Input validation

Prima della chiamata AI:

- Verificare consenso AI.
- Verificare consenso HealthKit, se dati HealthKit inclusi.
- Verificare che il context snapshot non sia vuoto.
- Verificare range date.
- Verificare metriche non negative e coerenti.
- Verificare che workout annullati non siano inclusi.
- Verificare che i dati siano aggiornati.
- Verificare token budget.
- Verificare rate limit.
- Bloccare richieste esplicitamente mediche o reindirizzarle a safety prompt.

---

## 8.3 Output validation

Dopo la risposta provider:

- Validare JSON/schema.
- Verificare campi obbligatori.
- Verificare categorie consentite.
- Verificare lunghezza dei testi.
- Verificare lingua richiesta.
- Verificare riferimenti a periodi esistenti.
- Verificare riferimenti a metriche incluse nel context snapshot.
- Verificare assenza di diagnosi e prescrizioni.
- Verificare assenza di claim assoluti non supportati.
- Verificare assenza di contenuto offensivo, pericoloso o irrilevante.
- Rifiutare output non conforme.

---

## 8.4 Grounding validation

La validazione grounding deve confrontare i claim dell’output con il contesto inviato.

| Tipo claim | Regola |
|---|---|
| Valore numerico | Deve esistere nel context snapshot |
| Data o periodo | Deve essere coerente con range fornito |
| Esercizio citato | Deve esistere nel contesto |
| Personal record | Deve essere presente nei dati locali |
| Trend | Deve corrispondere a metrica locale |
| HealthKit | Deve esistere ed essere autorizzato |
| Suggerimento | Deve essere formulato come opzione, non come fatto |

Se un claim non può essere verificato, il sistema deve:

1. rifiutare la risposta;
2. tentare un retry controllato con istruzione correttiva;
3. usare fallback locale se il retry fallisce.

---

## 8.5 Fallback strategy

| Situazione | Fallback |
|---|---|
| AI offline | Mostrare analytics locali e insight rule-based |
| Consenso negato | Mostrare valore app senza AI e CTA facoltativa |
| Dati insufficienti | Mostrare insight “servono più dati” |
| Output invalido | Non mostrare output; usare risposta template |
| Safety blocked | Mostrare messaggio prudente e risorse appropriate |
| Rate limit | Mostrare ultimo insight cache valido o retry successivo |
| Gateway error | Mostrare errore non tecnico e mantenere chat locale |
| HealthKit non disponibile | Omettere dati HealthKit senza degradare core insight |

---

## 8.6 Evaluation framework

### Dataset di valutazione

Creare un dataset sintetico e anonimizzato con casi rappresentativi:

- Utente senza workout.
- Utente con un solo workout.
- Utente con dati consistenti su 30, 90 e 180 giorni.
- Utente con volume crescente.
- Utente con volume decrescente.
- Esercizio in progressione.
- Esercizio con trend incerto.
- Workout annullati.
- Dati CSV importati.
- Dati mancanti o incoerenti.
- HealthKit autorizzato e non autorizzato.
- Query su dolore, infortunio e richiesta medica.
- Prompt injection tentata.
- Domanda fuori ambito.

### Metriche qualità

| Metrica | Descrizione |
|---|---|
| Schema validity rate | Percentuale output conformi a schema |
| Grounded claim rate | Percentuale claim verificabili |
| Hallucination rate | Claim non supportati dal contesto |
| Safety compliance rate | Risposte conformi a policy sicurezza |
| Helpful feedback rate | Percentuale feedback positivo utenti |
| Insight dismissal rate | Percentuale insight ignorati |
| AI error rate | Errori gateway, timeout, parse e safety block |
| Latency p50/p95 | Tempo risposta utente |
| Cost per active user | Costo AI per utente attivo |
| Cache hit rate | Percentuale richieste servite da cache |

---

## 8.7 Human review

Per prompt e feature ad alto impatto:

- Revisionare esempi di output prima del rollout.
- Eseguire review prodotto, AI, privacy e sicurezza.
- Mantenere una suite di regression test.
- Monitorare i feedback “non utile”.
- Avere rollback immediato tramite feature flag.
- Non utilizzare conversazioni personali in review manuali senza processi espliciti e consenso appropriato.

---

## 9. AI Privacy & Security

## 9.1 Privacy principles

- Privacy by design.
- Data minimization.
- Purpose limitation.
- Explicit consent.
- Revocable consent.
- Local-first storage.
- Secure transport.
- No API key client-side.
- Transparent data usage.
- User access, export and deletion.
- Separate consent for AI and HealthKit.
- No model training on user data without explicit, separate consent.

---

## 9.2 Consent model

| Consenso | Richiesto per | Effetto revoca |
|---|---|---|
| Core app consent | Uso app e persistenza locale | Le feature core possono essere limitate secondo policy |
| AI Coach consent | Invio dati autorizzati a AI Gateway | Blocca nuove richieste AI |
| HealthKit consent | Lettura HealthKit | Interrompe acquisizione HealthKit |
| HealthKit + AI consent | Uso aggregati HealthKit nell’AI | Omette HealthKit dal context builder |
| Notifications consent | Reminder e insight push | Disabilita invio notifiche |
| Analytics telemetry consent | Telemetria non essenziale | Disabilita eventi non necessari |

La revoca dell’AI non deve eliminare workout, storico o analytics locali.

---

## 9.3 Data classification

| Categoria | Esempi | Trattamento |
|---|---|---|
| Identificativi diretti | Email, Apple identifier | Non inviare al modello |
| Dati fitness | Workout, serie, volume, PR | Inviare solo se AI consent |
| Dati salute | Passi, calorie, workout HealthKit | Richiede doppio consenso |
| Dati conversazionali | Domande e messaggi Coach | Conservare solo secondo policy utente |
| Dati tecnici | Error code, latency, prompt version | Pseudonimizzare e minimizzare |
| Segreti | API key, auth token | Mai inviare o salvare in analytics client |

---

## 9.4 API security

- Le API key provider devono esistere esclusivamente nel backend gateway.
- L’app iOS deve usare autenticazione breve e sicura verso il gateway.
- Il gateway deve verificare token, rate limit e request size.
- Tutte le comunicazioni devono usare TLS.
- Le richieste devono avere timeout configurati.
- Il gateway deve validare schema prima di inoltrare dati.
- Il gateway deve applicare rate limiting per utente e IP quando opportuno.
- Gli errori non devono restituire dettagli interni o segreti.
- I log devono redigere contenuti personali.
- Le configurazioni modello devono essere server-side.
- Le feature AI ad alto rischio devono essere disattivabili tramite feature flag.

---

## 9.5 GDPR and data rights

Il sistema deve supportare:

- Accesso ai dati.
- Esportazione dati.
- Rettifica dati.
- Revoca consensi.
- Cancellazione conversazioni.
- Eliminazione account.
- Cancellazione o anonimizzazione dati secondo policy.
- Informativa su categorie di dati usate dall’AI.
- Tracciamento versione informativa e data consenso.

L’export deve distinguere dati workout, metriche, insight e conversazioni AI. Non deve includere token, identificativi di sicurezza o log interni.

---

## 9.6 HealthKit safeguards

- Richiedere solo le autorizzazioni HealthKit necessarie.
- Usare HealthKit solo per funzionalità dichiarate.
- Non usare dati HealthKit per advertising.
- Non usare dati HealthKit per inferenze cliniche.
- Non inviare HealthKit al provider AI senza consenso doppio.
- Preferire dati aggregati a campioni dettagliati.
- Mostrare chiaramente quando un insight usa dati HealthKit.
- Consentire uso dell’app senza HealthKit.

---

## 10. Performance & Cost Optimization

## 10.1 Cost principles

L’AI deve essere usata quando aggiunge valore interpretativo. I calcoli ripetibili, numerici e deterministicamente verificabili devono rimanere locali.

| Decisione | Strategia |
|---|---|
| Metriche numeriche | Calcolo locale |
| Insight semplici | Regole locali o AI solo se necessario |
| Insight settimanali | Cache e batch |
| Chat | Contesto dinamico limitato |
| Conversazioni | Summary locale, non cronologia completa |
| Dati HealthKit | Aggregati e solo se richiesti |
| Nuovo insight | Trigger basato su eventi, non polling |
| Modello | Selezione modello in base a complessità richiesta |

---

## 10.2 Caching

| Cache | Durata indicativa | Invalidazione |
|---|---|---|
| Dashboard insight | 12–24 ore | Nuovo workout, modifica workout, revoca consenso |
| Weekly review | Una settimana | Nuovo dato rilevante o inizio nuova settimana |
| Exercise analysis | 24 ore | Nuova sessione dello stesso esercizio |
| Muscle balance insight | 24–72 ore | Modifica workout o periodo |
| Conversation summary | Per conversazione | Nuovo messaggio o cancellazione chat |
| Health aggregate | Giornaliera | Nuovi dati HealthKit disponibili |

I dati cache AI devono indicare `createdAt`, `expiresAt`, `promptVersion`, `contextHash` e `sourceDataVersion`.

---

## 10.3 Batching

Usare batching per:

- Generazione insight settimanali.
- Aggiornamento insight dopo import CSV.
- Aggiornamento di più metriche dopo modifica workout.
- Sincronizzazione di eventi non critici.
- Elaborazione di dataset ampi in background.

Non usare batching per:

- Risposta chat diretta.
- Completamento workout visibile.
- Azioni utente che richiedono conferma immediata.
- Messaggi safety-critical.

---

## 10.4 Model routing

| Tipo richiesta | Profilo modello |
|---|---|
| Insight locale semplice | Regole locali o modello piccolo |
| Riepilogo workout | Modello rapido e a basso costo |
| Chat Coach contestuale | Modello bilanciato qualità/latenza |
| Analisi complessa multi-metrica | Modello avanzato con context controllato |
| Safety redirect | Template locale o modello affidabile |
| On-device summary futuro | Modello locale Apple/on-device |

La selezione modello deve essere configurabile lato gateway, senza aggiornamento dell’app.

---

## 10.5 Latency targets

| Flusso | Target UX |
|---|---|
| Insight cache Dashboard | Immediato |
| Insight locale | Sotto 500 ms percepiti |
| Risposta chat AI | Stato loading entro 150 ms |
| Risposta chat standard | Target p50 sotto 3 secondi |
| Risposta chat complessa | Target p95 sotto 8 secondi |
| Post-workout insight | Non bloccare riepilogo; aggiornamento asincrono |
| Failure response | Messaggio utile entro timeout configurato |

---

## 11. Swift/iOS Integration

## 11.1 Struttura logica

```text
Features/
└── Coach/
    ├── Views/
    ├── ViewModels/
    ├── Components/
    └── Navigation/

Domain/
├── Entities/
│   ├── AIInsight
│   ├── CoachConversation
│   ├── CoachMessage
│   └── AIContextSnapshot
├── Repositories/
│   ├── AIInsightRepository
│   └── CoachConversationRepository
├── Services/
│   ├── AIService
│   ├── ContextBuilder
│   └── InsightEngine
└── UseCases/
    ├── AskCoachUseCase
    ├── GenerateInsightsUseCase
    ├── DeleteConversationUseCase
    └── RevokeAIConsentUseCase

Data/
├── Repositories/
├── DTOs/
├── SwiftData/
└── Cache/

Services/
├── AI/
│   ├── RemoteAIService
│   ├── MockAIService
│   ├── DisabledAIService
│   ├── AIGatewayClient
│   ├── PromptMetadataService
│   └── ResponseValidator
├── Analytics/
└── HealthKit/
```

---

## 11.2 Dependency injection

Le View e i ViewModel non devono dipendere da OpenAI SDK, chiavi API o networking diretto.

```text
SwiftUI View
    │
    ▼
CoachViewModel
    │
    ▼
AskCoachUseCase
    │
    ├── ContextBuilder
    ├── AIService protocol
    ├── CoachConversationRepository
    └── ConsentRepository
    │
    ▼
RemoteAIService / MockAIService / DisabledAIService
```

### Environment configurations

| Ambiente | AI service |
|---|---|
| SwiftUI Preview | MockAIService |
| Unit test | MockAIService |
| UI test | DeterministicMockAIService |
| Development | Staging AI Gateway |
| TestFlight | Staging o controlled production gateway |
| Production | Production AI Gateway |
| AI disabled feature flag | DisabledAIService |

---

## 11.3 Async behavior

- Usare `async/await` per richieste AI.
- Non eseguire networking o parsing pesante sul main thread.
- Aggiornare stato UI sul main actor.
- Rendere cancellabili richieste chat quando l’utente lascia la schermata.
- Non cancellare una risposta già ricevuta ma non ancora visualizzata senza gestire stato.
- Gestire retry esplicito, non retry automatici aggressivi su chat.
- Usare task separati per insight post-workout non bloccanti.

---

## 11.4 UI state model

| Stato | Comportamento UI |
|---|---|
| Idle | Composer disponibile |
| PreparingContext | Indicatore discreto |
| Requesting | Bubble loading e possibilità annullamento |
| Streaming future | Testo progressivo, se supportato |
| Completed | Messaggio persistito e visualizzato |
| Offline | Messaggio chiaro e accesso analytics locali |
| ConsentRequired | CTA consenso non coercitiva |
| RateLimited | Messaggio attesa e retry differito |
| SafetyRedirect | Messaggio prudente e risorse appropriate |
| Failed | Error state con retry |

---

## 11.5 Offline behaviour

| Feature | Offline |
|---|---|
| Workout logging | Disponibile |
| Storico | Disponibile |
| Analytics locali | Disponibili |
| Insight rule-based | Disponibili |
| Insight AI cache | Disponibili se già salvati |
| Coach chat | Non disponibile, con messaggio esplicativo |
| Nuovi insight AI | Accodati solo se la policy lo consente; altrimenti non generati |
| HealthKit locale | Disponibile secondo framework e autorizzazione |
| Cloud sync | Accodata e ritentata alla riconnessione |

La richiesta AI non deve essere accodata automaticamente senza informare l’utente se contiene una domanda conversazionale personale.

---

## 11.6 SwiftData persistence

Entità AI principali:

| Entità | Campi chiave |
|---|---|
| `AIInsight` | Categoria, titolo, summary, facts, confidenza, periodo, scadenza, feedback |
| `CoachConversation` | Titolo, data creazione, aggiornamento, summary context |
| `CoachMessage` | Ruolo, contenuto, context reference, status, safety flag |
| `AIContextSnapshot` | Context hash, periodo, metriche incluse, policy version, createdAt |
| `ConsentRecord` | Tipo consenso, stato, policy version, timestamps |
| `PromptMetadata` | Prompt version, schema version, provider model profile |

I messaggi e insight devono poter essere eliminati dall’utente senza compromettere i dati workout sorgente.

---

## 12. AI Evolution Roadmap

## Versione 1 — AI Insights automatici

### Obiettivo

Validare che gli utenti percepiscano valore da insight basati sui propri dati.

### Scope

- Insight rule-based locali.
- Insight AI su Dashboard.
- Riepilogo post-workout.
- Categorie progress, achievement, consistency e insufficient data.
- Context Builder minimizzato.
- AI Gateway sicuro.
- Output schema validato.
- Feedback utile/non utile.
- Consensi AI separati.

### Escluso

- Chat conversazionale completa.
- Generazione programmi.
- Suggerimenti automatici di carico.
- HealthKit avanzato.
- Vision Framework.

---

## Versione 2 — AI Coach conversazionale

### Obiettivo

Permettere all’utente di interrogare il proprio storico in linguaggio naturale.

### Scope

- Chat AI Coach.
- Suggested questions.
- Analisi esercizi.
- Analisi volume e frequenza.
- Context dinamico per periodo.
- Summary conversazioni.
- Cancellazione chat.
- Rate limiting e fallback robusti.
- Dati HealthKit opzionali con doppio consenso.

---

## Versione 3 — Personal Trainer AI

### Obiettivo

Passare da insight descrittivi a suggerimenti più contestuali e configurabili.

### Scope

- Suggerimenti progressione prudenti.
- Review scheda.
- Adattamento volume assistito.
- Raccomandazioni esercizi basate su attrezzatura.
- Deload detection prudente.
- Check-in pre e post workout.
- Obiettivi settimanali adattivi.
- Sistema di approvazione manuale utente per ogni modifica proposta.

### Vincoli

- Nessuna modifica automatica irrevocabile.
- Regole sicurezza locali obbligatorie.
- Evidenza dati sempre mostrata.
- Approccio conservativo per principianti.

---

## Versione 4 — Vision Analysis

### Obiettivo

Aggiungere analisi opzionale di movimento e tecnica a scopo educativo.

### Scope

- Capture pipeline con consenso esplicito.
- Estrazione landmark on-device tramite Vision Framework.
- Analisi movimento local-first.
- Feedback educativo non clinico.
- Gestione e cancellazione media controllata.
- Eventuale AI interpretation separata e autorizzata.

### Vincoli

- Nessuna diagnosi.
- Nessuna garanzia di sicurezza tecnica.
- Nessuna elaborazione media senza consenso.
- Possibilità di eliminare video e dati derivati.
- Separazione completa tra media, dati fitness e chat.

---

## Versione 5 — AI completamente personalizzata

### Obiettivo

Evolvere verso un coach adattivo e multimodale mantenendo privacy e controllo utente.

### Possibili evoluzioni

- Modelli locali o Apple Intelligence.
- Routing intelligente tra modello cloud e on-device.
- Profilo coaching personalizzabile.
- Memoria a lungo termine controllata dall’utente.
- Programmi dinamici modificabili.
- Apple Watch coaching durante workout.
- Integrazione avanzata recovery.
- Coach mode per trainer autorizzati.
- Insights predittivi su aderenza e stallo.
- Automazione limitata e sempre approvabile.

---

## 13. Definition of Done AI

L’architettura AI può essere considerata pronta per rilascio MVP quando:

- [ ] Le metriche fondamentali sono calcolate localmente e testate.
- [ ] L’app non contiene API key del provider AI.
- [ ] Il gateway AI gestisce autenticazione, rate limit, errori e provider routing.
- [ ] AI Coach richiede consenso esplicito e revocabile.
- [ ] HealthKit non viene inviato all’AI senza doppio consenso.
- [ ] Il Context Builder applica data minimization e token budgeting.
- [ ] Prompt, schema e modello sono versionati.
- [ ] Ogni risposta AI è validata contro uno schema strutturato.
- [ ] Le risposte AI vengono controllate per safety e grounding.
- [ ] Insight e chat distinguono dati osservati, interpretazione e suggerimento.
- [ ] Il sistema gestisce dati insufficienti senza inventare conclusioni.
- [ ] Esistono fallback per offline, timeout, rate limit e output non valido.
- [ ] L’utente può cancellare conversazioni e gestire dati AI.
- [ ] Sono disponibili mock deterministici per unit test, UI test e SwiftUI preview.
- [ ] Le feature AI possono essere disabilitate tramite feature flag.
- [ ] La telemetria tecnica è minimizzata e priva di dati fitness identificabili non necessari.
- [ ] Esistono suite di test per hallucination, prompt injection, safety e regressioni prompt.