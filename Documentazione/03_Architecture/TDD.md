# Technical Design Document
# PeakLift

> **Versione:** 1.0  
> **Stato:** Draft  
> **Piattaforma:** iOS  
> **Linguaggio:** Swift 6  
> **UI:** SwiftUI  
> **Persistenza locale:** SwiftData  
> **Sincronizzazione:** CloudKit  
> **Integrazioni:** HealthKit, Vision Framework, WidgetKit, ActivityKit  
> **AI:** OpenAI API, con predisposizione futura per modelli locali  
> **Architettura:** MVVM, Clean Architecture leggera, Repository Pattern, Dependency Injection  
> **Documenti di riferimento:** Product Vision, PRD, SRS  

---

## 1. System Architecture

### 1.1 Obiettivo architetturale

L'architettura di PeakLift deve supportare un'app iOS offline-first, sicura e modulare, capace di registrare workout rapidamente, analizzare dati locali, sincronizzarli tramite CloudKit e utilizzare servizi AI opzionali.

La priorità tecnica è mantenere il flusso di workout logging disponibile anche senza connessione. Analytics locali, storico e gestione delle serie non devono dipendere da servizi cloud o AI.

---

### 1.2 Principi architetturali

- **Offline-first:** SwiftData è la fonte dati primaria dell'app.
- **Local source of truth:** le schermate leggono dati e stati dal layer locale.
- **Cloud sync opzionale e asincrona:** CloudKit replica i dati quando disponibile.
- **AI opzionale:** AI Coach non deve bloccare funzioni core.
- **Privacy by design:** HealthKit e AI richiedono consensi distinti.
- **Modularità:** ciascuna feature deve essere isolabile e testabile.
- **Dependency inversion:** ViewModel e use case dipendono da protocolli, non da implementazioni concrete.
- **Single responsibility:** ogni componente deve avere responsabilità limitate.
- **Explainable AI:** insight e risposte devono conservare contesto, dati analizzati e periodo di riferimento.

---

### 1.3 Livelli dell'architettura

```text
┌──────────────────────────────────────────────────────────────┐
│                           App Layer                          │
│ App Entry Point · App State · Dependency Container · Routing │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                         Presentation                         │
│ SwiftUI Views · ViewModels · UI State · Design System        │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                           Domain                             │
│ Entities · Use Cases · Repository Protocols · Business Rules │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                            Data                              │
│ Repository Implementations · SwiftData · CloudKit Mapping    │
│ CSV Parsing · Querying · Cache · Sync Coordination           │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                          Services                            │
│ HealthKit · AI API · Sign in with Apple · Notifications      │
│ Analytics Engine · Vision · WidgetKit · ActivityKit          │
└──────────────────────────────────────────────────────────────┘
```

---

### 1.4 Componenti principali

| Componente | Responsabilità |
|---|---|
| App Layer | Avvio applicazione, configurazione dipendenze, gestione sessione, routing principale |
| Presentation | View SwiftUI, ViewModel, stato UI, validazione input e accessibilità |
| Domain | Entità business, protocolli repository, use case, metriche e regole core |
| Data | Persistenza SwiftData, mapping modelli, repository concreti, CSV import, CloudKit sync |
| Services | Integrazione Apple, AI, notifiche, HealthKit, Vision e monitoraggio tecnico |
| Design System | Colori, tipografia, componenti riutilizzabili, icone, spacing e accessibilità |
| Sync Engine | Coordinamento tra modifiche locali, CloudKit e gestione conflitti |
| Analytics Engine | Calcolo metriche, aggregazioni, confronto periodi e trend |
| AI Context Builder | Costruzione del contesto minimizzato e autorizzato per AI Coach |

---

### 1.5 Flusso di comunicazione

```text
SwiftUI View
    │
    ▼
ViewModel
    │
    ▼
Use Case
    │
    ▼
Repository Protocol
    │
    ├── SwiftData Repository
    │       │
    │       ▼
    │   Local Persistence
    │
    ├── CloudKit Sync Coordinator
    │       │
    │       ▼
    │   CloudKit Private Database
    │
    ├── HealthKit Service
    │       │
    │       ▼
    │   Apple Health Data
    │
    └── AI Coach Service
            │
            ▼
        OpenAI API
```

Le View non devono accedere direttamente a SwiftData, CloudKit, HealthKit o OpenAI API. Ogni accesso ai dati deve passare attraverso un ViewModel e un use case oppure, per letture semplici e locali, attraverso repository iniettati tramite protocolli.

---

### 1.6 Flusso workout

```text
Utente avvia workout
    │
    ▼
WorkoutViewModel
    │
    ▼
CreateWorkoutUseCase
    │
    ▼
WorkoutRepository
    │
    ▼
SwiftData salva WorkoutDraft
    │
    ▼
Utente aggiunge esercizio e serie
    │
    ▼
WorkoutViewModel aggiorna stato locale
    │
    ▼
WorkoutRepository persiste progressivamente
    │
    ▼
Utente completa workout
    │
    ▼
CompleteWorkoutUseCase
    │
    ├── Calcola volume e durata
    ├── Aggiorna PersonalRecord
    ├── Invalida cache analytics
    ├── Genera insight locali candidati
    └── Accoda modifica per CloudKit sync
```

---

### 1.7 Flusso AI Coach

```text
Utente invia domanda
    │
    ▼
CoachViewModel
    │
    ▼
AskCoachUseCase
    │
    ├── Verifica consenso AI
    ├── Verifica connettività
    ├── Costruisce contesto minimo
    ├── Applica guardrail locali
    ├── Invia richiesta ad AIService
    ├── Valida struttura risposta
    ├── Salva messaggi e metadati
    └── Restituisce risposta alla UI
```

---

### 1.8 Decisioni chiave

| Decisione | Scelta | Motivazione |
|---|---|---|
| Pattern UI | MVVM | Naturale in SwiftUI, testabile e adatto allo stato reattivo |
| Separazione business logic | Clean Architecture leggera | Riduce accoppiamento senza introdurre complessità eccessiva |
| Persistenza locale | SwiftData | Integrazione nativa con SwiftUI e modello offline-first |
| Sync cloud | CloudKit Private Database | Integrazione iCloud, riduzione infrastruttura backend iniziale |
| Autenticazione | Sign in with Apple | Coerenza iOS e riduzione gestione credenziali |
| AI provider | OpenAI API tramite backend proxy | Protezione API key e controllo privacy/guardrail |
| Accesso salute | HealthKit opzionale | Privacy, consenso granulare e indipendenza dal dato salute |
| Analytics | Calcolo locale | Velocità, disponibilità offline e minimizzazione dati esterni |
| Future local AI | Protocol abstraction | Possibilità di sostituire il provider senza modificare UI e domain |

---

## 2. Project Structure

### 2.1 Struttura repository

```text
PeakLift/
├── App/
│   ├── PeakLiftApp.swift
│   ├── AppDelegate.swift
│   ├── AppCoordinator.swift
│   ├── AppEnvironment.swift
│   ├── DependencyContainer.swift
│   ├── RootView.swift
│   └── AppConfiguration.swift
│
├── Core/
│   ├── Extensions/
│   ├── Utilities/
│   ├── Constants/
│   ├── Errors/
│   ├── Logging/
│   ├── Networking/
│   ├── Persistence/
│   ├── Permissions/
│   ├── Localization/
│   └── DesignSystem/
│       ├── Colors/
│       ├── Typography/
│       ├── Spacing/
│       ├── Components/
│       └── Assets/
│
├── Domain/
│   ├── Entities/
│   ├── Enums/
│   ├── ValueObjects/
│   ├── Repositories/
│   ├── UseCases/
│   │   ├── Authentication/
│   │   ├── Onboarding/
│   │   ├── Workout/
│   │   ├── Analytics/
│   │   ├── Coach/
│   │   ├── Health/
│   │   ├── Import/
│   │   └── Privacy/
│   ├── Services/
│   └── Rules/
│
├── Data/
│   ├── SwiftData/
│   │   ├── Models/
│   │   ├── ModelContainer/
│   │   ├── Migrations/
│   │   ├── Queries/
│   │   └── SeedData/
│   ├── Repositories/
│   ├── CloudKit/
│   │   ├── Records/
│   │   ├── Mappers/
│   │   ├── Sync/
│   │   └── ConflictResolution/
│   ├── CSV/
│   ├── DTOs/
│   └── Cache/
│
├── Features/
│   ├── Authentication/
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Components/
│   ├── Onboarding/
│   ├── Dashboard/
│   ├── Workout/
│   ├── ExerciseLibrary/
│   ├── History/
│   ├── Analytics/
│   ├── Coach/
│   ├── Health/
│   ├── Import/
│   ├── Profile/
│   └── Privacy/
│
├── Services/
│   ├── Authentication/
│   ├── HealthKit/
│   ├── CloudKit/
│   ├── AI/
│   ├── Analytics/
│   ├── Notifications/
│   ├── Vision/
│   ├── Widgets/
│   ├── LiveActivities/
│   ├── Export/
│   └── Telemetry/
│
├── Widgets/
│   ├── PeakLiftWidgetBundle/
│   ├── DashboardWidget/
│   ├── WorkoutWidget/
│   └── SharedModels/
│
├── LiveActivities/
│   ├── RestTimerActivity/
│   └── ActivityAttributes/
│
├── Resources/
│   ├── Assets.xcassets
│   ├── Localizable.xcstrings
│   ├── ExerciseCatalog.json
│   ├── PrivacyInfo.xcprivacy
│   └── Configuration/
│
├── Tests/
│   ├── UnitTests/
│   ├── IntegrationTests/
│   ├── UITests/
│   ├── Fixtures/
│   ├── Mocks/
│   └── Snapshots/
│
└── Documentation/
    ├── Architecture/
    ├── API/
    ├── DataModel/
    ├── Privacy/
    └── Runbooks/
```

