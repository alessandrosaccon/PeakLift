# Implementation Plan
# PeakLift

> **Versione:** 1.0  
> **Stato:** Draft  
> **Piattaforma:** iOS  
> **Obiettivo:** sviluppare e rilasciare l’MVP di PeakLift come AI Fitness Coach offline-first  
> **Stack:** Swift 6, SwiftUI, SwiftData, CloudKit, HealthKit, Sign in with Apple, Swift Charts, OpenAI API tramite AI Gateway  
> **Architettura:** MVVM, Clean Architecture leggera, Repository Pattern, Dependency Injection  
> **Documenti di riferimento:** Vision, PRD, SRS, TDD, Design System, AI Architecture  

---

## 1. Obiettivo di rilascio

L’MVP deve consentire a un utente iPhone di:

1. completare onboarding e autenticazione;
2. creare e registrare un workout offline;
3. aggiungere esercizi, serie, carichi, ripetizioni, RPE/RIR e timer;
4. consultare storico, dashboard e analytics locali;
5. ricevere insight AI spiegabili e contestuali;
6. interagire con un AI Coach basato esclusivamente su dati autorizzati;
7. sincronizzare dati tramite CloudKit;
8. gestire privacy, consensi, export ed eliminazione dati;
9. usare opzionalmente HealthKit e import CSV.

Il percorso di implementazione privilegia prima l’affidabilità del workout logging e delle metriche locali. AI, CloudKit, HealthKit e importazione devono estendere il valore del prodotto senza diventare dipendenze bloccanti per il flusso core.

---

## 2. Principi di esecuzione

- **Offline-first:** SwiftData è la source of truth locale.
- **Data before AI:** l’AI interpreta metriche locali; non sostituisce i calcoli deterministici.
- **Incremental delivery:** ogni milestone deve produrre un incremento testabile.
- **Privacy by design:** consensi AI e HealthKit sono distinti, espliciti e revocabili.
- **No client secrets:** API key AI esclusivamente lato gateway backend.
- **Apple-native UI:** SwiftUI, Dynamic Type, VoiceOver, Dark Mode, SF Symbols e Swift Charts.
- **Feature flags:** AI Coach, HealthKit, sync sperimentale e notifiche devono essere disattivabili.
- **Quality gates:** ogni milestone richiede build, lint, test automatici e verifica manuale essenziale.
- **No scope creep:** Apple Watch, Vision Framework, social, form analysis e program generation restano fuori dal MVP.

---

## 3. Struttura delle milestone

| Milestone | Nome | Focus | Risultato |
|---|---|---|---|
| M0 | Product & Technical Inception | Setup, decisioni, backlog e ambienti | Progetto pronto allo sviluppo |
| M1 | App Foundation | Architettura, design system, SwiftData e navigazione | App base navigabile e persistente |
| M2 | Identity & Onboarding | Profilo, Sign in with Apple, consensi | Utente configurato correttamente |
| M3 | Workout Core | Libreria, workout, serie, timer e autosave | Primo workout completabile offline |
| M4 | History & Analytics | Storico, dashboard, metriche e grafici | Dati trasformati in insight locali |
| M5 | Cloud & Privacy | CloudKit, sync, privacy center ed export | Dati sicuri e sincronizzati |
| M6 | AI Coach | Gateway, insight, chat, guardrail | Coaching contestuale e spiegabile |
| M7 | Optional MVP Features | HealthKit, CSV import, notifiche | MVP feature-complete |
| M8 | Quality & Beta | Hardening, accessibilità, TestFlight | Release candidate |
| M9 | App Store Launch | Release, monitoraggio e hotfix readiness | Versione 1.0.0 pubblicata |

---

## 4. Milestone M0 — Product & Technical Inception

### Obiettivo

Trasformare i documenti di prodotto e architettura in un backlog implementabile, impostare repository, ambienti e processi di delivery.

### Dipendenze

Nessuna.

### Deliverable

- Repository inizializzato.
- CI attiva.
- Ambienti development, staging e production definiti.
- Backlog MVP stimato e prioritizzato.
- Convenzioni tecniche e Definition of Done approvate.
- Configurazioni CloudKit e AI Gateway predisposte.

### Task

#### Product & delivery

- [ ] Definire owner per prodotto, iOS, backend/AI, design, QA e privacy.
- [ ] Consolidare scope MVP e scope esplicitamente escluso.
- [ ] Trasformare requisiti SRS in epiche, user story e task tecnici.
- [ ] Collegare user story a requisiti funzionali e criteri di accettazione.
- [ ] Definire Definition of Ready per avvio sviluppo.
- [ ] Definire Definition of Done per ticket, feature e release.
- [ ] Definire severity bug: blocker, critical, major, minor e cosmetic.
- [ ] Definire processo triage bug e change request.
- [ ] Definire roadmap TestFlight interna ed esterna.
- [ ] Definire processo di approvazione privacy e sicurezza.

#### Repository & workflow

- [ ] Creare repository Git principale.
- [ ] Definire branching strategy: `main`, `develop`, feature branch, release branch e hotfix branch.
- [ ] Configurare pull request template.
- [ ] Configurare issue template: bug, feature, technical debt e security issue.
- [ ] Definire convenzioni commit.
- [ ] Definire convenzioni naming Swift, cartelle, feature, test e asset.
- [ ] Configurare CODEOWNERS o revisori tecnici.
- [ ] Configurare gestione changelog e versioning semantico.

#### iOS project setup

- [ ] Creare progetto Xcode PeakLift.
- [ ] Configurare bundle identifier.
- [ ] Definire versione iOS minima supportata.
- [ ] Configurare target app, test target, UI test target e future extension target.
- [ ] Creare configurazioni `Development`, `Staging` e `Production`.
- [ ] Creare file `.xcconfig` senza segreti.
- [ ] Configurare asset catalog iniziale.
- [ ] Configurare localizzazione iniziale italiana e predisposizione inglese.
- [ ] Configurare privacy manifest iniziale.
- [ ] Configurare capability: iCloud, CloudKit, Sign in with Apple, HealthKit e Notifications.

#### CI/CD

- [ ] Configurare build automatica su pull request.
- [ ] Configurare lint con SwiftLint.
- [ ] Configurare formatting con SwiftFormat.
- [ ] Configurare unit test automatici.
- [ ] Configurare UI smoke test.
- [ ] Configurare secret scan.
- [ ] Configurare dependency scan, se disponibile.
- [ ] Configurare archive build per branch release.
- [ ] Predisporre upload TestFlight per build approvate.

#### Backend AI Gateway

- [ ] Creare repository o modulo dedicato all’AI Gateway.
- [ ] Definire ambienti development, staging e production.
- [ ] Definire secret management lato server.
- [ ] Configurare accesso al provider OpenAI.
- [ ] Definire struttura endpoint e contratti request/response.
- [ ] Predisporre autenticazione app-to-gateway.
- [ ] Predisporre rate limiting.
- [ ] Predisporre logging tecnico con redazione dati sensibili.
- [ ] Predisporre feature flag per disabilitazione AI globale.

### Criteri di uscita

- [ ] Il progetto iOS compila in CI.
- [ ] Lint, format check e test vengono eseguiti su pull request.
- [ ] Nessun segreto è presente nel repository o nel bundle iOS.
- [ ] Esistono ambienti distinti per sviluppo, staging e produzione.
- [ ] Il backlog MVP è ordinato per dipendenze e rischio.

---

## 5. Milestone M1 — App Foundation

### Obiettivo

Costruire le fondamenta architetturali, il design system, il modello dati locale e la navigazione principale.

### Dipendenze

M0 completata.

### Deliverable

- App SwiftUI con tab bar e routing.
- Dependency injection configurata.
- SwiftData funzionante.
- Design tokens e componenti UI base disponibili.
- Catalogo esercizi iniziale popolabile.
- Test base e preview affidabili.

### Task

#### App architecture

- [ ] Creare `PeakLiftApp`.
- [ ] Creare `AppEnvironment`.
- [ ] Creare `DependencyContainer`.
- [ ] Creare `RootView`.
- [ ] Creare `AppCoordinator`.
- [ ] Definire gestione stato app: launch, onboarding, authenticated, unauthenticated, maintenance.
- [ ] Implementare gestione errori condivisa.
- [ ] Implementare logging tecnico locale redatto.
- [ ] Implementare feature flag abstraction.
- [ ] Definire route e deep link foundation.

#### Project structure

- [ ] Creare cartelle `App`.
- [ ] Creare cartelle `Core`.
- [ ] Creare cartelle `Domain`.
- [ ] Creare cartelle `Data`.
- [ ] Creare cartelle `Features`.
- [ ] Creare cartelle `Services`.
- [ ] Creare cartelle `Resources`.
- [ ] Creare cartelle `Tests`.
- [ ] Applicare regole di dipendenza tra layer.

#### Domain layer

- [ ] Definire entity `UserProfile`.
- [ ] Definire entity `Workout`.
- [ ] Definire entity `WorkoutExercise`.
- [ ] Definire entity `WorkoutSet`.
- [ ] Definire entity `Exercise`.
- [ ] Definire entity `MuscleGroup`.
- [ ] Definire entity `ExerciseMuscleGroup`.
- [ ] Definire entity `PersonalRecord`.
- [ ] Definire entity `ProgressMetric`.
- [ ] Definire entity `ConsentRecord`.
- [ ] Definire enum stato workout.
- [ ] Definire enum stato serie.
- [ ] Definire enum tipo serie.
- [ ] Definire enum unità kg/lb.
- [ ] Definire enum obiettivi e livello esperienza.
- [ ] Definire value object per carico, ripetizioni, RPE, RIR e intervallo date.
- [ ] Definire protocolli repository.

#### SwiftData

- [ ] Configurare `ModelContainer`.
- [ ] Creare modelli SwiftData per profilo, workout, esercizi e serie.
- [ ] Creare relazioni Workout → WorkoutExercise → WorkoutSet.
- [ ] Creare relazione Exercise ↔ MuscleGroup.
- [ ] Implementare campi audit: UUID, `createdAt`, `updatedAt`, `deletedAt`, `version`, `syncStatus`.
- [ ] Implementare mapping domain ↔ SwiftData.
- [ ] Creare repository locali.
- [ ] Implementare migrazione schema V1.
- [ ] Implementare fixture e seed data per sviluppo.
- [ ] Implementare reset data limitato a development e UI test.

#### Design system foundation

- [ ] Configurare palette Light Mode e Dark Mode.
- [ ] Definire token colore semanticamente nominati.
- [ ] Definire scala tipografica Dynamic Type.
- [ ] Definire spacing system.
- [ ] Definire corner radius system.
- [ ] Definire shadow system.
- [ ] Definire animation timing tokens.
- [ ] Definire iconografia SF Symbols.
- [ ] Creare componenti: `PrimaryButton`.
- [ ] Creare componenti: `SecondaryButton`.
- [ ] Creare componenti: `DestructiveButton`.
- [ ] Creare componenti: `IconButton`.
- [ ] Creare componenti: `GlassCard`.
- [ ] Creare componenti: `EmptyStateView`.
- [ ] Creare componenti: `LoadingStateView`.
- [ ] Creare componenti: `ErrorStateView`.
- [ ] Creare componenti: input numerico base.
- [ ] Configurare accessibility label standard.

#### Navigation

- [ ] Implementare tab Dashboard.
- [ ] Implementare tab Workout.
- [ ] Implementare tab Analytics.
- [ ] Implementare tab Coach.
- [ ] Implementare tab Profile.
- [ ] Implementare placeholder per schermate principali.
- [ ] Configurare `NavigationStack` per ogni area.
- [ ] Gestire safe area e keyboard safe area.
- [ ] Configurare modalità Dark Mode.

#### Test

- [ ] Unit test value object.
- [ ] Unit test validazioni domain.
- [ ] Unit test mapping SwiftData.
- [ ] Integration test storage locale.
- [ ] UI smoke test avvio app.
- [ ] UI smoke test tab bar.
- [ ] Verifica preview componenti design system.

### Criteri di uscita

- [ ] App navigabile con cinque aree principali.
- [ ] Modelli dati persistiti localmente.
- [ ] I layer rispettano l’architettura definita.
- [ ] I componenti base supportano Light Mode, Dark Mode e Dynamic Type.
- [ ] Le preview usano mock e fixture senza dipendenze esterne.

---

## 6. Milestone M2 — Identity & Onboarding

### Obiettivo

Consentire a un nuovo utente di autenticarsi, completare onboarding, creare un profilo e controllare i propri consensi.

### Dipendenze

M1 completata.

### Deliverable

- Sign in with Apple.
- Sessione utente persistente.
- Onboarding completabile in meno di tre minuti.
- Profilo modificabile.
- Consensi AI e HealthKit separati e persistiti.

### Task

#### Sign in with Apple

- [ ] Implementare schermata autenticazione.
- [ ] Implementare Sign in with Apple.
- [ ] Gestire autenticazione completata.
- [ ] Gestire annullamento autenticazione.
- [ ] Gestire errore autenticazione.
- [ ] Salvare Apple user identifier in modo sicuro.
- [ ] Gestire email relay quando disponibile.
- [ ] Verificare stato credenziale all’avvio app.
- [ ] Implementare logout.
- [ ] Preservare dati locali in caso di logout.
- [ ] Mostrare impatto logout sulla sync CloudKit.

#### Onboarding

- [ ] Implementare welcome screen.
- [ ] Implementare spiegazione valore tracking + AI.
- [ ] Implementare selezione obiettivo.
- [ ] Implementare selezione livello esperienza.
- [ ] Implementare selezione unità kg/lb.
- [ ] Implementare frequenza settimanale opzionale.
- [ ] Implementare preferenze attrezzatura opzionali.
- [ ] Implementare muscoli prioritari opzionali.
- [ ] Implementare nickname opzionale.
- [ ] Implementare navigazione avanti, indietro e skip per dati opzionali.
- [ ] Salvare avanzamento onboarding.
- [ ] Garantire ripresa onboarding se app chiusa.
- [ ] Implementare dashboard empty state dopo completamento.

#### Consensi