---

### 2.2 Responsabilità delle cartelle

| Cartella | Responsabilità |
|---|---|
| `App` | Configurazione iniziale, container dipendenze, navigazione root e lifecycle |
| `Core` | Componenti condivisi e indipendenti dalle feature |
| `Domain` | Regole di business, entità, use case e contratti |
| `Data` | Implementazioni di storage, repository, mapping e importazione |
| `Features` | UI SwiftUI organizzata per area funzionale |
| `Services` | Integrazioni esterne e framework Apple |
| `Widgets` | Estensioni WidgetKit e modelli condivisi |
| `LiveActivities` | ActivityKit per timer di recupero in background |
| `Resources` | Asset, stringhe localizzabili, catalogo esercizi e configurazioni |
| `Tests` | Test unitari, UI, integrazione, fixture e mock |
| `Documentation` | Specifiche tecniche, guide operative e contratti API |

---

### 2.3 Regole di dipendenza

```text
Features → Domain
Features → Core

Data → Domain
Data → Core

Services → Domain
Services → Core

App → Features
App → Data
App → Services
App → Core

Domain → nessuna dipendenza da Features, Data o Services
Core → nessuna dipendenza da Features, Domain, Data o Services
```

Il layer `Domain` non deve importare SwiftUI, SwiftData, CloudKit, HealthKit o SDK OpenAI. Le implementazioni concrete devono essere collocate in `Data` o `Services`.

---

## 3. Data Architecture

### 3.1 Principi dati

- Ogni entità persistente deve avere un UUID stabile generato lato client.
- Le date devono essere archiviate in UTC.
- I carichi devono essere salvati internamente in chilogrammi.
- La conversione kg/lb avviene solo nel layer di presentazione.
- Le metriche derivate devono essere ricalcolabili dai dati sorgente.
- I workout completati devono essere immutabili a livello logico, ma modificabili dall'utente tramite versione o aggiornamento controllato.
- Le modifiche devono contenere metadati di creazione e aggiornamento.
- I record eliminati devono poter essere gestiti tramite soft delete per supportare sincronizzazione e recupero conflitti.
- I dati inviati all'AI devono essere minimizzati, aggregati e controllati tramite consenso.

---

### 3.2 Entity Relationship Diagram

```text
UserProfile
    │ 1
    │
    ├─────────────── * Workout
    │                   │ 1
    │                   ├─────────────── * WorkoutExercise
    │                   │                   │ 1
    │                   │                   ├─────────────── * WorkoutSet
    │                   │                   │
    │                   │                   └─────────────── 1 Exercise
    │                   │
    │                   └─────────────── * WorkoutNote
    │
    ├─────────────── * Exercise
    │                   │
    │                   └─────────────── * ExerciseMuscleGroup
    │
    ├─────────────── * PersonalRecord
    ├─────────────── * ProgressMetric
    ├─────────────── * AIInsight
    ├─────────────── * CoachConversation
    │                   │
    │                   └─────────────── * CoachMessage
    ├─────────────── * ConsentRecord
    └─────────────── * ImportBatch
                            │
                            └─────────────── * Workout
```

---

### 3.3 UserProfile

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo locale stabile |
| `appleUserIdentifier` | String | No | Identificativo Sign in with Apple |
| `displayName` | String | No | Nome o nickname utente |
| `emailRelay` | String | No | Email privata Apple, se condivisa |
| `weightUnit` | Enum | Sì | `kg` o `lb` |
| `experienceLevel` | Enum | Sì | Beginner, intermediate, advanced |
| `primaryGoal` | Enum | Sì | Strength, hypertrophy, recomposition, general fitness |
| `desiredWeeklyFrequency` | Int | No | Allenamenti desiderati a settimana |
| `preferredLanguage` | String | Sì | Lingua applicazione |
| `onboardingCompleted` | Bool | Sì | Stato onboarding |
| `aiCoachEnabled` | Bool | Sì | Consenso AI Coach |
| `healthKitEnabled` | Bool | Sì | Consenso HealthKit |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |
| `deletedAt` | Date | No | Soft delete |
| `syncStatus` | Enum | Sì | Stato sincronizzazione |
| `version` | Int | Sì | Versione record per conflitti |

---

### 3.4 Workout

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo workout |
| `userId` | UUID | Sì | Proprietario workout |
| `title` | String | No | Titolo libero |
| `status` | Enum | Sì | Draft, inProgress, completed, cancelled |
| `startedAt` | Date | Sì | Inizio workout |
| `completedAt` | Date | No | Fine workout |
| `durationSeconds` | Int | No | Durata calcolata |
| `notes` | String | No | Note sessione |
| `perceivedEffort` | Decimal | No | Valutazione percepita opzionale |
| `totalVolumeKg` | Decimal | Sì | Volume derivato memorizzato per query rapide |
| `workingSetCount` | Int | Sì | Numero serie allenanti |
| `source` | Enum | Sì | Manual, csvImport, healthKitImportFuture |
| `importBatchId` | UUID | No | Origine importazione |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |
| `deletedAt` | Date | No | Soft delete |
| `version` | Int | Sì | Versione conflitto |

---

### 3.5 Exercise

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo esercizio |
| `ownerUserId` | UUID | No | Null per esercizi catalogo globale |
| `name` | String | Sì | Nome esercizio |
| `normalizedName` | String | Sì | Nome normalizzato per ricerca e deduplica |
| `isCustom` | Bool | Sì | Indica esercizio creato dall'utente |
| `equipmentType` | Enum | Sì | Barbell, dumbbell, cable, machine, bodyweight, other |
| `movementPattern` | Enum | No | Push, pull, squat, hinge, carry, isolation, other |
| `instructions` | String | No | Indicazioni catalogo, non cliniche |
| `notes` | String | No | Note utente |
| `isArchived` | Bool | Sì | Nasconde senza perdere storico |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |

Un esercizio non deve essere eliminato fisicamente se utilizzato nello storico. Deve essere archiviato per preservare l'integrità referenziale.

---

### 3.6 MuscleGroup

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo gruppo muscolare |
| `code` | String | Sì | Codice stabile, ad esempio `chest` |
| `displayName` | String | Sì | Nome localizzabile |
| `bodyRegion` | Enum | Sì | UpperBody, lowerBody, core |
| `isSystemDefined` | Bool | Sì | Gruppo gestito dal catalogo |
| `createdAt` | Date | Sì | Data creazione |

Gruppi iniziali previsti:

- Chest
- Back
- Shoulders
- Biceps
- Triceps
- Quadriceps
- Hamstrings
- Glutes
- Calves
- Core
- Forearms
- Traps
- LowerBack

---

### 3.7 ExerciseMuscleGroup

Questa entità definisce la relazione molti-a-molti tra esercizi e gruppi muscolari.

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo relazione |
| `exerciseId` | UUID | Sì | Esercizio associato |
| `muscleGroupId` | UUID | Sì | Muscolo associato |
| `role` | Enum | Sì | Primary o secondary |
| `contributionWeight` | Decimal | Sì | Peso per attribuzione volume |
| `createdAt` | Date | Sì | Data creazione |