- [ ] Implementare consenso AI separato.
- [ ] Implementare consenso HealthKit separato.
- [ ] Salvare versione informativa e timestamp consenso.
- [ ] Gestire consenso negato.
- [ ] Gestire consenso revocato.
- [ ] Consentire tracking senza AI e senza HealthKit.
- [ ] Aggiungere link a privacy policy.
- [ ] Aggiungere copy chiaro sulle categorie dati AI.
- [ ] Aggiungere copy chiaro su dati HealthKit.

#### Profilo

- [ ] Implementare schermata Profile.
- [ ] Implementare modifica nickname.
- [ ] Implementare modifica obiettivo.
- [ ] Implementare modifica livello esperienza.
- [ ] Implementare modifica unità di misura.
- [ ] Implementare modifica frequenza desiderata.
- [ ] Implementare modifica muscoli prioritari.
- [ ] Implementare modifica attrezzatura.
- [ ] Applicare conversione UI kg/lb senza alterare storage interno in kg.

#### Test

- [ ] Unit test session management.
- [ ] Unit test gestione consenso.
- [ ] Unit test conversione unità.
- [ ] UI test onboarding happy path.
- [ ] UI test onboarding con skip.
- [ ] UI test consenso negato.
- [ ] UI test modifica profilo.
- [ ] Accessibility test onboarding.
- [ ] Test Dynamic Type onboarding.

### Criteri di uscita

- [ ] Nuovo utente completa onboarding entro tre minuti.
- [ ] L’utente può usare tracking con AI e HealthKit disattivati.
- [ ] Profilo e preferenze persistono dopo riavvio.
- [ ] Sign in with Apple non causa perdita dati locali in caso di annullamento o errore.
- [ ] I consensi sono espliciti, distinti e revocabili.

---

## 7. Milestone M3 — Workout Core

### Obiettivo

Realizzare il flusso principale dell’app: creare, registrare, salvare, riprendere, completare e annullare workout in modalità offline.

### Dipendenze

M1 e M2 completate.

### Deliverable

- Libreria esercizi funzionante.
- Workout logging rapido.
- Gestione serie completa.
- Timer recupero.
- Autosave e ripristino bozza.
- Riepilogo workout completato.

### Task

#### Libreria esercizi

- [ ] Importare catalogo esercizi iniziale.
- [ ] Popolare gruppi muscolari standard.
- [ ] Implementare ricerca per nome.
- [ ] Implementare normalizzazione ricerca.
- [ ] Implementare filtro per gruppo muscolare.
- [ ] Implementare filtro per attrezzatura.
- [ ] Implementare dettaglio esercizio.
- [ ] Implementare creazione esercizio personalizzato.
- [ ] Validare nome esercizio obbligatorio.
- [ ] Validare muscolo primario obbligatorio.
- [ ] Implementare stato custom exercise.
- [ ] Implementare archiviazione esercizi custom.
- [ ] Preservare snapshot nome esercizio nello storico workout.

#### Creazione workout

- [ ] Implementare `CreateWorkoutUseCase`.
- [ ] Implementare avvio workout vuoto.
- [ ] Implementare titolo workout opzionale.
- [ ] Salvare timestamp inizio.
- [ ] Creare workout come draft o in progress.
- [ ] Implementare aggiunta esercizi.
- [ ] Implementare rimozione esercizi.
- [ ] Implementare duplicazione esercizi.
- [ ] Implementare riordino esercizi.
- [ ] Implementare note workout.
- [ ] Implementare note per esercizio.
- [ ] Implementare autosave progressivo.

#### Gestione serie

- [ ] Implementare lista serie per esercizio.
- [ ] Implementare aggiunta serie.
- [ ] Implementare rimozione serie.
- [ ] Implementare duplicazione serie.
- [ ] Implementare ordine serie.
- [ ] Implementare input carico.
- [ ] Implementare input ripetizioni.
- [ ] Implementare input RPE opzionale.
- [ ] Implementare input RIR opzionale.
- [ ] Implementare selezione tipo serie.
- [ ] Implementare stato planned, completed e skipped.
- [ ] Implementare timestamp completamento.
- [ ] Implementare validazione valori non negativi.
- [ ] Implementare supporto carichi decimali.
- [ ] Implementare precompilazione ultima performance.
- [ ] Implementare feedback visivo serie completata.
- [ ] Implementare feedback haptic leggero serie completata.
- [ ] Escludere set skipped dal volume.
- [ ] Implementare opzione esclusione warm-up dalle metriche.

#### Timer recupero

- [ ] Implementare timer manuale.
- [ ] Implementare durata timer configurabile.
- [ ] Implementare avvio automatico opzionale dopo serie.
- [ ] Implementare pausa timer.
- [ ] Implementare ripresa timer.
- [ ] Implementare modifica timer.
- [ ] Implementare annullamento timer.
- [ ] Implementare notifica locale allo scadere.
- [ ] Gestire background e ritorno foreground.
- [ ] Collegare durata recupero alla serie, quando disponibile.
- [ ] Predisporre modello per futura Live Activity.

#### Autosave e recovery

- [ ] Salvare modifiche serie senza attese percepibili.
- [ ] Salvare draft se utente esce dalla sessione.
- [ ] Ripristinare workout in corso al riavvio app.
- [ ] Gestire crash o terminazione app durante workout.
- [ ] Implementare dialog uscita workout con opzioni: continua, salva bozza, annulla.
- [ ] Implementare annullamento workout con conferma.
- [ ] Garantire che workout annullato non entri nelle metriche.

#### Completamento workout

- [ ] Implementare `CompleteWorkoutUseCase`.
- [ ] Salvare timestamp fine.
- [ ] Calcolare durata workout.
- [ ] Calcolare volume totale.
- [ ] Calcolare serie allenanti.
- [ ] Aggiornare personal record.
- [ ] Aggiornare stato workout a completed.
- [ ] Invalidare cache analytics.
- [ ] Implementare schermata riepilogo post-workout.
- [ ] Consentire modifica workout completato.
- [ ] Ricalcolare metriche dopo modifica workout completato.
- [ ] Implementare duplicazione workout precedente.

#### UX workout

- [ ] Applicare input ad alto contrasto.
- [ ] Garantire touch target 44 pt minimo.
- [ ] Preferire target 48–56 pt per azioni frequenti.
- [ ] Usare cifre tabulari per peso, reps e timer.
- [ ] Limitare animazioni decorative.
- [ ] Supportare Reduce Motion.
- [ ] Supportare VoiceOver per ogni set.
- [ ] Testare utilizzo con una mano.

#### Test

- [ ] Unit test calcolo volume.
- [ ] Unit test set warm-up.
- [ ] Unit test set skipped.
- [ ] Unit test set completed.
- [ ] Unit test stato workout.
- [ ] Unit test personal record.
- [ ] Unit test precompilazione ultima performance.
- [ ] Integration test autosave.
- [ ] Integration test ripristino draft.
- [ ] UI test creazione workout.
- [ ] UI test aggiunta esercizio.
- [ ] UI test inserimento serie.
- [ ] UI test completamento workout.
- [ ] UI test annullamento workout.
- [ ] UI test timer background.
- [ ] Accessibility test schermata workout.

### Criteri di uscita

- [ ] L’utente registra un workout completo senza connessione.
- [ ] Le serie sono salvate correttamente dopo ogni modifica significativa.
- [ ] Il workout in corso è recuperabile dopo riavvio app.
- [ ] Un workout annullato non influenza le metriche.
- [ ] Il riepilogo workout mostra durata, volume, esercizi e serie coerenti.
- [ ] Il logging rimane rapido e non dipende da AI, CloudKit o HealthKit.

---

## 8. Milestone M4 — History & Analytics

### Obiettivo

Rendere consultabili i workout completati e trasformare dati registrati in metriche e trend locali comprensibili.

### Dipendenze

M3 completata.

### Deliverable

- Storico workout filtrabile.
- Dashboard con metriche principali.
- Analytics locali.
- Grafici accessibili.
- Insight deterministici.
- Stati dati insufficienti.

### Task

#### Workout history

- [ ] Implementare lista workout ordinata dal più recente.
- [ ] Mostrare data, titolo, durata, esercizi e volume.
- [ ] Implementare dettaglio workout completo.
- [ ] Mostrare serie completate, saltate e warm-up.
- [ ] Implementare ricerca per workout.
- [ ] Implementare ricerca per esercizio.
- [ ] Implementare filtro per periodo.
- [ ] Implementare filtro per esercizio.
- [ ] Implementare filtro per gruppo muscolare.
- [ ] Implementare modifica workout storico.
- [ ] Implementare duplicazione workout storico.
- [ ] Implementare eliminazione workout con conferma.
- [ ] Implementare soft delete.
- [ ] Invalidare analytics dopo modifica o eliminazione.

#### Analytics engine

- [ ] Implementare `AnalyticsEngine`.
- [ ] Calcolare volume per workout.
- [ ] Calcolare volume per esercizio.
- [ ] Calcolare volume per gruppo muscolare.
- [ ] Calcolare serie allenanti.
- [ ] Calcolare workout per settimana.
- [ ] Calcolare frequenza muscolare.
- [ ] Calcolare streak.
- [ ] Calcolare variazione periodo corrente vs periodo precedente.
- [ ] Calcolare personal record.
- [ ] Calcolare 1RM stimato.
- [ ] Calcolare progressione esercizio.
- [ ] Calcolare distribuzione muscolare.
- [ ] Implementare pesi per muscoli secondari.
- [ ] Implementare quality evaluator per dati insufficienti.
- [ ] Implementare cache `ProgressMetric`.
- [ ] Implementare invalidazione cache.
- [ ] Versionare algoritmo di calcolo.

#### Dashboard

- [ ] Implementare saluto contestuale.
- [ ] Implementare CTA `Inizia workout`.
- [ ] Implementare card workout della settimana.
- [ ] Implementare MetricCard volume settimanale.
- [ ] Implementare confronto settimana precedente.
- [ ] Implementare ProgressRing per obiettivo workout.
- [ ] Implementare streak.
- [ ] Implementare ultimo workout.
- [ ] Implementare progresso esercizio rilevante.
- [ ] Implementare stato sync placeholder.
- [ ] Implementare empty state educativo.
- [ ] Implementare pull-to-refresh.
- [ ] Applicare gerarchia visuale premium e content-first.

#### Analytics UI

- [ ] Implementare selettore periodo: 7 giorni.
- [ ] Implementare selettore periodo: 30 giorni.
- [ ] Implementare selettore periodo: 90 giorni.
- [ ] Implementare selettore periodo: anno.
- [ ] Implementare selettore periodo personalizzato.
- [ ] Implementare ChartCard.
- [ ] Implementare line chart volume.
- [ ] Implementare chart progressione esercizio.
- [ ] Implementare chart frequenza workout.
- [ ] Implementare chart distribuzione muscolare.
- [ ] Implementare MuscleHeatmap.
- [ ] Implementare alternativa lista/bar chart alla heatmap.
- [ ] Implementare tooltip dati.
- [ ] Implementare collegamento grafico → workout sorgente.
- [ ] Mostrare definizione metrica.
- [ ] Mostrare periodo analizzato.
- [ ] Mostrare stato dati insufficienti.
- [ ] Implementare descrizioni VoiceOver per grafici.

#### Insight locali

- [ ] Creare entity `AIInsight` utilizzabile anche per insight rule-based.
- [ ] Implementare insight `newPersonalRecord`.
- [ ] Implementare insight `volumeIncreased`.
- [ ] Implementare insight `volumeDecreased`.
- [ ] Implementare insight `consistency`.
- [ ] Implementare insight `frequencyLow`.
- [ ] Implementare insight `insufficientData`.
- [ ] Salvare periodo analizzato.
- [ ] Salvare dati osservati.
- [ ] Salvare livello confidenza.
- [ ] Implementare stato nuovo, letto, salvato e ignorato.
- [ ] Implementare scadenza insight.
- [ ] Implementare prioritizzazione Dashboard.

#### Test

- [ ] Unit test volume.
- [ ] Unit test frequenza.
- [ ] Unit test streak.
- [ ] Unit test 1RM.
- [ ] Unit test progressione.
- [ ] Unit test comparazione periodi.
- [ ] Unit test distribuzione muscolare.
- [ ] Unit test dati insufficienti.
- [ ] Integration test invalidazione metriche.
- [ ] UI test filtri storico.
- [ ] UI test filtri analytics.
- [ ] UI test grafici senza dati.
- [ ] Accessibility test grafici.
- [ ] Test performance su storico esteso.

### Criteri di uscita

- [ ] L’utente può trovare, filtrare e modificare workout storici.
- [ ] Dashboard mostra dati rilevanti anche senza rete.
- [ ] Analytics calcola correttamente volume, frequenza, progressione e distribuzione.
- [ ] I grafici sono leggibili su iPhone e hanno descrizioni testuali.
- [ ] Gli insight locali non interpretano eccessivamente dati insufficienti.

---

## 9. Milestone M5 — Cloud & Privacy

### Obiettivo

Aggiungere sincronizzazione CloudKit resiliente, privacy center, gestione consensi avanzata, export e cancellazione dati.

### Dipendenze

M2 e M3 completate. M4 consigliata per verificare invalidazioni analytics e merge dati.

### Deliverable

- CloudKit Private Database configurato.
- Sync offline-first con retry.
- Stato sincronizzazione visibile.
- Privacy Center completo.
- Export dati.
- Flusso cancellazione account e dati.

### Task

#### CloudKit data model

- [ ] Definire record CloudKit per profilo.
- [ ] Definire record CloudKit per esercizi custom.
- [ ] Definire record CloudKit per workout.
- [ ] Definire record CloudKit per workout exercise.
- [ ] Definire record CloudKit per workout set.
- [ ] Definire record CloudKit per insight.
- [ ] Definire record CloudKit per preferenze e consensi.
- [ ] Definire record name stabile basato su UUID locale.
- [ ] Configurare CloudKit Private Database.
- [ ] Configurare zone e change token.
- [ ] Configurare indici minimi necessari.
- [ ] Validare schema development.
- [ ] Preparare deployment schema production.

#### Sync engine