Per MVP, un esercizio deve avere almeno un muscolo primario. I muscoli secondari possono usare un peso inferiore per evitare di attribuire il 100% del volume a ogni muscolo coinvolto.

---

### 3.8 WorkoutExercise

`WorkoutExercise` rappresenta un esercizio inserito in una specifica sessione. È necessario per preservare ordine, snapshot e note contestuali.

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo istanza |
| `workoutId` | UUID | Sì | Workout di appartenenza |
| `exerciseId` | UUID | Sì | Riferimento esercizio |
| `exerciseNameSnapshot` | String | Sì | Nome congelato al momento dell'esecuzione |
| `displayOrder` | Int | Sì | Ordine nel workout |
| `notes` | String | No | Note specifiche |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |

---

### 3.9 WorkoutSet

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo serie |
| `workoutExerciseId` | UUID | Sì | Istanza esercizio |
| `setOrder` | Int | Sì | Ordine serie |
| `weightKg` | Decimal | Sì | Carico normalizzato in kg |
| `repetitions` | Int | Sì | Ripetizioni |
| `rpe` | Decimal | No | Scala 1–10 |
| `rir` | Decimal | No | Ripetizioni in riserva |
| `setType` | Enum | Sì | Warmup, working, drop, failure, custom |
| `status` | Enum | Sì | Planned, completed, skipped |
| `completedAt` | Date | No | Timestamp completamento |
| `restDurationSeconds` | Int | No | Recupero associato |
| `notes` | String | No | Note serie |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |
| `deletedAt` | Date | No | Soft delete |

Vincoli:

- `weightKg >= 0`
- `repetitions >= 0`
- `rpe` compreso tra 1 e 10 quando presente
- `rir >= 0` quando presente
- Le serie `skipped` non contribuiscono alle metriche
- Le serie `warmup` possono essere escluse da volume allenante

---

### 3.10 PersonalRecord

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo record |
| `userId` | UUID | Sì | Proprietario |
| `exerciseId` | UUID | Sì | Esercizio |
| `recordType` | Enum | Sì | MaxWeight, maxReps, maxVolume, estimated1RM |
| `value` | Decimal | Sì | Valore del record |
| `unit` | String | Sì | kg, reps o volumeKg |
| `achievedAt` | Date | Sì | Data record |
| `workoutId` | UUID | Sì | Workout origine |
| `workoutSetId` | UUID | No | Serie origine |
| `createdAt` | Date | Sì | Data creazione |
| `updatedAt` | Date | Sì | Ultima modifica |

---

### 3.11 ProgressMetric

`ProgressMetric` è una cache di dati aggregati ricalcolabili, ottimizzata per dashboard, analytics e AI context.

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo |
| `userId` | UUID | Sì | Proprietario |
| `metricType` | Enum | Sì | Volume, frequency, e1RM, workingSets, streak, balance |
| `dimensionType` | Enum | Sì | Global, exercise, muscleGroup |
| `dimensionId` | UUID | No | Esercizio o muscolo |
| `periodStart` | Date | Sì | Inizio periodo |
| `periodEnd` | Date | Sì | Fine periodo |
| `value` | Decimal | Sì | Valore principale |
| `comparisonValue` | Decimal | No | Valore periodo precedente |
| `unit` | String | Sì | Unità metrica |
| `sampleSize` | Int | Sì | Numero eventi considerati |
| `confidence` | Enum | Sì | Low, medium, high |
| `calculationVersion` | Int | Sì | Versione algoritmo |
| `computedAt` | Date | Sì | Timestamp calcolo |
| `expiresAt` | Date | No | Scadenza cache |

---

### 3.12 AIInsight

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo insight |
| `userId` | UUID | Sì | Proprietario |
| `category` | Enum | Sì | Progression, volume, frequency, balance, consistency, recovery, insufficientData |
| `priority` | Int | Sì | Ordine visualizzazione |
| `title` | String | Sì | Titolo insight |
| `summary` | String | Sì | Testo breve |
| `details` | String | No | Approfondimento |
| `observedDataJSON` | Data | Sì | Snapshot dati utilizzati |
| `periodStart` | Date | Sì | Inizio analisi |
| `periodEnd` | Date | Sì | Fine analisi |
| `confidence` | Enum | Sì | Low, medium, high |
| `suggestedAction` | String | No | Azione proposta |
| `disclaimer` | String | No | Avviso sicurezza |
| `sourceType` | Enum | Sì | RuleBased, AIGenerated, hybrid |
| `status` | Enum | Sì | New, read, saved, dismissed |
| `feedback` | Enum | No | Helpful, notHelpful |
| `createdAt` | Date | Sì | Data generazione |
| `expiresAt` | Date | No | Scadenza rilevanza |
| `deletedAt` | Date | No | Soft delete |

---

### 3.13 CoachConversation e CoachMessage

| Entità | Proprietà principali |
|---|---|
| `CoachConversation` | `id`, `userId`, `title`, `createdAt`, `updatedAt`, `deletedAt` |
| `CoachMessage` | `id`, `conversationId`, `role`, `content`, `contextReferenceJSON`, `createdAt`, `deliveryStatus`, `safetyFlag` |

Ruoli messaggio:

- `user`
- `assistant`
- `system`
- `tool`

Gli eventuali messaggi di sistema e tool devono restare tecnici e non devono essere mostrati integralmente all'utente.

---

### 3.14 ConsentRecord

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo |
| `userId` | UUID | Sì | Proprietario |
| `consentType` | Enum | Sì | AI, HealthKit, analytics, notifications |
| `status` | Enum | Sì | Granted, denied, revoked |
| `policyVersion` | String | Sì | Versione informativa |
| `grantedAt` | Date | No | Data consenso |
| `revokedAt` | Date | No | Data revoca |
| `updatedAt` | Date | Sì | Ultima modifica |

---

### 3.15 ImportBatch

| Proprietà | Tipo logico | Obbligatorio | Descrizione |
|---|---|---:|---|
| `id` | UUID | Sì | Identificativo batch |
| `userId` | UUID | Sì | Proprietario |
| `sourceFileName` | String | Sì | Nome file origine |
| `fileHash` | String | Sì | Hash per deduplica |
| `importedRows` | Int | Sì | Righe importate |
| `skippedRows` | Int | Sì | Righe scartate |
| `duplicateRows` | Int | Sì | Possibili duplicati |
| `status` | Enum | Sì | Preview, completed, failed, cancelled |
| `createdAt` | Date | Sì | Avvio import |
| `completedAt` | Date | No | Fine import |
| `errorSummary` | String | No | Riepilogo errori |

---

### 3.16 Enumerazioni principali

```text
WorkoutStatus:
- draft
- inProgress
- completed
- cancelled

SetStatus:
- planned
- completed
- skipped

SetType:
- warmup
- working
- drop
- failure
- custom

WeightUnit:
- kg
- lb

ExperienceLevel:
- beginner
- intermediate
- advanced

PrimaryGoal:
- strength
- hypertrophy
- recomposition
- generalFitness

SyncStatus:
- localOnly
- pendingUpload
- synced
- conflict
- failed

InsightCategory:
- progression
- volume
- frequency
- balance
- consistency
- recovery
- insufficientData

InsightSourceType:
- ruleBased
- aiGenerated
- hybrid
```

---

## 4. SwiftData Design

### 4.1 Strategie di persistenza

SwiftData è il database locale principale e deve fungere da source of truth dell'app.

Il modello dati deve supportare:

- Persistenza offline;
- Query veloci per dashboard e storico;
- Relazioni Workout → WorkoutExercise → WorkoutSet;
- Modifiche incrementali;
- Cancellazioni controllate;
- Cache analytics;
- Dati importati;
- Migrazioni di schema;
- Sincronizzazione CloudKit.

---

### 4.2 Schema SwiftData

Modelli SwiftData principali:

```text
SDUserProfile
SDWorkout
SDWorkoutExercise
SDWorkoutSet
SDExercise
SDMuscleGroup
SDExerciseMuscleGroup
SDPersonalRecord
SDProgressMetric
SDAIInsight
SDCoachConversation
SDCoachMessage
SDConsentRecord
SDImportBatch
```

Le classi persistenti SwiftData devono restare separate dalle entità Domain quando possibile. I repository devono eseguire mapping tra modelli `SD*` e entità business.

---

### 4.3 Relazioni

| Origine | Relazione | Destinazione | Regola |
|---|---|---|---|
| UserProfile | Uno-a-molti | Workout | Cascade logica, soft delete |
| Workout | Uno-a-molti | WorkoutExercise | Cascade |
| WorkoutExercise | Uno-a-molti | WorkoutSet | Cascade |
| Exercise | Molti-a-molti | MuscleGroup | Relazione tramite ExerciseMuscleGroup |
| UserProfile | Uno-a-molti | PersonalRecord | Cascade logica |
| UserProfile | Uno-a-molti | AIInsight | Cascade logica |
| CoachConversation | Uno-a-molti | CoachMessage | Cascade |
| ImportBatch | Uno-a-molti | Workout | Riferimento di origine |

Le relazioni fisiche devono evitare cascade delete distruttivi su esercizi già usati nello storico. Un esercizio usato deve essere archiviato, non eliminato.

---

### 4.4 Query principali

| Query | Scopo |
|---|---|
| Workout completati per periodo | Dashboard, analytics e AI context |
| Ultima performance per esercizio | Precompilazione carico e ripetizioni |
| Workout in corso | Recupero bozza al lancio app |
| Serie completate per esercizio | Progressione e personal record |
| Volume per muscolo e periodo | Equilibrio muscolare |
| Insight attivi e non letti | Dashboard e Coach |
| Record con `pendingUpload` | CloudKit sync |
| Workout importati per batch | Annullamento o audit import |
| Dati HealthKit aggregati per giorno | Dashboard e AI context opzionale |

---

### 4.5 Strategie di indicizzazione

I modelli devono supportare query efficienti sui seguenti campi:

| Entità | Campi da ottimizzare |
|---|---|
| Workout | `userId`, `status`, `startedAt`, `completedAt`, `updatedAt`, `deletedAt` |
| WorkoutExercise | `workoutId`, `exerciseId`, `displayOrder` |
| WorkoutSet | `workoutExerciseId`, `status`, `completedAt`, `setType` |
| Exercise | `ownerUserId`, `normalizedName`, `isArchived` |
| ProgressMetric | `userId`, `metricType`, `dimensionType`, `periodStart`, `periodEnd` |
| AIInsight | `userId`, `priority`, `status`, `expiresAt` |
| ImportBatch | `userId`, `fileHash`, `status` |

---

### 4.6 Migrazioni

Le migrazioni SwiftData devono essere versionate.

| Versione schema | Esempio modifica | Strategia |
|---|---|---|
| V1 | Modello iniziale MVP | Nessuna migrazione |
| V2 | Aggiunta RIR alle serie | Lightweight migration con default `nil` |
| V3 | Aggiunta attributi muscolo secondario | Backfill asincrono dal catalogo esercizi |
| V4 | Nuova formula 1RM | Aggiornamento `calculationVersion` e ricalcolo cache |
| V5 | Aggiunta modelli Vision | Nuove entità isolate, nessuna modifica distruttiva |

Principi:

- Evitare rinomini distruttivi;
- Usare proprietà opzionali per nuove informazioni;
- Eseguire backfill pesanti in background;
- Non bloccare l'apertura dell'app per migrazioni analytics;
- Conservare `calculationVersion` nelle metriche aggregate;
- Testare ogni migrazione su database con dati realistici.

---

### 4.7 Gestione cancellazioni

Per entità sincronizzate, il sistema deve preferire il soft delete.

```text
Record attivo:
deletedAt = nil

Record eliminato:
deletedAt = timestamp
syncStatus = pendingUpload
```

Dopo la conferma di sincronizzazione e il periodo di retention configurato, il record può essere rimosso localmente in modo sicuro se non necessario per audit o conflitti.

---

## 5. CloudKit Design

### 5.1 Database CloudKit

PeakLift deve usare principalmente il **Private Database** CloudKit associato all'account iCloud dell'utente.

| Database | Uso | MVP |
|---|---|---:|
| Private Database | Workout, profilo, esercizi custom, insight e preferenze personali | Sì |
| Public Database | Catalogo esercizi gestito dal prodotto, se necessario | Opzionale |
| Shared Database | Condivisione con coach, gruppi o social | No, futuro |

---

### 5.2 Record Types

| Record Type | Origine | Descrizione |
|---|---|---|
| `UserProfile` | `SDUserProfile` | Profilo e preferenze |
| `Workout` | `SDWorkout` | Sessione di allenamento |
| `WorkoutExercise` | `SDWorkoutExercise` | Esercizio in workout |
| `WorkoutSet` | `SDWorkoutSet` | Serie allenamento |
| `CustomExercise` | `SDExercise` | Esercizi creati dall'utente |
| `PersonalRecord` | `SDPersonalRecord` | Record personali |
| `AIInsight` | `SDAIInsight` | Insight persistiti |
| `CoachConversation` | `SDCoachConversation` | Conversazioni AI |
| `CoachMessage` | `SDCoachMessage` | Messaggi AI e utente |
| `ConsentRecord` | `SDConsentRecord` | Stato consensi |
| `ImportBatch` | `SDImportBatch` | Audit import CSV |
| `Tombstone` | Entità eliminate | Supporto eliminazioni e conflitti |

Gli esercizi di catalogo predefiniti possono essere inclusi localmente con file JSON versionato; non devono essere sincronizzati per ogni utente.

---

### 5.3 Identificativi

Ogni record CloudKit deve usare un identificativo derivato dall'UUID locale:

```text
recordName = "<entityType>_<uuid>"
```

Esempio:

```text
Workout_7F2D5A4A-8F62-4D10-9F71-AF2C5A71B321
```

Questo permette idempotenza, retry e mapping diretto tra storage locale e cloud.

---

### 5.4 Strategia sincronizzazione

```text
1. L'utente modifica dati localmente
2. Il repository salva la modifica in SwiftData
3. Il record assume stato pendingUpload
4. SyncCoordinator rileva record pendenti
5. Mapper converte il record locale in CKRecord
6. CloudKit salva o aggiorna record
7. Il sistema aggiorna syncStatus = synced
8. Il sistema recupera modifiche remote tramite change token
9. Mapper applica modifiche remote in SwiftData
10. Dashboard e cache analytics vengono invalidate se necessario
```

---

### 5.5 Operazioni sincronizzate

| Operazione | Comportamento |
|---|---|
| Create | Crea record locale, poi record CloudKit |
| Update | Salva localmente e aggiorna CloudKit |
| Delete | Registra soft delete e propaga tombstone |
| Retry | Mantiene operazione in coda fino a esito o errore non recuperabile |
| Pull | Recupera modifiche CloudKit tramite token incrementale |
| Conflict | Applica regole di merge e conserva dati recuperabili |
| Offline | Nessun blocco del logging; modifiche restano in coda |

---

### 5.6 Gestione conflitti

| Entità | Strategia conflitto |
|---|---|
| Profilo | Last-write-wins per preferenze non critiche |
| Workout in bozza | Preferire modifica locale attiva; segnalare conflitto se entrambe recenti |
| Workout completato | Merge per entità figlie quando possibile |
| WorkoutSet | Merge per UUID; evitare overwrite silenzioso |
| Esercizio custom | Last-write-wins con archiviazione versione precedente |
| Insight AI | Preferire record più recente; rigenerabile |
| Conversazioni AI | Append-only per messaggi, merge per conversation metadata |
| Consensi | Stato più restrittivo prevale in caso di conflitto |

Regola critica:

> In caso di conflitto tra consenso `granted` e `revoked`, deve prevalere `revoked` fino a nuova azione esplicita dell'utente.

---

### 5.7 Gestione errori CloudKit

| Errore | Strategia |
|---|---|
| Assenza rete | Mantiene coda locale e riprova |
| Account iCloud non disponibile | Mostra stato non bloccante e conserva dati locali |
| Quota superata | Notifica utente, sospende retry aggressivi |
| Record conflict | Avvia merge e registra evento |
| Server failure | Retry con exponential backoff |
| Permessi negati | Disabilita sync e mostra istruzioni |
| Record non trovato | Interpreta come possibile delete remoto e risolve con tombstone |

---

### 5.8 Change tokens

Il sistema deve mantenere token di sincronizzazione per zona e database:

```text
CloudKitSyncState
- databaseScope
- zoneIdentifier
- serverChangeToken
- lastSuccessfulSyncAt
- lastErrorCode
- retryCount
```