- [ ] Implementare `CloudKitSyncCoordinator`.
- [ ] Implementare mapper SwiftData ↔ CKRecord.
- [ ] Implementare upload create.
- [ ] Implementare upload update.
- [ ] Implementare upload delete.
- [ ] Implementare soft delete sincronizzato.
- [ ] Implementare sync incrementale download.
- [ ] Implementare change token locale.
- [ ] Implementare coda modifiche pending.
- [ ] Implementare retry con exponential backoff.
- [ ] Implementare sync all’avvio app.
- [ ] Implementare sync al ritorno rete.
- [ ] Implementare sync dopo completamento workout.
- [ ] Implementare sync manuale.
- [ ] Implementare stato `localOnly`.
- [ ] Implementare stato `pendingUpload`.
- [ ] Implementare stato `synced`.
- [ ] Implementare stato `conflict`.
- [ ] Implementare stato `failed`.
- [ ] Gestire account iCloud non disponibile.
- [ ] Gestire quota CloudKit.
- [ ] Gestire rete intermittente.
- [ ] Garantire idempotenza retry.

#### Conflict resolution

- [ ] Implementare last-write-wins per preferenze.
- [ ] Implementare merge record workout per UUID.
- [ ] Implementare merge serie per UUID.
- [ ] Implementare prevalenza consenso revocato.
- [ ] Implementare rilevazione conflitto rilevante.
- [ ] Conservare copia recuperabile dei record conflittuali.
- [ ] Implementare telemetria tecnica redatta conflitti.
- [ ] Implementare UI informativa per conflitti non risolvibili.

#### Privacy Center

- [ ] Implementare schermata Privacy Center.
- [ ] Mostrare stato consenso AI.
- [ ] Mostrare stato consenso HealthKit.
- [ ] Mostrare stato notifiche.
- [ ] Implementare revoca consenso AI.
- [ ] Implementare revoca consenso HealthKit.
- [ ] Implementare cancellazione chat AI.
- [ ] Implementare cancellazione insight AI salvati.
- [ ] Implementare richiesta export dati.
- [ ] Implementare export workout.
- [ ] Implementare export serie.
- [ ] Implementare export metriche.
- [ ] Implementare export insight.
- [ ] Implementare export conversazioni AI.
- [ ] Escludere token, secret e log dall’export.
- [ ] Implementare richiesta eliminazione account.
- [ ] Implementare conferma azione distruttiva.
- [ ] Implementare eliminazione locale.
- [ ] Implementare eliminazione CloudKit.
- [ ] Implementare stato richiesta completata o fallita.

#### Test

- [ ] Integration test upload CloudKit.
- [ ] Integration test download CloudKit.
- [ ] Integration test delete sync.
- [ ] Integration test offline queue.
- [ ] Integration test retry.
- [ ] Test idempotenza.
- [ ] Test conflitto due device.
- [ ] Test conflitto consenso revocato.
- [ ] Test export.
- [ ] Test delete account.
- [ ] UI test stato sync.
- [ ] UI test Privacy Center.

### Criteri di uscita

- [ ] Workout e preferenze restano disponibili offline.
- [ ] Sync CloudKit non causa perdita silenziosa di dati.
- [ ] Le modifiche sono ritentate in modo idempotente.
- [ ] Lo stato di sincronizzazione è comprensibile.
- [ ] L’utente può gestire consensi, esportare dati ed eliminare account.
- [ ] La revoca del consenso AI impedisce nuove chiamate AI.

---

## 10. Milestone M6 — AI Coach

### Obiettivo

Implementare insight AI e chat contestuale in modo sicuro, spiegabile, provider-agnostic e basato sui dati autorizzati.

### Dipendenze

M4 completata. M5 consigliata per consensi, sync e gestione privacy completa.

### Deliverable

- AI Gateway sicuro.
- Context Builder minimizzato.
- Insight AI proattivi.
- AI Coach chat.
- Guardrail safety.
- Output schema validato.
- Fallback offline e rule-based.
- Feedback utente sugli insight.

### Task

#### AI Gateway

- [ ] Implementare endpoint insight Dashboard.
- [ ] Implementare endpoint post-workout analysis.
- [ ] Implementare endpoint AI Coach chat.
- [ ] Implementare autenticazione client ↔ gateway.
- [ ] Implementare autorizzazione richiesta per utente.
- [ ] Implementare rate limit utente.
- [ ] Implementare rate limit IP quando necessario.
- [ ] Implementare request size limit.
- [ ] Implementare timeout provider.
- [ ] Implementare retry controllato backend.
- [ ] Implementare redazione log.
- [ ] Implementare monitoraggio errori gateway.
- [ ] Implementare feature flag disabilitazione AI.
- [ ] Mantenere API key OpenAI solo lato server.
- [ ] Predisporre provider adapter abstraction.

#### AI service layer iOS

- [ ] Definire protocollo `AIService`.
- [ ] Implementare `RemoteAIService`.
- [ ] Implementare `MockAIService`.
- [ ] Implementare `DisabledAIService`.
- [ ] Implementare `CachedAIService`.
- [ ] Implementare DTO request.
- [ ] Implementare DTO response.
- [ ] Implementare error taxonomy.
- [ ] Implementare cancellazione richiesta chat.
- [ ] Implementare retry esplicito utente.
- [ ] Implementare stato UI AI.

#### Context Builder

- [ ] Implementare `AIContextBuilder`.
- [ ] Implementare filtro consenso AI.
- [ ] Implementare filtro consenso HealthKit.
- [ ] Implementare selezione intent domanda.
- [ ] Implementare selezione periodo.
- [ ] Implementare aggregazione metriche locali.
- [ ] Implementare selezione esercizi rilevanti.
- [ ] Implementare selezione workout recenti rilevanti.
- [ ] Implementare data quality evaluator.
- [ ] Implementare token budget manager.
- [ ] Implementare context hash.
- [ ] Implementare context snapshot.
- [ ] Escludere email e Apple identifier.
- [ ] Escludere token e log.
- [ ] Escludere CSV raw.
- [ ] Escludere HealthKit senza doppio consenso.
- [ ] Escludere note non autorizzate.

#### Prompt management

- [ ] Definire prompt Dashboard insight.
- [ ] Definire prompt post-workout insight.
- [ ] Definire prompt Coach chat.
- [ ] Definire prompt exercise analysis.
- [ ] Definire prompt muscle balance.
- [ ] Definire prompt weekly review.
- [ ] Definire prompt safety redirect.
- [ ] Implementare prompt versioning.
- [ ] Implementare schema versioning.
- [ ] Implementare model profile configuration.
- [ ] Implementare rollback prompt.
- [ ] Registrare prompt version nei risultati.

#### Response validation

- [ ] Implementare response parser.
- [ ] Implementare JSON schema validation.
- [ ] Implementare validazione categoria.
- [ ] Implementare validazione campi obbligatori.
- [ ] Implementare validazione testo e lunghezza.
- [ ] Implementare validazione lingua.
- [ ] Implementare grounding validation.
- [ ] Validare metriche citate contro context snapshot.
- [ ] Validare periodo citato contro context snapshot.
- [ ] Validare esercizi citati contro context snapshot.
- [ ] Implementare safety post-check.
- [ ] Bloccare diagnosi e prescrizioni.
- [ ] Bloccare claim assoluti non supportati.
- [ ] Implementare fallback response template.