I token devono essere persistiti localmente e aggiornati solo dopo l'applicazione completa delle modifiche remote.

---

## 6. HealthKit Design

### 6.1 Principi

HealthKit deve essere una sorgente dati opzionale e complementare. PeakLift deve funzionare pienamente come tracker di strength training anche senza autorizzazione HealthKit.

L'app non deve effettuare diagnosi, valutazioni cliniche o inferenze mediche dai dati HealthKit.

---

### 6.2 Permessi HealthKit MVP

| Dato | Tipo HealthKit | Accesso | Utilizzo |
|---|---|---|---|
| Passi | Step Count | Read | Attività quotidiana in dashboard |
| Calorie attive | Active Energy Burned | Read | Contesto attività |
| Workout | Workout Type | Read | Riepilogo attività esterne |
| Minuti esercizio | Apple Exercise Time | Read, se disponibile | Riepilogo attività |

Il sistema deve richiedere permessi in modo contestuale e spiegare il beneficio per ciascuna categoria.

---

### 6.3 Dati HealthKit futuri

| Dato | Uso previsto | Stato |
|---|---|---|
| Sleep Analysis | Contesto recupero | Future |
| Resting Heart Rate | Trend recupero | Future |
| HRV | Contesto fisiologico | Future |
| Heart Rate | Dati workout e recupero | Future |
| Mindful Minutes | Benessere e recovery context | Future |
| Body Mass | Trend personale opzionale | Future |

---

### 6.4 HealthKit Service

```text
HealthKitService
    ├── requestAuthorization()
    ├── getAuthorizationStatus()
    ├── fetchDailySteps(range)
    ├── fetchActiveEnergy(range)
    ├── fetchWorkouts(range)
    ├── fetchExerciseTime(range)
    ├── observeChanges()
    └── revokeLocalUsage()
```

Il servizio deve essere astratto tramite protocollo `HealthDataProviding`, così da supportare mock nei test e future alternative di sorgente dati.

---

### 6.5 Flusso autorizzazione

```text
Utente apre integrazione HealthKit
    │
    ▼
HealthViewModel richiede consenso
    │
    ▼
HealthKitService verifica disponibilità
    │
    ▼
iOS mostra pannello autorizzazioni
    │
    ├── Consentito → salva ConsentRecord e avvia sync dati
    ├── Negato → salva stato locale e mantiene app operativa
    └── Revocato successivamente → interrompe letture e aggiorna UI
```

---

### 6.6 Persistenza dati HealthKit

Per MVP, PeakLift deve memorizzare preferibilmente aggregazioni giornaliere e metadati di origine, non duplicare indiscriminatamente tutti i campioni grezzi HealthKit.

| Entità | Dati persistiti |
|---|---|
| `HealthDailySummary` | Data, passi, calorie attive, minuti esercizio, fonte, timestamp sync |
| `HealthWorkoutReference` | Identificativo HealthKit, data, durata, tipo workout, metadati minimi |
| `ConsentRecord` | Stato consenso, data e categorie autorizzate |

---

### 6.7 Uso in AI Coach

I dati HealthKit possono essere inclusi nel contesto AI solo se:

- HealthKit è autorizzato;
- AI Coach è autorizzato;
- Il dato è pertinente alla domanda o all'insight;
- Il contesto viene minimizzato;
- La risposta non formula diagnosi né valutazioni cliniche.

Esempio appropriato:

> Hai registrato meno attività generale negli ultimi sette giorni rispetto al periodo precedente. Questo è solo un contesto osservativo e non indica automaticamente un problema di recupero.

---

## 7. AI Architecture

### 7.1 Principi AI

- L'AI è un componente opzionale.
- Le metriche base devono essere calcolate localmente con logica deterministica.
- L'AI interpreta dati aggregati e produce testo, non sostituisce la source of truth.
- Le risposte devono essere contestuali, spiegabili e prudenti.
- Il provider AI non deve ricevere più dati del necessario.
- Le API key non devono essere incluse nell'app iOS.
- L'architettura deve consentire futura sostituzione con modelli locali.

---

### 7.2 Componenti AI

```text
CoachViewModel
    │
    ▼
AskCoachUseCase / GenerateInsightsUseCase
    │
    ├── ConsentValidator
    ├── SafetyPolicyEngine
    ├── AIContextBuilder
    ├── PromptComposer
    ├── AIService Protocol
    │       ├── OpenAIService
    │       └── LocalModelService (future)
    ├── AIResponseValidator
    ├── InsightRepository
    └── ConversationRepository
```

---

### 7.3 AI Service Protocol

Il domain layer deve dipendere da un contratto astratto:

```text
AIService
- sendChat(request) -> AIChatResponse
- generateInsights(request) -> [AIInsightDraft]
- validateAvailability() -> ServiceStatus
```

Implementazioni previste:

| Implementazione | Stato | Descrizione |
|---|---:|---|
| `OpenAIService` | MVP | Chiamata a backend proxy che comunica con OpenAI API |
| `LocalModelService` | Future | Modello on-device o modello locale supportato |
| `MockAIService` | Test | Risposte deterministiche per test e preview |
| `DisabledAIService` | MVP | Risposta controllata quando consenso o rete non disponibili |

---

### 7.4 Backend proxy

L'app non deve chiamare OpenAI API con una chiave statica inclusa nel bundle.

Architettura raccomandata:

```text
PeakLift iOS App
    │ HTTPS + user auth token
    ▼
PeakLift AI Gateway
    ├── Verifica identità e rate limit
    ├── Applica policy e audit
    ├── Rimuove dati non necessari
    ├── Inoltra richiesta a OpenAI API
    ├── Valida output strutturato
    └── Restituisce risposta al client
```

Responsabilità del gateway:

- Proteggere API key;
- Applicare rate limiting;
- Verificare consenso AI;
- Filtrare contenuti non sicuri;
- Registrare telemetria pseudonimizzata;
- Applicare timeout e retry;
- Consentire cambio provider;
- Supportare future policy di data residency.

---

### 7.5 Context Builder

`AIContextBuilder` deve creare un payload compatto, coerente e autorizzato.

#### Contesto utente consentito

| Categoria | Esempi |
|---|---|
| Profilo | Obiettivo, livello, unità, frequenza desiderata |
| Workout recenti | Data, esercizi, volume, serie, carico e reps aggregati |
| Progressione | Trend carico, reps, e1RM e volume |
| Distribuzione muscolare | Serie e volume per muscolo |
| Insight locali | Regole deterministiche già calcolate |
| HealthKit opzionale | Passi, calorie e workout aggregati |
| Conversazione | Ultimi messaggi utili nel limite contesto |

#### Dati esclusi per default

- Email;
- Apple user identifier;
- Identificativi CloudKit;
- File CSV originali;
- Token;
- Log tecnici;
- Dati HealthKit non pertinenti;
- Informazioni non necessarie alla domanda.

---

### 7.6 Prompt System

Il prompt system deve essere composto da blocchi strutturati.

```text
1. System Policy
2. Safety Policy
3. User Profile Summary
4. Authorized Training Context
5. Deterministic Metrics
6. Relevant Insights
7. User Question
8. Output Schema
```

#### Regole di sistema

L'AI deve:

- Rispondere nella lingua dell'utente;
- Usare solo i dati presenti nel contesto;
- Dichiarare quando i dati sono insufficienti;
- Distinguere osservazioni da suggerimenti;
- Evitare diagnosi o prescrizioni mediche;
- Non garantire risultati;
- Suggerire professionisti qualificati in caso di dolore, infortuni o sintomi;
- Citare periodo analizzato e metriche rilevanti;
- Mantenere risposte sintetiche e azionabili.

---

### 7.7 Output strutturato

Le risposte AI devono essere parseabili tramite schema strutturato.

```text
AICoachResponse
- answer: String
- observedFacts: [ObservedFact]
- interpretation: String
- suggestedActions: [SuggestedAction]
- confidence: low | medium | high
- periodReference: DateRange?
- safetyNotice: String?
- insufficientData: Bool
- citedWorkoutIds: [UUID]
- citedMetricIds: [UUID]
```

Il client deve validare:

- Presenza di contenuto;
- Coerenza del livello di confidenza;
- Assenza di campi non autorizzati;
- Formato dei riferimenti;
- Assenza di istruzioni pericolose;
- Correttezza delle citazioni verso dati locali.