#### Insight AI

- [ ] Implementare trigger post-workout.
- [ ] Implementare trigger apertura Dashboard.
- [ ] Implementare trigger nuovo PR.
- [ ] Implementare trigger variazione volume.
- [ ] Implementare trigger costanza.
- [ ] Implementare trigger dati insufficienti.
- [ ] Implementare categorie progress.
- [ ] Implementare categorie achievement.
- [ ] Implementare categorie recommendation.
- [ ] Implementare categorie warning.
- [ ] Implementare categorie balance.
- [ ] Implementare categorie insufficient data.
- [ ] Implementare cache insight.
- [ ] Implementare invalidazione cache insight.
- [ ] Implementare limite frequenza insight.
- [ ] Implementare deduplicazione insight.
- [ ] Implementare prioritizzazione Dashboard.
- [ ] Implementare scadenza insight.
- [ ] Implementare feedback utile/non utile.
- [ ] Implementare salva/ignora insight.

#### AI Coach chat

- [ ] Creare entity `CoachConversation`.
- [ ] Creare entity `CoachMessage`.
- [ ] Implementare lista conversazioni.
- [ ] Implementare dettaglio conversazione.
- [ ] Implementare invio messaggio.
- [ ] Implementare bubble utente.
- [ ] Implementare `AIMessageBubble`.
- [ ] Implementare bubble loading.
- [ ] Implementare suggested questions.
- [ ] Implementare riferimenti a periodo analizzato.
- [ ] Implementare riferimenti a dati osservati.
- [ ] Implementare cancellazione messaggio.
- [ ] Implementare cancellazione conversazione.
- [ ] Implementare summary conversazione locale.
- [ ] Implementare stato offline.
- [ ] Implementare stato consenso richiesto.
- [ ] Implementare stato rate limited.
- [ ] Implementare stato safety redirect.

#### Safety

- [ ] Implementare input safety filter.
- [ ] Riconoscere richieste su dolore e infortunio.
- [ ] Riconoscere richieste mediche o diagnostiche.
- [ ] Riconoscere richieste nutrizionali cliniche.
- [ ] Riconoscere contenuti potenzialmente pericolosi.
- [ ] Implementare redirect prudente.
- [ ] Implementare disclaimer.
- [ ] Garantire linguaggio non prescrittivo.
- [ ] Garantire distinzione tra fatti e interpretazione.
- [ ] Non usare AI per modificare automaticamente workout o programma.

#### Test

- [ ] Unit test Context Builder.
- [ ] Unit test consenso AI.
- [ ] Unit test doppio consenso HealthKit.
- [ ] Unit test token management.
- [ ] Unit test response parser.
- [ ] Unit test grounding validation.
- [ ] Contract test gateway.
- [ ] Test output schema invalido.
- [ ] Test hallucination metriche inesistenti.
- [ ] Test prompt injection.
- [ ] Test richieste mediche.
- [ ] Test rate limit.
- [ ] Test timeout.
- [ ] Test fallback offline.
- [ ] UI test Coach chat con mock.
- [ ] UI test insight feedback.
- [ ] Regression test prompt.

### Criteri di uscita

- [ ] Nessuna API key AI è presente nell’app.
- [ ] AI Coach richiede consenso esplicito.
- [ ] HealthKit viene incluso nel contesto solo con doppio consenso.
- [ ] Le metriche fondamentali vengono calcolate localmente.
- [ ] Ogni risposta AI è validata contro schema e contesto.
- [ ] Insight e chat mostrano dati osservati, interpretazione e suggerimento.
- [ ] L’AI dichiara dati insufficienti quando necessario.
- [ ] I flussi AI non bloccano workout logging o analytics.
- [ ] L’utente può cancellare chat e disabilitare AI Coach.
- [ ] Le feature AI possono essere disabilitate tramite feature flag.

---

## 11. Milestone M7 — Optional MVP Features

### Obiettivo

Aggiungere le feature `Should` e `Could` selezionate senza compromettere stabilità, privacy e performance del core MVP.

### Dipendenze

M3 completata per CSV. M4 completata per visualizzazione dati. M5 completata per privacy. M6 completata se HealthKit viene usato nell’AI.

### Deliverable

- HealthKit base opzionale.
- Import CSV con preview e validazione.
- Notifiche configurabili.
- Integrazione completa nel Privacy Center.

### Task

#### HealthKit base

- [ ] Implementare `HealthKitService`.
- [ ] Verificare disponibilità HealthKit.
- [ ] Implementare richiesta autorizzazione.
- [ ] Richiedere lettura passi.
- [ ] Richiedere lettura calorie attive.
- [ ] Richiedere lettura workout.
- [ ] Richiedere lettura minuti esercizio se disponibili.
- [ ] Gestire autorizzazione negata.
- [ ] Gestire autorizzazione revocata.
- [ ] Implementare aggregazione giornaliera locale.
- [ ] Mostrare dati HealthKit opzionali Dashboard.
- [ ] Distinguere origine dati PeakLift e Apple Health.
- [ ] Implementare contesto AI HealthKit solo con doppio consenso.
- [ ] Evitare interpretazioni cliniche.

#### Import CSV

- [ ] Implementare file picker iOS.
- [ ] Limitare formati accettati a CSV.
- [ ] Implementare parser CSV robusto.
- [ ] Validare colonne obbligatorie.
- [ ] Validare campo data.
- [ ] Validare nome esercizio.
- [ ] Validare numero serie.
- [ ] Validare peso.
- [ ] Validare ripetizioni.
- [ ] Gestire unità kg/lb.
- [ ] Gestire RPE/RIR opzionali.
- [ ] Gestire note opzionali.
- [ ] Implementare mapping colonne non riconosciute.
- [ ] Implementare preview import.
- [ ] Mostrare errore con riga e motivo.
- [ ] Identificare potenziali duplicati.
- [ ] Creare `ImportBatch`.
- [ ] Richiedere conferma prima import.
- [ ] Implementare annullamento import.
- [ ] Implementare rollback atomico.
- [ ] Marcare origine `csvImport`.
- [ ] Invalidare analytics dopo import.
- [ ] Generare insight solo dopo import completato.

#### Notifiche

- [ ] Implementare richiesta consenso notifiche.
- [ ] Implementare notifica timer recupero.
- [ ] Implementare preferenze reminder workout.
- [ ] Implementare preferenze insight settimanale.
- [ ] Implementare deep link da notifica.
- [ ] Garantire disattivazione completa notifiche.
- [ ] Evitare notifiche AI non richieste o troppo frequenti.

#### Test

- [ ] Test HealthKit autorizzato.
- [ ] Test HealthKit negato.
- [ ] Test HealthKit revocato.
- [ ] Test CSV valido.
- [ ] Test CSV colonne mancanti.
- [ ] Test CSV valori non validi.
- [ ] Test CSV duplicati.
- [ ] Test rollback import.
- [ ] Test notifica timer.
- [ ] Test deep link notifica.
- [ ] UI test import preview.
- [ ] UI test HealthKit settings.

### Criteri di uscita

- [ ] HealthKit è completamente opzionale.
- [ ] CSV non modifica dati prima della conferma.
- [ ] Errori CSV identificano riga e motivo.
- [ ] I dati importati entrano correttamente in storico e analytics.
- [ ] Le notifiche sono configurabili e revocabili.

---

## 12. Milestone M8 — Quality & Beta

### Obiettivo

Stabilizzare l’app, verificare requisiti non funzionali, validare accessibilità e raccogliere feedback TestFlight.

### Dipendenze

M3–M7 completate per una beta MVP completa.

### Deliverable

- Release candidate.
- TestFlight interno.
- TestFlight esterno controllato.
- Bug critici risolti.
- Privacy e accessibilità validate.
- Osservabilità prodotto attiva.

### Task

#### Performance

- [ ] Profilare avvio app.
- [ ] Profilare autosave serie.
- [ ] Profilare scrittura SwiftData.
- [ ] Profilare query storico.
- [ ] Profilare analytics su dati 12 mesi.
- [ ] Profilare rendering grafici.
- [ ] Profilare import CSV di grandi dimensioni.
- [ ] Profilare consumo memoria.
- [ ] Profilare consumo batteria timer.
- [ ] Profilare sync CloudKit.
- [ ] Profilare latency AI.
- [ ] Eliminare operazioni pesanti dal main thread.

#### Reliability

- [ ] Testare terminazione app durante workout.
- [ ] Testare recupero draft.
- [ ] Testare modifica workout completato.
- [ ] Testare perdita rete.
- [ ] Testare rete intermittente.
- [ ] Testare account iCloud non disponibile.
- [ ] Testare conflitti CloudKit.
- [ ] Testare migrazione SwiftData.
- [ ] Testare revoca consenso AI durante sessione.
- [ ] Testare revoca HealthKit.
- [ ] Testare AI Gateway non disponibile.
- [ ] Testare rate limiting.
- [ ] Testare restore app dopo aggiornamento.

#### Accessibility

- [ ] Testare Dynamic Type standard.
- [ ] Testare Dynamic Type grande.
- [ ] Testare Accessibility Extra Large.
- [ ] Testare VoiceOver Dashboard.
- [ ] Testare VoiceOver Workout.
- [ ] Testare VoiceOver Analytics.
- [ ] Testare VoiceOver Coach.
- [ ] Testare VoiceOver Profile.
- [ ] Testare contrasto Light Mode.
- [ ] Testare contrasto Dark Mode.
- [ ] Testare Reduce Motion.
- [ ] Testare touch target.
- [ ] Testare grafici con alternativa testuale.
- [ ] Testare feedback non basato solo su colori.

#### Privacy & security

- [ ] Eseguire security review client iOS.
- [ ] Eseguire security review AI Gateway.
- [ ] Eseguire secret scan finale.
- [ ] Verificare Keychain.
- [ ] Verificare TLS.
- [ ] Verificare privacy manifest.
- [ ] Verificare privacy nutrition labels.
- [ ] Verificare consenso AI.
- [ ] Verificare consenso HealthKit.
- [ ] Verificare data minimization AI.
- [ ] Verificare cancellazione chat.
- [ ] Verificare export.
- [ ] Verificare eliminazione account.
- [ ] Verificare log redaction.
- [ ] Verificare nessun claim medico in AI e UI.

#### Observability

- [ ] Configurare crash reporting privacy-aware.
- [ ] Configurare eventi onboarding completed.
- [ ] Configurare eventi workout started.
- [ ] Configurare eventi workout completed.
- [ ] Configurare eventi dashboard viewed.
- [ ] Configurare eventi analytics viewed.
- [ ] Configurare eventi insight viewed.
- [ ] Configurare eventi insight feedback.
- [ ] Configurare eventi AI message sent.
- [ ] Configurare eventi AI response failed.
- [ ] Configurare eventi sync succeeded.
- [ ] Configurare eventi sync failed.
- [ ] Configurare eventi CSV import completed.
- [ ] Configurare eventi consent changed.
- [ ] Verificare che telemetria non includa contenuti o dati sensibili non necessari.

#### TestFlight

- [ ] Creare build TestFlight interna.
- [ ] Definire checklist QA manuale.
- [ ] Definire scenari primo workout.
- [ ] Definire scenari workout offline.
- [ ] Definire scenari sync multi-device.
- [ ] Definire scenari analytics.
- [ ] Definire scenari AI Coach.
- [ ] Definire scenari HealthKit.
- [ ] Definire scenari import CSV.
- [ ] Definire scenari privacy.
- [ ] Reclutare beta tester principianti.
- [ ] Reclutare beta tester intermedi.
- [ ] Reclutare beta tester avanzati.
- [ ] Raccogliere feedback qualitativo.
- [ ] Raccogliere crash e dati prodotto.
- [ ] Triagiare bug.
- [ ] Risolvere blocker e critical.
- [ ] Eseguire regression suite.
- [ ] Preparare release candidate.

### Criteri di uscita

- [ ] Nessun bug blocker aperto.
- [ ] Nessun bug critical relativo a perdita dati, workout, sync, privacy o sicurezza.
- [ ] I flussi core sono validati su dispositivi reali.
- [ ] Accessibilità core validata.
- [ ] AI Coach ha fallback e guardrail verificati.
- [ ] TestFlight esterno ha prodotto feedback utilizzabile.
- [ ] La release candidate soddisfa Definition of Done MVP.

---

## 13. Milestone M9 — App Store Launch

### Obiettivo

Pubblicare PeakLift 1.0.0, monitorare l’adozione e garantire capacità di intervento rapido.

### Dipendenze

M8 completata.

### Deliverable

- App pubblicata su App Store.
- Monitoraggio produzione attivo.
- Piano rollback e hotfix operativo.
- Backlog post-launch prioritizzato.

### Task

#### Release preparation

- [ ] Definire versione `1.0.0`.
- [ ] Aggiornare build number.
- [ ] Congelare scope MVP.
- [ ] Preparare release notes.
- [ ] Verificare configurazione Production.
- [ ] Verificare CloudKit Production schema.
- [ ] Verificare AI Gateway Production.
- [ ] Verificare rate limit produzione.
- [ ] Verificare feature flag.
- [ ] Eseguire smoke test release build.
- [ ] Eseguire regression test finale.
- [ ] Eseguire test dispositivi reali.

#### App Store assets

- [ ] Preparare app icon.
- [ ] Preparare screenshot iPhone.
- [ ] Preparare descrizione App Store.
- [ ] Preparare subtitle.
- [ ] Preparare keyword.
- [ ] Preparare URL supporto.
- [ ] Preparare URL privacy policy.
- [ ] Preparare termini di utilizzo.
- [ ] Compilare privacy nutrition labels.
- [ ] Compilare informazioni HealthKit.
- [ ] Compilare informazioni AI.
- [ ] Preparare note per App Review.
- [ ] Verificare assenza claim medici o garanzie risultato.

#### Go-live

- [ ] Inviare build a App Review.
- [ ] Monitorare stato App Review.
- [ ] Preparare risposta a eventuali richieste Apple.
- [ ] Pubblicare release.
- [ ] Monitorare crash rate.
- [ ] Monitorare AI error rate.
- [ ] Monitorare CloudKit error rate.
- [ ] Monitorare sync failure rate.
- [ ] Monitorare performance avvio app.
- [ ] Monitorare feedback App Store.
- [ ] Monitorare opt-out AI e HealthKit.
- [ ] Attivare hotfix process per bug critici.