---

### 7.8 Insight Engine ibrido

L'MVP deve utilizzare un modello ibrido:

| Tipo insight | Motore principale |
|---|---|
| Volume settimanale | Regole locali deterministiche |
| Frequenza muscolare | Regole locali deterministiche |
| Streak | Regole locali deterministiche |
| Personal record | Regole locali deterministiche |
| Dati insufficienti | Regole locali deterministiche |
| Interpretazione trend | AI con contesto aggregato |
| Suggerimenti generalisti | AI con guardrail |
| Spiegazione dashboard | AI opzionale |
| Prioritizzazione insight | Regole + AI opzionale |

Questo approccio riduce costi, latenza e rischio di allucinazione.

---

### 7.9 Sicurezza AI

```text
User message
    │
    ▼
Input Safety Filter
    │
    ├── rischio medico?
    ├── disturbo alimentare?
    ├── richiesta pericolosa?
    └── dati insufficienti?
    │
    ▼
Context Builder
    │
    ▼
AI Provider
    │
    ▼
Output Safety Validator
    │
    ├── diagnosi?
    ├── prescrizione?
    ├── dati inventati?
    ├── promessa di risultato?
    └── tono non sicuro?
    │
    ▼
Safe response or fallback
```

In caso di contenuto sensibile, il sistema deve preferire una risposta sicura predefinita e invitare l'utente a consultare un professionista qualificato.

---

### 7.10 Costi e rate limiting

| Politica | MVP |
|---|---|
| Chat requests | Limite configurabile per utente/giorno |
| Insight generation | Trigger dopo workout completato o apertura dashboard |
| Cache insight | Riutilizzo insight valido per il periodo |
| Context limit | Riduzione a periodo e metriche rilevanti |
| Retry | Massimo un retry automatico su errori transitori |
| Timeout | Timeout configurabile con fallback UI |
| Offline | Nessuna chiamata; mostra analytics locali |

---

## 8. UI Architecture

### 8.1 Navigazione principale

```text
RootView
├── Authentication Flow
│   ├── WelcomeView
│   └── SignInWithAppleView
│
├── Onboarding Flow
│   ├── GoalSelectionView
│   ├── ExperienceLevelView
│   ├── UnitSelectionView
│   ├── PreferencesView
│   └── ConsentView
│
└── Main Tab View
    ├── Oggi
    ├── Workout
    ├── Analytics
    ├── Coach
    └── Profilo
```

---

### 8.2 Tab principali

| Tab | View root | Responsabilità |
|---|---|---|
| Oggi | `DashboardView` | Riepilogo, insight, CTA workout |
| Workout | `WorkoutHubView` | Avvio workout, workout in corso, storico |
| Analytics | `AnalyticsView` | Trend, volume, progressione ed equilibrio |
| Coach | `CoachView` | Chat AI e archivio insight |
| Profilo | `ProfileView` | Preferenze, privacy, HealthKit e gestione account |

---

### 8.3 Feature ViewModel

| Feature | ViewModel principali |
|---|---|
| Authentication | `AuthenticationViewModel`, `SessionViewModel` |
| Onboarding | `OnboardingViewModel`, `ConsentViewModel` |
| Dashboard | `DashboardViewModel`, `InsightCardViewModel` |
| Workout | `WorkoutSessionViewModel`, `WorkoutHistoryViewModel`, `RestTimerViewModel` |
| Exercise Library | `ExerciseLibraryViewModel`, `ExerciseEditorViewModel` |
| Analytics | `AnalyticsViewModel`, `ExerciseProgressViewModel`, `MuscleBalanceViewModel` |
| Coach | `CoachViewModel`, `InsightDetailViewModel` |
| Import | `CSVImportViewModel`, `CSVMappingViewModel` |
| Health | `HealthPermissionsViewModel`, `HealthSummaryViewModel` |
| Profile | `ProfileViewModel`, `PrivacyCenterViewModel` |

---

### 8.4 Regole ViewModel

Ogni ViewModel deve:

- Essere isolato al main actor quando modifica stato UI;
- Esporre stato immutabile o controllato;
- Invocare use case e non repository concreti;
- Gestire loading, success, empty state ed errore;
- Non contenere logica di persistenza diretta;
- Non costruire direttamente prompt AI;
- Non accedere a `ModelContext` o `CKContainer`;
- Essere testabile tramite protocolli e mock.

---

### 8.5 Stati UI standard

```text
ViewState<T>
- idle
- loading
- loaded(T)
- empty(EmptyStateConfiguration)
- error(UserFacingError)
```

Per azioni asincrone:

```text
ActionState
- idle
- inProgress
- succeeded
- failed(UserFacingError)
```

---

### 8.6 Componenti Design System

| Categoria | Componenti |
|---|---|
| Buttons | PrimaryButton, SecondaryButton, DestructiveButton, IconButton |
| Inputs | NumberField, WeightInput, RepsInput, RPESelector, ToggleRow |
| Cards | MetricCard, InsightCard, WorkoutCard, EmptyStateCard |
| Charts | LineChartContainer, BarChartContainer, MuscleDistributionChart |
| Workout | SetRow, ExerciseSection, RestTimerBanner, WorkoutSummaryCard |
| Coach | CoachMessageBubble, InsightExplanationCard, SafetyNoticeCard |
| Feedback | LoadingView, ErrorView, EmptyStateView, SyncStatusBanner |
| Navigation | AppTabBar, SectionHeader, FilterBar, DateRangePicker |
| Accessibility | AccessibleChartSummary, DynamicTypeContainer, VoiceOverLabels |

---

### 8.7 Workout UI

```text
WorkoutSessionView
├── WorkoutHeader
│   ├── WorkoutTitle
│   ├── ElapsedTime
│   └── FinishWorkoutButton
│
├── WorkoutExerciseList
│   ├── ExerciseSection
│   │   ├── ExerciseHeader
│   │   ├── PreviousPerformanceRow
│   │   ├── SetRow[]
│   │   └── AddSetButton
│   └── AddExerciseButton
│
└── RestTimerOverlay
```

Requisiti UX:

- Interazione rapida con una mano;
- Input numerico ottimizzato;
- Precompilazione ultima performance;
- Feedback haptic su completamento serie;
- Autosave dopo ogni modifica rilevante;
- Timer visibile senza coprire il contenuto;
- Supporto Dark Mode;
- Supporto Dynamic Type e VoiceOver.

---

### 8.8 Analytics UI

```text
AnalyticsView
├── DateRangeFilter
├── MetricsSummary
├── VolumeSection
├── ExerciseProgressSection
├── MuscleBalanceSection
├── FrequencySection
└── EducationalMetricExplanation
```

Ogni grafico deve includere:

- Titolo;
- Unità;
- Periodo;
- Descrizione testuale accessibile;
- Stato senza dati;
- Interazione tap o selezione;
- Collegamento al workout sorgente quando possibile.

---

### 8.9 Coach UI

```text
CoachView
├── CoachConsentState
├── InsightCarousel
├── ConversationList
├── SuggestedQuestions
├── MessageComposer
└── SafetyNotice
```

Le risposte devono distinguere visivamente:

- Dati osservati;
- Interpretazione;
- Suggerimento;
- Limiti o disclaimer;
- Periodo analizzato.

---

### 8.10 WidgetKit

Widget previsti dopo MVP core:

| Widget | Dimensione | Contenuto |
|---|---|---|
| Workout Quick Start | Small | Pulsante rapido per iniziare workout |
| Weekly Summary | Medium | Workout settimana, volume e streak |
| AI Insight | Medium | Insight prioritario non sensibile |
| Next Workout | Small/Medium | Ultimo workout o template da ripetere |

I widget devono leggere dati condivisi in modo sicuro attraverso App Group o meccanismi approvati dalla piattaforma, senza includere informazioni sanitarie sensibili non necessarie.

---

### 8.11 ActivityKit

ActivityKit può supportare il timer di recupero.

```text
RestTimerAttributes
- workoutId
- exerciseName
- setNumber

ContentState
- endDate
- remainingDuration
- isPaused
```

Comportamento:

- L'utente può avviare una Live Activity dal workout;
- Il timer deve restare aggiornato durante background;
- La Live Activity deve terminare automaticamente o manualmente;
- Nessun dato sensibile non necessario deve essere mostrato sulla lock screen.

---

### 8.12 Vision Framework

Vision Framework è fuori scope MVP core, ma l'architettura deve predisporre un modulo isolato.