#### Post-launch

- [ ] Analizzare completamento onboarding.
- [ ] Analizzare attivazione primo workout.
- [ ] Analizzare workout settimanali per utente attivo.
- [ ] Analizzare retention D7.
- [ ] Analizzare retention D30.
- [ ] Analizzare utilizzo Dashboard.
- [ ] Analizzare utilizzo Analytics.
- [ ] Analizzare utilizzo AI Coach.
- [ ] Analizzare feedback insight.
- [ ] Analizzare import CSV.
- [ ] Analizzare errori sync.
- [ ] Analizzare errori AI.
- [ ] Prioritizzare backlog V1.1.
- [ ] Decidere feature V2 da avviare.

### Criteri di uscita

- [ ] PeakLift 1.0.0 è disponibile su App Store.
- [ ] Crash reporting e monitoraggio sono attivi.
- [ ] È disponibile un processo hotfix.
- [ ] I dati prodotto vengono raccolti nel rispetto delle preferenze privacy.
- [ ] Esiste un backlog post-launch basato su evidenze.

---

## 14. Sequenza consigliata

```text
M0 — Product & Technical Inception
    ↓
M1 — App Foundation
    ↓
M2 — Identity & Onboarding
    ↓
M3 — Workout Core
    ↓
M4 — History & Analytics
    ↓
M5 — Cloud & Privacy
    ↓
M6 — AI Coach
    ↓
M7 — Optional MVP Features
    ↓
M8 — Quality & Beta
    ↓
M9 — App Store Launch
```

---

## 15. Lavori paralleli

| Stream | Avvio | Dipendenze | Output |
|---|---|---|---|
| Design System | M0 | Nessuna | Componenti, token e schermate validate |
| CI/CD | M0 | Repository | Pipeline build, lint, test e archive |
| CloudKit schema | M1 | Data model stabile | Private database e record mapping |
| AI Gateway | M0 | Contratti API | Gateway staging, sicurezza e provider adapter |
| Test automation | M1 | Feature progressive | Unit, integration e UI test |
| Privacy review | M0 | Data flow | Policy, consensi e App Store labels |
| Catalogo esercizi | M0 | Data model | Dataset iniziale e fixture |
| Observability | M5 | Event taxonomy | Crash, errori e metriche prodotto |
| TestFlight preparation | M7 | Core MVP | Beta program e feedback loop |

---

## 16. Dipendenze critiche

| Feature | Dipende da | Rischio se ritardata |
|---|---|---|
| Workout logging | SwiftData, domain model, design system | Blocca il valore core MVP |
| Analytics | Workout completati e catalogo muscoli | Dati senza interpretazione |
| AI Coach | Analytics, consensi, AI Gateway | Rischio coaching non grounded |
| CloudKit | Modello dati stabile e sync policy | Rischio perdita o conflitto dati |
| HealthKit | Privacy, profilo e Dashboard | Rischio consenso incompleto |
| Import CSV | Parser, repository workout, analytics | Rischio import parziale o duplicati |
| Export | Privacy Center e modello dati | Rischio non conformità privacy |
| App Store | QA, policy, asset e ambienti production | Rischio ritardo rilascio |

---

## 17. Rischi e mitigazioni

| Rischio | Impatto | Mitigazione |
|---|---|---|
| Logging lento o fragile | Alto | Priorità a M3, autosave, test crash recovery |
| Conflitti CloudKit | Alto | UUID stabili, sync idempotente, soft delete e merge |
| Hallucination AI | Alto | Metriche locali, schema validation, grounding e fallback |
| Esposizione API key | Alto | Gateway server-side, secret management e security scan |
| Privacy HealthKit | Alto | Doppio consenso, dati aggregati, minimizzazione |
| Scope eccessivo | Alto | Feature Must prima, Should solo dopo core stabile |
| Analytics errate | Alto | Unit test metriche, fixture e versioning calcoli |
| UI poco accessibile | Medio-alto | Dynamic Type, VoiceOver e contrasto come quality gate |
| Costi AI elevati | Medio | Cache, batching, routing modello e contesto ridotto |
| Import CSV complesso | Medio | Mapping guidato, preview e rollback atomico |
| Bassa fiducia AI | Medio | Spiegabilità, dati osservati, confidenza e feedback |
| Feedback beta insufficiente | Medio | Segmentazione tester e scenari guidati |

---

## 18. Quality Gates

| Gate | Requisito |
|---|---|
| Build | Compilazione riuscita con configurazione target |
| Lint | Nessuna violazione bloccante |
| Unit test | Tutti i test core superati |
| Integration test | Persistenza, analytics, sync e AI mock verificati |
| UI test | Onboarding e workout journey superati |
| Security | Nessun segreto nel codice o bundle |
| Privacy | Consensi e data flow verificati |
| Accessibility | VoiceOver, Dynamic Type, contrasto e touch target verificati |
| Performance | Nessuna regressione critica su workout logging o storico |
| AI safety | Prompt, schema, grounding e fallback verificati |
| Manual QA | Checklist release completata |
| Product sign-off | Scope MVP e acceptance criteria approvati |

---

## 19. Definition of Done MVP

L’MVP è pronto al rilascio quando:

- [ ] Un utente può autenticarsi e completare onboarding.
- [ ] L’utente può usare l’app con AI Coach e HealthKit disattivati.
- [ ] L’utente può avviare, salvare, riprendere, completare e annullare un workout.
- [ ] Esercizi, serie, carichi, ripetizioni, RPE/RIR e note vengono salvati correttamente.
- [ ] L’autosave protegge una bozza da chiusure improvvise.
- [ ] Lo storico permette visualizzazione, ricerca, filtri, modifica, duplicazione ed eliminazione.
- [ ] Dashboard mostra workout, volume, streak, progressi e insight prioritari.
- [ ] Analytics calcola volume, frequenza, progressione, 1RM stimato e distribuzione muscolare.
- [ ] I grafici sono leggibili, accessibili e accompagnati da descrizioni testuali.
- [ ] Insight locali e AI dichiarano i limiti dei dati.
- [ ] AI Coach usa solo dati autorizzati e non espone API key.
- [ ] Le risposte AI distinguono dati osservati, interpretazione e suggerimento.
- [ ] I guardrail AI intercettano richieste mediche o potenzialmente pericolose.
- [ ] CloudKit sincronizza dati in modo resiliente senza bloccare l’uso offline.
- [ ] HealthKit è opzionale e richiede consenso esplicito.
- [ ] CSV import include validazione, preview, conferma, duplicati e rollback.
- [ ] Privacy Center permette gestione consensi, cancellazione chat, export ed eliminazione account.
- [ ] UI supporta Dark Mode, Dynamic Type, VoiceOver e Reduce Motion nei flussi core.
- [ ] CI/CD esegue build, lint, test e security scan.
- [ ] Non sono presenti bug bloccanti relativi a perdita dati, workout logging, privacy, AI safety o sincronizzazione.