```text
VisionService
├── analyzePose(videoOrImage)
├── extractLandmarks()
├── generateMovementMetadata()
└── deleteAnalysisArtifacts()
```

Vincoli:

- Analisi esclusivamente opzionale;
- Consenso esplicito dedicato;
- Nessuna diagnosi o valutazione medica;
- Elaborazione on-device quando possibile;
- Media non persistiti senza conferma utente;
- Separazione completa da workout logging MVP.

---

## 9. Testing Strategy

### 9.1 Obiettivi

La strategia di test deve verificare:

- Correttezza dei calcoli fitness;
- Integrità dati in offline mode;
- Comportamento di sincronizzazione;
- Sicurezza e limiti AI;
- Gestione consensi;
- Stabilità UI durante workout;
- Accessibilità e navigazione;
- Regressioni prima di ogni rilascio.

---

### 9.2 Piramide dei test

```text
                 ┌─────────────────┐
                 │    UI Tests     │
                 │ Flussi critici  │
                 └─────────────────┘
              ┌───────────────────────┐
              │ Integration Tests     │
              │ Data, Sync, Services  │
              └───────────────────────┘
         ┌─────────────────────────────────┐
         │            Unit Tests           │
         │ Domain, Use Cases, ViewModels   │
         └─────────────────────────────────┘
```

---

### 9.3 Unit Test

| Area | Casi principali |
|---|---|
| Workout calculations | Volume, serie valide, serie saltate, warm-up esclusi |
| Conversioni unità | kg/lb, arrotondamenti e formattazione |
| 1RM stimato | Calcoli su carico e ripetizioni validi |
| Progressione | Confronto periodi, campioni insufficienti e trend |
| Streak | Settimane consecutive, periodi vuoti e timezone |
| Muscle balance | Attribuzione muscoli primari e secondari |
| Use case workout | Create, update, complete, cancel, duplicate |
| CSV parser | Colonne mancanti, mapping, date invalide, duplicati |
| Consent validator | AI e HealthKit attivi, negati o revocati |
| Context builder | Inclusione esclusiva di dati autorizzati |
| AI validator | Schema output, dati inventati, contenuti non sicuri |
| ViewModel | Stati loading, success, empty, error |
| Conflict resolver | Last-write-wins, consenso restrittivo e merge serie |

Target suggerito:

- Copertura alta per Domain e Data critical path;
- Tutte le funzioni metriche devono avere test deterministici;
- Ogni bug relativo a perdita dati o calcolo errato deve generare un regression test.

---

### 9.4 Integration Test

| Integrazione | Scenari |
|---|---|
| SwiftData | Persistenza workout, relazioni, soft delete e migrazioni |
| CloudKit | Create, update, delete, retry, offline queue e conflitti |
| HealthKit | Autorizzazione, rifiuto, dati mancanti e revoca |
| Sign in with Apple | Successo, annullamento, session restore |
| AI Gateway | Timeout, errore, output non valido, rate limit e fallback |
| CSV import | Preview, conferma, rollback, import parziale e duplicati |
| Notifications | Timer recupero, permessi negati e notifiche locali |
| Analytics cache | Invalida cache dopo modifica workout |
| Export dati | File generato, completezza e privacy dei campi |

---

### 9.5 UI Test

| Journey | Risultato atteso |
|---|---|
| Onboarding completo | Utente raggiunge dashboard |
| Onboarding senza HealthKit | L'app resta utilizzabile |
| Sign in with Apple annullato | Nessun crash, retry disponibile |
| Creazione workout | Workout in stato in corso |
| Aggiunta esercizio | Esercizio compare nella sessione |
| Inserimento serie | Serie completata e volume aggiornato |
| Recupero workout interrotto | Bozza disponibile al riavvio |
| Completamento workout | Riepilogo visibile e storico aggiornato |
| Dashboard nuova | Stato vuoto educativo |
| Analytics | Cambio filtro aggiorna dati |
| AI Coach senza consenso | Richiesta consenso visibile |
| AI Coach senza rete | Errore recuperabile e tracking disponibile |
| Import CSV | Preview, errori e conferma |
| Privacy center | Revoca AI e HealthKit aggiorna lo stato |
| Dark Mode | Contrasto e contenuti leggibili |
| Dynamic Type | Layout non troncato |
| VoiceOver | Controlli principali navigabili |

---

### 9.6 Test dati e fixture

Le fixture devono includere:

- Utente senza workout;
- Utente con un workout;
- Utente con 30, 90 e 365 giorni di storico;
- Workout in corso;
- Workout annullato;
- Serie di riscaldamento, lavoro, drop set e failure;
- Esercizi custom;
- CSV valido;
- CSV invalido;
- Conflitti CloudKit;
- Dati HealthKit mancanti;
- Insight AI a bassa, media e alta confidenza;
- Conversazioni AI con richieste sensibili.

---

### 9.7 Test AI

Il test AI deve essere diviso tra:

| Tipo | Obiettivo |
|---|---|
| Contract test | Verificare schema richiesta e risposta |
| Context test | Verificare minimizzazione dati e consensi |
| Safety test | Verificare gestione infortuni, dolore e contenuti pericolosi |
| Hallucination guard test | Verificare che riferimenti a dati inesistenti vengano rifiutati |
| Prompt regression | Verificare consistenza output su casi standard |
| Provider failure test | Timeout, rate limit, errore server e risposta vuota |

Le risposte AI reali non devono essere l'unica base dei test. I test automatici devono usare mock deterministici.

---

### 9.8 Test performance

| Area | Test |
|---|---|
| Workout logging | Inserimento ripetuto serie e autosave |
| Storico lungo | Caricamento con migliaia di serie |
| Analytics | Aggregazione 12 mesi dati |
| Dashboard | Rendering con molti insight e widget |
| Cloud sync | Coda di modifiche offline |
| CSV import | File con numero elevato di righe |
| Memory | Navigazione continua tra workout, analytics e coach |
| Battery | Timer, sync e background execution |

---

## 10. Security

### 10.1 Principi sicurezza

- Minimizzazione dei dati;
- Least privilege;
- Consenso esplicito;
- Separazione dati sensibili;
- Sicurezza by default;
- Nessuna API key nel client;
- Protezione dati in transito e a riposo;
- Tracciabilità tecnica senza esporre informazioni personali;
- Degradazione sicura se integrazioni non disponibili.

---

### 10.2 Gestione credenziali

| Credenziale | Storage |
|---|---|
| Stato Sign in with Apple | Keychain e stato sessione sicuro |
| Token backend AI | Keychain, con scadenza e refresh controllato |
| CloudKit identity | Gestita dal sistema Apple |
| API key OpenAI | Solo backend AI Gateway |
| Configurazioni non segrete | Build configuration o remote config sicuro |

Non devono essere inclusi nel repository:

- API key;
- Token;
- File `.env` reali;
- Certificati privati;
- Chiavi CloudKit;
- Dati reali di utenti;
- Fixture contenenti dati sanitari identificabili.

---

### 10.3 Dati personali e sanitari

| Categoria | Esempi | Misure |
|---|---|---|
| Identità | Apple identifier, nickname, relay email | Keychain, minimizzazione, nessun logging |
| Workout | Serie, carichi, esercizi, note | SwiftData protetto, CloudKit Private DB |
| HealthKit | Passi, calorie, workout esterni | Consenso esplicito, dati aggregati |
| Conversazioni AI | Domande, risposte e insight | Consenso AI, cancellazione disponibile |
| Media Vision | Foto o video futuri | Consenso separato, elaborazione on-device quando possibile |

---

### 10.4 Data flow privacy

```text
Workout logging
    │
    ▼
SwiftData locale
    │
    ├── CloudKit Private DB, se sync attiva
    │
    └── Analytics Engine locale
             │
             └── AI Context Builder, solo se AI consentita
                     │
                     ▼
                 AI Gateway
                     │
                     ▼
                 OpenAI API
```

Il contesto AI deve contenere solo dati strettamente necessari alla richiesta. Gli identificativi diretti dell'utente non devono essere inviati.

---

### 10.5 Privacy controls

L'utente deve poter:

- Attivare o disattivare AI Coach;
- Attivare o revocare HealthKit;
- Eliminare cronologia AI;
- Esportare dati personali;
- Eliminare account;
- Consultare informative;
- Gestire notifiche;
- Comprendere quali dati hanno generato un insight.

---

### 10.6 Logging e telemetria

| Tipo log | Regole |
|---|---|
| Debug locale | Disabilitato o ridotto in produzione |
| Crash reporting | Nessun dato workout o HealthKit identificabile |
| Analytics prodotto | Eventi pseudonimizzati e minimizzati |
| AI telemetry | Nessun contenuto conversazione completo senza consenso esplicito |
| Sync logs | Identificativi tecnici non riconducibili direttamente all'utente |
| Security logs | Accesso ristretto e retention limitata |

Eventi esempio:

```text
onboarding_completed
workout_started
workout_completed
csv_import_completed
healthkit_permission_granted
ai_coach_enabled
ai_insight_viewed
ai_message_sent
sync_failed
sync_completed
```

---

### 10.7 Threat model sintetico

| Minaccia | Rischio | Mitigazione |
|---|---|---|
| API key esposta | Uso non autorizzato AI API | Backend proxy, nessuna chiave nel client |
| Accesso non autorizzato dati locali | Esposizione workout e preferenze | Protezioni iOS, Keychain, data protection |
| Dati AI eccessivi | Violazione privacy | Context minimization e consenso esplicito |
| Sync conflict | Perdita workout | UUID, merge, soft delete e versioning |
| CSV malevolo | Crash o input invalido | Validazione schema, limiti dimensione, parsing sicuro |
| Output AI pericoloso | Danno o perdita fiducia | Safety policy e output validator |
| HealthKit misuse | Uso improprio dati salute | Permessi granulari e nessuna diagnosi |
| Log sensibili | Leakage dati | Redaction e policy logging |
| Device compromise | Accesso dati offline | Cifratura e protezioni piattaforma |

---

## 11. Deployment

### 11.1 Ambienti

| Ambiente | Scopo | Configurazione |
|---|---|---|
| Development | Sviluppo locale | Mock, CloudKit development, AI sandbox |
| Staging | Test integrati e QA | CloudKit staging, AI gateway staging |
| TestFlight | Beta interna ed esterna | Servizi production-like, telemetria controllata |
| Production | App Store | CloudKit production, AI gateway production |

Ogni ambiente deve usare configurazioni, database CloudKit e credenziali separate.

---

### 11.2 CI/CD

Pipeline raccomandata:

```text
Pull Request
    │
    ├── Swift formatting e lint
    ├── Build debug
    ├── Unit tests
    ├── Static analysis
    ├── Security secret scan
    └── UI smoke tests
    │
Merge su main
    │
    ├── Build release candidate
    ├── Integration tests
    ├── UI regression tests
    ├── Archive app
    ├── Upload TestFlight internal
    └── Generate release notes
    │
Release approval
    │
    ├── Upload TestFlight external
    ├── QA sign-off
    ├── App Store submission
    └── Production release
```

---

### 11.3 Quality gates

| Gate | Requisito |
|---|---|
| Build | Compilazione riuscita con Swift 6 |
| Lint | Nessuna violazione bloccante |
| Unit tests | Tutti i test critici superati |
| Integration tests | Storage, sync e AI mock verificati |
| UI tests | Flussi onboarding e workout principali superati |
| Security | Nessun segreto rilevato nel codice |
| Accessibility | Verifica VoiceOver e Dynamic Type sui flussi core |
| Performance | Nessuna regressione critica identificata |
| Privacy | Consensi e data flow verificati |
| Manual QA | Checklist release completata |

---

### 11.4 TestFlight

#### Beta interna

Destinatari:

- Product Manager;
- iOS developer;
- QA;
- Designer;
- Team AI/backend.

Obiettivi:

- Verificare crash;
- Validare persistency;
- Validare sincronizzazione;
- Verificare flussi AI;
- Controllare regressioni UX.

#### Beta esterna

Destinatari:

- Utenti fitness selezionati;
- Lifter principianti;
- Utenti intermedi;
- Atleti più avanzati.

Obiettivi:

- Verificare velocità del logging;
- Misurare comprensione insights;
- Validare qualità analytics;
- Raccogliere feedback AI;
- Identificare problemi di onboarding;
- Validare import CSV;
- Misurare retention iniziale.

---

### 11.5 App Store Release

Checklist App Store:

- App icon e screenshot;
- Descrizione prodotto;
- Privacy policy pubblica;
- Privacy nutrition labels;
- URL supporto;
- URL termini di utilizzo;
- Spiegazione utilizzo HealthKit;
- Spiegazione utilizzo AI;
- Dichiarazioni appropriate per dati sensibili;
- Test su device reali;
- Build stabile;
- Nessun contenuto o claim medico non consentito;
- Export compliance verificata;
- Localizzazione italiana e inglese pianificata o disponibile.

---

### 11.6 Versioning

PeakLift deve usare Semantic Versioning adattato al ciclo mobile:

```text
MAJOR.MINOR.PATCH (BUILD)
```

Esempi:

| Versione | Significato |
|---|---|
| `0.1.0` | Prototype interno |
| `0.5.0` | Beta funzionale |
| `0.9.0` | Release candidate MVP |
| `1.0.0` | Primo rilascio App Store |
| `1.1.0` | Nuove feature backward-compatible |
| `1.1.1` | Bug fix |
| `2.0.0` | Evoluzione architetturale o feature major |

---

### 11.7 Rollback

| Situazione | Azione |
|---|---|
| Bug UI non bloccante | Hotfix successivo |
| Crash frequente | Pausa rollout e invio patch urgente |
| Errore sync | Disabilitazione remota sync non critica, preservazione locale |
| Problema AI | Disabilitazione AI tramite feature flag e fallback analytics locali |
| Problema HealthKit | Disabilitazione integrazione senza bloccare workout logging |
| Migrazione dati fallita | Ripristino backup, blocco release e patch migration |

Le feature ad alto rischio, come AI Coach, HealthKit avanzato e sync sperimentale, devono essere controllabili tramite feature flag.

---

## 12. Future Technical Evolution

### 12.1 Apple Watch

L'estensione watchOS dovrà usare un modulo condiviso per:

- Sessione workout;
- Registrazione rapida serie;
- Timer recupero;
- Check-in RPE;
- Sincronizzazione con iPhone;
- Integrazione HealthKit.

La logica domain deve essere riutilizzabile e indipendente da SwiftUI specifico iPhone.

---

### 12.2 Vision Framework

L'analisi movimento futura deve essere isolata da core workout e AI Coach.

```text
Vision Feature
    ├── Media Consent
    ├── Capture Pipeline
    ├── On-device Landmark Extraction
    ├── Metadata Store
    ├── Optional AI Interpretation
    └── User-controlled Deletion
```

---

### 12.3 Modelli AI locali

L'astrazione `AIService` deve permettere l'introduzione futura di:

- Modelli on-device;
- Inference privata;
- Fallback offline;
- Classificatori locali per insight semplici;
- Sintesi locale di metriche;
- Riduzione dell'invio dati a servizi esterni.

---

### 12.4 Social e Coach Mode

Se verranno introdotti social privato o coach mode, sarà necessario:

- CloudKit Shared Database;
- Nuovi ruoli e permessi;
- ACL per condivisione workout;
- Audit log;
- Inviti sicuri;
- Privacy granulare per oggetto condiviso;
- Separazione netta tra dati privati e dati condivisi.

---

## 13. Definition of Done Tecnica

Il TDD può essere considerato implementato per MVP quando:

- L'architettura MVVM e Clean Architecture leggera è rispettata;
- Le feature non accedono direttamente a SwiftData, CloudKit, HealthKit o AI API;
- I repository sono definiti tramite protocolli e iniettati tramite dependency container;
- Workout logging è pienamente disponibile offline;
- SwiftData è configurato come source of truth locale;
- CloudKit sincronizza in modo resiliente e non causa perdita dati;
- Le metriche principali sono calcolate localmente e testate;
- AI Coach usa un gateway sicuro e non espone API key;
- Il contesto AI rispetta consensi e minimizzazione dati;
- I guardrail AI intercettano richieste mediche o pericolose;
- HealthKit è opzionale e gestito tramite autorizzazioni esplicite;
- UI supporta Dark Mode, Dynamic Type e VoiceOver sui flussi core;
- Sono presenti test unitari, integration test e UI test per i journey principali;
- CI/CD esegue build, test, lint e security scan;
- TestFlight e App Store deployment seguono checklist definite;
- Le feature rischiose sono protette da feature flag e fallback sicuri.