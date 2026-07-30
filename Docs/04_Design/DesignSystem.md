# Design System Documentation

# PeakLift

> **Versione:** 1.0
> **Stato:** Draft
> **Piattaforma:** iOS
> **UI Stack:** SwiftUI, Liquid Glass, SF Symbols, Swift Charts
> **Riferimenti:** Apple Human Interface Guidelines, Dynamic Type, Dark Mode, VoiceOver
> **Obiettivo:** creare un’interfaccia premium, nativa, motivante e coerente per tracking, analytics e AI coaching.

PeakLift deve far percepire i dati di allenamento come chiari, personali e azionabili. Il sistema privilegia contenuto, gerarchia e leggibilità; Liquid Glass viene usato con misura per controlli e navigazione, non come effetto decorativo onnipresente. Apple definisce Liquid Glass come un materiale dinamico che combina proprietà ottiche del vetro e fluidità, da adottare mantenendo gerarchia, armonia e coerenza con la piattaforma.

***

## 1. Design Philosophy

### 1.1 Product personality

PeakLift deve comunicare:

- **Precisione:** dati affidabili, metriche chiare, numeri leggibili.
- **Motivazione:** progresso visibile senza tono aggressivo o colpevolizzante.
- **Tecnologia:** AI, analytics e visualizzazioni devono apparire avanzate ma comprensibili.
- **Semplicità:** l’utente deve registrare un set con il minimo sforzo possibile.
- **Qualità premium:** ogni stato, transizione e dettaglio deve sembrare intenzionale.
- **Autonomia:** l’app suggerisce, ma non impone.

L’esperienza deve evitare l’estetica “hardcore gym” eccessivamente rumorosa. Non deve usare superfici scure piene, gradienti aggressivi, badge inutili o gamification invasiva come elementi dominanti.

***

### 1.2 Principi estetici

| Principio | Applicazione |
| :-- | :-- |
| Content-first | I dati e l’azione principale hanno priorità sulla decorazione |
| Quiet confidence | Palette controllata, superfici leggere, tipografia chiara |
| Depth with purpose | Vetri, ombre e layer comunicano gerarchia, non ornamento |
| Data with warmth | Le metriche sono precise ma accompagnate da spiegazioni umane |
| Progressive disclosure | Il dato essenziale appare subito; il dettaglio è disponibile su richiesta |
| Native familiarity | Controlli, gesture, navigazione e feedback seguono le convenzioni iOS |
| Intentional motion | Le animazioni spiegano cambiamenti di stato e continuità |


***

### 1.3 Principi UX

1. **Un’azione primaria per schermata.** La Dashboard privilegia “Inizia workout”; il Coach privilegia l’invio di una domanda; Analytics privilegia la selezione di un periodo o metrica.
2. **Logging rapido sotto stress.** Durante il workout, input e conferme devono essere grandi, immediati e leggibili anche in movimento.
3. **Numeri prima, interpretazione dopo.** Una metrica mostra prima valore, unità e variazione; l’AI spiega il significato solo dove aggiunge valore.
4. **Nessun falso senso di certezza.** Insight, recovery e suggerimenti devono distinguere fatti, interpretazioni e azioni opzionali.
5. **Dati insufficienti sono uno stato valido.** Invece di grafici vuoti o raccomandazioni generiche, il sistema mostra cosa manca e come migliorare la qualità dei dati.
6. **Il controllo resta all’utente.** AI Coach, HealthKit, notifiche e condivisione dati devono essere attivabili, revocabili e comprensibili.

***

### 1.4 Emozioni desiderate

| Momento | Emozione desiderata | Risposta del design |
| :-- | :-- | :-- |
| Primo avvio | Curiosità e fiducia | Onboarding breve, linguaggio semplice, gerarchia pulita |
| In palestra | Focus e velocità | Controlli grandi, alto contrasto, pochi elementi simultanei |
| Dopo workout | Soddisfazione e chiarezza | Riepilogo pulito, metriche positive, prossimo passo |
| Analytics | Controllo e comprensione | Grafici leggibili, filtri semplici, spiegazioni contestuali |
| AI Coach | Supporto e personalizzazione | Tono calmo, struttura chiara, riferimenti ai dati reali |
| Errore o assenza dati | Sicurezza e continuità | Messaggi chiari, azioni recuperabili, nessuna colpa |


***

## 2. Visual Identity

### 2.1 Color System

La palette usa un neutro profondo e freddo come base, con un accento energetico verde-teal per azioni, progressi e stati positivi. Il colore non deve essere l’unico canale informativo: ogni stato deve includere testo, icona o forma distinta.

### Primary colors

| Token | Light Mode | Dark Mode | Utilizzo |
| :-- | :-- | :-- | :-- |
| `color.primary` | `#0B6E69` | `#5EEAD4` | CTA principali, elementi selezionati, progresso |
| `color.primaryStrong` | `#075A56` | `#99F6E4` | Pressed state, valore primario, focus |
| `color.primarySoft` | `#D7F5F1` | `#123D3A` | Sfondo selezioni, pill, badge non critici |
| `color.primaryOn` | `#FFFFFF` | `#082321` | Testo e icone sopra primary |

Il teal deve evocare precisione, benessere e tecnologia, senza richiamare eccessivamente una palette clinica o medicale.

***

### Secondary colors

| Token | Light Mode | Dark Mode | Utilizzo |
| :-- | :-- | :-- | :-- |
| `color.secondary` | `#4361EE` | `#8EA2FF` | Dati secondari, progressione, grafici |
| `color.secondarySoft` | `#E8ECFF` | `#202B5A` | Selezioni secondarie e aree grafico |
| `color.accentWarm` | `#F59E0B` | `#FBBF24` | Evidenza moderata, warning non critici |
| `color.accentViolet` | `#7C3AED` | `#C4B5FD` | AI Coach, conversazione e insight AI |

Il violet identifica l’area AI senza trasformarla in un universo visivo separato. L’utente deve percepire il Coach come parte dello stesso prodotto e non come una chat generica.

***

### Background colors

| Token | Light Mode | Dark Mode | Utilizzo |
| :-- | :-- | :-- | :-- |
| `color.background` | `#F5F7F8` | `#0A0D10` | Sfondo principale |
| `color.backgroundElevated` | `#FFFFFF` | `#10151A` | Contenuto elevato, sheet e sezioni |
| `color.backgroundGrouped` | `#EEF1F3` | `#151B21` | Gruppi e aree secondarie |
| `color.backgroundWorkout` | `#F8FAFA` | `#080B0D` | Modalità workout ad alto focus |


***

### Surface colors

| Token | Light Mode | Dark Mode | Utilizzo |
| :-- | :-- | :-- | :-- |
| `color.surface` | `#FFFFFF` | `#151A20` | Card standard non glass |
| `color.surfaceSubtle` | `#F8FAFB` | `#1C232B` | Input, righe e superfici secondarie |
| `color.surfaceSelected` | `#EAF8F6` | `#17312F` | Stato selezionato |
| `color.separator` | `#D9E0E4` | `#2A343E` | Divider e confini discreti |


***

### Semantic colors

| Stato | Token | Light Mode | Dark Mode | Utilizzo |
| :-- | :-- | :-- | :-- | :-- |
| Success | `color.success` | `#16803C` | `#4ADE80` | PR, workout completato, sincronizzazione riuscita |
| Success Soft | `color.successSoft` | `#E4F7EA` | `#173D27` | Sfondo stato positivo |
| Warning | `color.warning` | `#B45309` | `#FBBF24` | Dato incompleto, sync in attesa, attenzione moderata |
| Warning Soft | `color.warningSoft` | `#FFF4DC` | `#4A3514` | Sfondo warning |
| Error | `color.error` | `#C12B32` | `#FF8A8E` | Errore, eliminazione, sync fallita |
| Error Soft | `color.errorSoft` | `#FDE8E8` | `#4A2023` | Sfondo errore |
| Info | `color.info` | `#2563B8` | `#7DB5FF` | Informazione neutra o contestuale |


***

### Regole di contrasto

- Il testo body deve mantenere contrasto elevato contro lo sfondo.
- Il testo sopra CTA primary deve usare `color.primaryOn`.
- I grafici devono usare linee, pattern, label e tooltip oltre al colore.
- Warning ed error devono sempre includere SF Symbol e descrizione testuale.
- Il testo secondario non deve scendere sotto un contrasto leggibile in entrambe le modalità.
- Non usare testo colorato direttamente su superfici glass complesse se il contrasto non è stabile.

***

### Dark Mode

Dark Mode non è un’inversione matematica della palette Light. Deve usare profondità, superfici stratificate e testo ad alta leggibilità.

Regole:

- Evitare nero puro dominante su ogni superficie.
- Usare sfondi profondi con variazioni leggere per distinguere sezioni.
- Ridurre l’intensità delle ombre; usare più contrasto tonale che ombre scure.
- Aumentare leggermente la luminosità degli accenti teal, violet e blu.
- Verificare manualmente chart, glass material, tooltip e stati disabled.

***

## 2.2 Typography

PeakLift deve usare la tipografia di sistema Apple. `SF Pro Display` viene usata per titoli e metriche di grande dimensione; `SF Pro Text` per testi continui, descrizioni e controlli. In SwiftUI, l’implementazione deve privilegiare gli stili semantici di sistema per rispettare Dynamic Type.

### Scala tipografica

| Token | Font | Stile | Peso | Uso |
| :-- | :-- | :-- | :-- | :-- |
| `type.heroMetric` | SF Pro Display | 40 pt | Bold | Volume principale, PR, obiettivo grande |
| `type.largeTitle` | SF Pro Display | 34 pt | Bold | Titolo schermata principale |
| `type.title1` | SF Pro Display | 28 pt | Semibold | Titolo sezione primaria |
| `type.title2` | SF Pro Display | 22 pt | Semibold | Titolo card o dettaglio |
| `type.title3` | SF Pro Text | 20 pt | Semibold | Sottosezione |
| `type.headline` | SF Pro Text | 17 pt | Semibold | Titoli card, azioni |
| `type.body` | SF Pro Text | 17 pt | Regular | Corpo testo |
| `type.bodyEmphasis` | SF Pro Text | 17 pt | Medium | Corpo evidenziato |
| `type.callout` | SF Pro Text | 16 pt | Regular | Descrizioni compatte |
| `type.subheadline` | SF Pro Text | 15 pt | Regular | Metadati e label |
| `type.footnote` | SF Pro Text | 13 pt | Regular | Informazioni di supporto |
| `type.caption` | SF Pro Text | 12 pt | Medium | Label grafici, badge, timestamp |
| `type.metricSmall` | SF Pro Rounded | 20 pt | Semibold | Metriche in card compatte |
| `type.metricMedium` | SF Pro Rounded | 28 pt | Bold | Metriche card standard |

### Regole tipografiche

- Usare cifre tabulari per valori che cambiano frequentemente: timer, peso, ripetizioni, volume e percentuali.
- Usare `SF Pro Rounded` solo per metriche, score e valori motivazionali, non per body text.
- Evitare tutto maiuscolo per testi lunghi.
- Non usare più di tre pesi tipografici nella stessa schermata.
- I titoli devono essere leggibili senza dipendere da colore o icone.
- I testi AI devono restare nel range `body` o `callout` per favorire lettura e accessibilità.

***

## 2.3 Spacing System

Il sistema usa una griglia base di 4 pt. Ogni spacing deve essere un multiplo del token definito, salvo specifiche esigenze di piattaforma.


| Token | Valore | Utilizzo |
| :-- | --: | :-- |
| `space.1` | 4 pt | Micro distanza tra icona e label |
| `space.2` | 8 pt | Spacing interno compatto |
| `space.3` | 12 pt | Input row, label e valore |
| `space.4` | 16 pt | Padding card standard |
| `space.5` | 20 pt | Separazione contenuti principali |
| `space.6` | 24 pt | Padding pagina orizzontale |
| `space.7` | 32 pt | Separazione sezioni |
| `space.8` | 40 pt | Hero area e blocchi importanti |
| `space.9` | 48 pt | Spaziatura verticale ampia |
| `space.10` | 64 pt | Spazio per sezioni speciali o empty state |

### Layout

| Elemento | Regola |
| :-- | :-- |
| Padding pagina | 16 pt minimo, 20–24 pt preferibile per pagine data-heavy |
| Gap tra card | 12–16 pt |
| Gap tra sezioni | 24–32 pt |
| Altezza riga standard | Minimo 44 pt |
| Altezza CTA primaria | 50–56 pt |
| Altezza input workout | 48–56 pt |
| Dimensione minima touch | 44 × 44 pt |
| Tab bar safe area | Gestita nativamente, senza contenuti tappabili sotto la barra |


***

### Corner radius

| Token | Valore | Utilizzo |
| :-- | --: | :-- |
| `radius.xs` | 8 pt | Badge, chip, piccoli input |
| `radius.sm` | 12 pt | Row, segmented control, card compatte |
| `radius.md` | 16 pt | Card standard |
| `radius.lg` | 20 pt | MetricCard, ChartCard, sheet interni |
| `radius.xl` | 24 pt | Hero card, modal personalizzate |
| `radius.pill` | 999 pt | Pulsanti pill, filtri, progress ring label |

I radius devono restare coerenti all’interno della gerarchia: una superficie interna non deve avere un radius più ampio della superficie contenitore.

***

## 3. Liquid Glass Guidelines

Liquid Glass è una risorsa di gerarchia e profondità, non una texture da applicare ovunque. Apple raccomanda di adottare materiali e controlli della piattaforma in modo giudizioso, lasciando che contenuto e navigazione mantengano leggibilità e coerenza.[^3][^2][^1]

### 3.1 Principi

- Il glass deve stare principalmente nel layer di controllo o navigazione.
- Il contenuto analitico deve restare leggibile su superfici stabili.
- L’effetto deve adattarsi a Light e Dark Mode.
- Un layer glass deve avere un motivo funzionale: focus, transizione, controllo persistente o contesto temporaneo.
- Usare blur e traslucenza moderati; non ridurre la leggibilità.
- Le card glass non devono contenere grafici densi senza una superficie interna stabile.
- Preferire componenti e materiali di sistema dove disponibili.

***

### 3.2 Glass cards

Usare GlassCard per:

- Insight AI prioritario;
- Riepilogo hero in Dashboard;
- Overlay timer recupero;
- Floating action panel;
- Stato sync temporaneo;
- Conferme contestuali;
- Card motivazionali leggere.

Proprietà visive:

- Materiale traslucido adattivo;
- Tint minimo derivato dal semantic color, se necessario;
- Bordo sottile a contrasto adattivo;
- Ombra soffusa e poco opaca;
- Padding 16–20 pt;
- Radius `radius.lg` o `radius.xl`;
- Contenuto testuale sempre su area con contrasto verificato.

***

### 3.3 Floating panels

Usare floating panels per:

- Timer recupero persistente;
- Azione rapida durante workout;
- Filtro compatto sovrapposto a grafici;
- Composer AI fissato alla base;
- Stato sincronizzazione non bloccante.

Regole:

- Non devono coprire CTA essenziali.
- Devono rispettare safe area e keyboard avoidance.
- Devono poter essere chiusi, espansi o ridotti quando appropriato.
- Devono usare motion coerente con provenienza e destinazione.
- Devono restare pochi: massimo un floating panel dominante per schermata.

***

### 3.4 Modal views

Usare sheet o full-screen modal per:

- Creazione esercizio personalizzato;
- Filtri analytics avanzati;
- Dettaglio insight;
- Impostazioni privacy;
- Import CSV e mapping;
- Conferma completamento o cancellazione workout.

Regole:

- Preferire sheet per attività focalizzate e reversibili.
- Usare full-screen cover per workout session, onboarding o flussi che richiedono concentrazione.
- Non usare glass e blur eccessivi dentro una modal già elevata.
- Mantenere azione primaria persistente e facilmente raggiungibile.

***

### 3.5 Quando non usare Liquid Glass

Non usare glass effect per:

- Tabelle dati dense;
- Elenchi workout lunghi;
- Input numerici principali;
- Grafici complessi;
- Messaggi di errore critici;
- Superfici con molto testo;
- Card ripetute in una lista;
- Background generale dell’app;
- Stati disabled;
- Sezioni dove la trasparenza riduce contrasto o performance.

In questi casi usare `color.surface`, `color.surfaceSubtle` o superfici di sistema solide.

***

## 4. Component Library

## 4.1 GlassCard

### Scopo

Contenitore premium e contestuale per evidenziare un’informazione importante, un insight, un riepilogo o un’azione temporanea.

### Anatomia

```text
GlassCard
├── Optional leading icon
├── Eyebrow label
├── Title
├── Supporting content
├── Optional metric
└── Optional trailing action
```


### Proprietà

| Proprietà | Opzioni |
| :-- | :-- |
| Emphasis | Default, primary, AI, success, warning |
| Elevation | Low, medium, floating |
| Action | None, inline, disclosure, button |
| Icon | Optional SF Symbol |
| Content density | Compact, standard, expanded |
| Material | Adaptive system material, tinted material |

### Stati

| Stato | Trattamento |
| :-- | :-- |
| Default | Materiale glass neutro |
| Pressed | Riduzione lieve scala e aumento contrasto |
| Selected | Tint primary soft o AI soft |
| Disabled | Opacità ridotta, nessuna trasparenza eccessiva |
| Loading | Skeleton discreto o shimmer limitato |
| Error | Surface semantica error, non glass trasparente |

### Interazione

- Se l’intera card è tappabile, deve usare una sola azione chiara.
- Una card tappabile deve avere chevron o affordance visiva, se non ovvia.
- Press state: scala 0.98 per breve durata, senza rimbalzo eccessivo.
- Haptic leggero solo per azioni significative.


### Accessibilità

- L’intera card deve avere un label VoiceOver sintetico.
- Le azioni interne devono essere navigabili separatamente.
- Non usare il vetro come unico indicatore di importanza.
- Garantire contrasto del contenuto sopra il materiale.

***

## 4.2 MetricCard

### Scopo

Mostrare una metrica fitness chiave in modo immediato: volume, workout completati, serie allenanti, PR, streak, frequenza o variazione percentuale.

### Anatomia

```text
MetricCard
├── Metric label
├── Primary metric value
├── Unit
├── Trend indicator
├── Comparison label
└── Optional chart sparkline
```


### Varianti

| Variante | Utilizzo |
| :-- | :-- |
| `hero` | Volume settimanale, workout count, streak |
| `standard` | Metriche Dashboard e Analytics |
| `compact` | Griglie a due colonne |
| `trend` | Progressione o confronto periodo |
| `personalRecord` | Nuovo PR o miglioramento significativo |

### Regole visuali

- Valore principale con `type.metricMedium` o `type.heroMetric`.
- Unit sempre separata visivamente dal valore.
- Trend usa freccia, numero e label: non solo colore.
- Sparkline deve essere secondaria al valore.
- Il titolo deve chiarire metrica e intervallo: “Volume questa settimana”.


### Stati

| Stato | UI |
| :-- | :-- |
| Data available | Valore, unità, confronto e trend |
| Insufficient data | Placeholder esplicativo e CTA |
| Loading | Skeleton struttura card |
| Error | Stato leggibile con retry, se applicabile |

### Accessibilità

Esempio VoiceOver:

> Volume questa settimana, 12.450 chilogrammi, aumento del 8 percento rispetto alla settimana precedente.

***

## 4.3 ProgressRing

### Scopo

Visualizzare avanzamento verso un obiettivo, recovery score non clinico, frequenza settimanale o completamento di una routine.

### Varianti

| Variante | Utilizzo |
| :-- | :-- |
| `goal` | Workout completati su obiettivo settimanale |
| `recoveryContext` | Indicatore contestuale non medico |
| `consistency` | Streak o costanza |
| `completion` | Stato avanzamento sessione |

### Regole

- Il ring non deve essere l’unico modo per conoscere il valore.
- Mostrare sempre percentuale, valore corrente e target.
- Spessore minimo visibile: 8 pt.
- Dimensioni consigliate: 72 pt compatto, 112 pt standard, 160 pt hero.
- Usare una sola accent color per ring, salvo segmenti semanticamente distinti.


### Stati

| Stato | Trattamento |
| :-- | :-- |
| In progress | Primary o secondary |
| Completed | Success con simbolo check |
| At risk | Warning con testo contestuale |
| Insufficient data | Track neutro e spiegazione |
| Error | Non usare ring; mostrare messaggio |

### Accessibilità

Esempio VoiceOver:

> Obiettivo settimanale, 3 workout su 4 completati, 75 percento.

***

## 4.4 InsightCard

### Scopo

Mostrare un insight generato da regole locali o AI Coach, sempre con dati osservati, interpretazione, periodo e azione suggerita.

### Anatomia

```text
InsightCard
├── Category icon
├── Insight category label
├── Insight title
├── Summary
├── Supporting metric or period
├── Confidence label
├── Suggested action
└── Feedback actions
```


### Categorie

| Categoria | Colore | SF Symbol suggerito |
| :-- | :-- | :-- |
| Progressione | Secondary | `chart.line.uptrend.xyaxis` |
| Volume | Primary | `scalemass` |
| Costanza | Success | `flame` |
| Equilibrio | Warning | `figure.strengthtraining.traditional` |
| Dati insufficienti | Info | `info.circle` |
| AI Coach | Accent Violet | `sparkles` |

### Comportamento

- L’insight deve essere espandibile per mostrare dati osservati.
- Il dettaglio deve distinguere “Hai registrato”, “Interpretazione”, “Puoi considerare”.
- Le azioni feedback includono utile, non utile, salva e ignora.
- Non usare tono prescrittivo o medico.
- Gli insight scaduti devono essere rimossi dalla priorità Dashboard o mostrati come storico.


### Animazione

- Inserimento: fade + slide verticale da 8–12 pt.
- Espansione: transizione altezza morbida, senza spostamenti improvvisi.
- Feedback positivo: haptic leggero e conferma discreta.


### Accessibilità

- Categoria, periodo e confidenza devono essere leggibili.
- La confidenza deve usare testo, non solo icona.
- Le azioni feedback devono avere label esplicite.

***

## 4.5 ChartCard

### Scopo

Contenere grafici Swift Charts con contesto, selettori e interpretazione leggibile.

### Anatomia

```text
ChartCard
├── Header
│   ├── Chart title
│   ├── Date range
│   └── Optional action
├── Primary metric summary
├── Chart canvas
├── Legend or selected-point detail
└── Text interpretation
```


### Tipologie supportate

| Grafico | Utilizzo |
| :-- | :-- |
| Line chart | Volume o 1RM stimato nel tempo |
| Bar chart | Serie o volume per workout |
| Area chart | Trend volume aggregato |
| Horizontal bar | Distribuzione muscolare |
| Dot chart | Performance per set |
| Stacked bar | Volume per gruppo muscolare |
| Sparkline | Trend sintetico in MetricCard |

Swift Charts supporta localizzazione e accessibilità; ogni grafico deve comunque essere accompagnato da un riepilogo testuale che renda disponibili insight e valori principali senza richiedere lettura visiva.[^4]

### Regole

- Non mostrare più di due serie visive principali nello stesso grafico mobile.
- Usare tooltip su tap o drag, non hover-only.
- Aggiungere label al punto selezionato.
- Non usare gradienti decorativi nel plot area se riducono contrasto.
- Il grafico deve avere altezza minima di 180 pt.
- Il titolo deve includere metrica e periodo.
- Un grafico senza dati deve diventare empty state, non una griglia vuota.


### Accessibilità

Ogni ChartCard deve esporre:

- Titolo;
- Intervallo;
- Valore minimo e massimo;
- Trend;
- Punto selezionato, se presente;
- Link ai workout origine quando disponibile.

***

## 4.6 MuscleHeatmap

### Scopo

Visualizzare distribuzione di serie o volume tra gruppi muscolari senza presentarla come diagnosi di squilibrio fisico.

### Struttura

```text
MuscleHeatmap
├── Toggle: Front / Back
├── Body silhouette
├── Color intensity overlay
├── Legend
├── Selected muscle summary
└── Explanation text
```


### Regole

- La heatmap rappresenta volume o serie registrate, non attivazione muscolare reale.
- Ogni muscolo deve essere selezionabile.
- Il colore deve essere accompagnato da livello testuale: basso, medio, alto.
- Supportare una modalità alternativa a elenco/bar chart per utenti che non vogliono usare la silhouette.
- La legenda deve indicare unità e intervallo analizzato.
- Non usare rosso per “muscolo trascurato” salvo stato di errore reale; preferire neutrali e warning moderati.


### Accessibilità

- Fornire una tabella o lista equivalente.
- VoiceOver deve leggere gruppo muscolare, volume, numero serie e periodo.
- La silhouette non deve essere l’unica rappresentazione informativa.

***

## 4.7 AIMessageBubble

### Scopo

Visualizzare conversazioni con AI Coach mantenendo chiari origine del messaggio, dati osservati e limiti del suggerimento.

### Varianti

| Variante | Allineamento | Trattamento |
| :-- | :-- | :-- |
| User | Trailing | Surface primary soft o neutral selected |
| Coach | Leading | Surface standard o AI soft |
| System | Center | Caption neutra |
| Safety notice | Full width | Warning soft o info soft |
| Loading | Leading | Skeleton o indicatore discreto |

### Anatomia coach message

```text
AIMessageBubble
├── Coach avatar or sparkles icon
├── Message body
├── Optional observed facts block
├── Optional suggested action
├── Optional safety notice
├── Period reference
└── Timestamp
```


### Regole

- Le risposte AI non devono essere rappresentate come verità assoluta.
- Usare sezioni chiare quando il contenuto è articolato: “Dati osservati”, “Interpretazione”, “Prossimo passo”.
- Periodo e workout analizzati devono essere linkabili se disponibili.
- Evitare bubble troppo larghe: max circa 85% della larghezza disponibile.
- Il composer deve restare sopra tastiera e safe area.


### Accessibilità

- Leggere “Tu” o “Coach” prima del contenuto.
- Non affidarsi a posizione sinistra/destra per distinguere il mittente.
- Le citazioni dati devono essere accessibili come elementi separati, se interattive.

***

## 4.8 Buttons

### Primary Button

**Uso:** azione principale e irrevocabile solo dopo conferma appropriata.

Esempi:

- Inizia workout
- Completa workout
- Salva esercizio
- Continua onboarding
- Importa dati confermati

| Proprietà | Specifica |
| :-- | :-- |
| Altezza | 50–56 pt |
| Colore | `color.primary` |
| Testo | `type.headline`, `color.primaryOn` |
| Radius | `radius.lg` o pill in contesti compatti |
| Icona | SF Symbol opzionale, leading |
| Stato pressed | Scala 0.98 e tint più scuro |
| Disabled | Surface neutral, contrasto leggibile, no azione |


***

### Secondary Button

**Uso:** azione utile ma non dominante.

Esempi:

- Visualizza analytics
- Modifica workout
- Riprova sync
- Scopri di più
- Salva insight

| Proprietà | Specifica |
| :-- | :-- |
| Stile | Tinted, bordered o glass controllato |
| Colore | Primary soft o surface selected |
| Testo | `type.headline` |
| Icona | Opzionale |
| Stato pressed | Riduzione lieve opacità o scala |
| Stato disabled | Contrastato ma non attivo |


***

### Destructive Button

**Uso:** eliminazione, annullamento irreversibile o revoca.

Esempi:

- Elimina workout
- Elimina conversazione
- Elimina account
- Scarta bozza

Regole:

- Non usare destructive come CTA primaria in una pagina generale.
- Richiedere conferma per eliminazioni permanenti.
- Usare `color.error` e icona esplicita, ad esempio `trash`.
- In alert o sheet, posizionare l’azione distruttiva in modo coerente con i pattern iOS.

***

### Icon Button

**Uso:** azioni leggere e frequenti.

Esempi:

- Aggiungi set
- Modifica
- Filtra
- Condividi
- Avvia timer
- Chiudi sheet

Regole:

- Touch target minimo 44 × 44 pt.
- Usare SF Symbols riconoscibili.
- Aggiungere label VoiceOver esplicita.
- Non usare icone senza label visiva se l’azione è ambigua.

***

## 5. Navigation Design

### 5.1 Tab Bar

La navigazione principale usa una tab bar a quattro sezioni:


| Tab | Icona SF Symbol | Finalità |
| :-- | :-- | :-- |
| Dashboard | `house` | Stato attuale, insight e accesso rapido |
| Analytics | `chart.xyaxis.line` | Progressi, volume, frequenza e muscoli |
| Coach | `sparkles` | AI Coach, chat e insight salvati |
| Profile | `person.crop.circle` | Preferenze, privacy, HealthKit e account |

Durante un workout attivo, l’app deve mostrare una superficie dedicata full-screen o una route prioritaria. Il workout non deve essere trattato come una tab ordinaria, perché richiede concentrazione, autosave e accesso costante a timer e set.

***

### 5.2 Gerarchia navigazione

```text
App Root
├── Onboarding
│   ├── Welcome
│   ├── Goal
│   ├── Experience
│   ├── Unit
│   ├── Consent
│   └── Dashboard
│
├── Dashboard
│   ├── Insight Detail
│   ├── Workout Summary
│   ├── Workout History
│   └── Start Workout
│
├── Analytics
│   ├── Metric Detail
│   ├── Exercise Progress
│   ├── Muscle Balance
│   └── Workout Source Detail
│
├── Coach
│   ├── Conversation Detail
│   ├── Insight Detail
│   └── Privacy / AI Consent
│
└── Profile
    ├── Preferences
    ├── HealthKit
    ├── Privacy Center
    ├── Export Data
    └── Delete Account
```


***

### 5.3 Dashboard

La Dashboard deve rispondere a tre domande:

1. **Come sto andando?**
2. **Cosa conta oggi?**
3. **Qual è la prossima azione più utile?**

Ordine consigliato:

```text
Dashboard
├── Saluto e data
├── Hero action: Inizia workout
├── Insight prioritario
├── Metriche settimana
├── Progresso esercizio rilevante
├── Ultimo workout
├── Stato attività o HealthKit opzionale
└── Accesso ad analytics
```


***

### 5.4 Analytics

L’area Analytics deve privilegiare esplorazione guidata invece di mostrare tutti i grafici contemporaneamente.

```text
Analytics
├── Date range selector
├── Summary metrics
├── Volume trend
├── Exercise progress
├── Muscle balance
├── Workout frequency
└── Metric explanation
```


***

### 5.5 Coach

```text
Coach
├── AI consent state
├── Insight priority card
├── Suggested questions
├── Conversation history
├── Message composer
└── Safety / data disclaimer
```

Se AI Coach è disattivato, la schermata deve mostrare cosa offre la funzione, quali dati usa e una CTA non coercitiva per attivarla.

***

### 5.6 Profile

```text
Profile
├── User identity and goal
├── Preferences
├── Units and localization
├── HealthKit
├── Privacy center
├── Notifications
├── Export data
├── Delete account
└── App information
```


***

## 6. Animation Guidelines

### 6.1 Principi motion

Le animazioni devono:

- Rendere chiari i cambiamenti di stato;
- Confermare azioni riuscite;
- Stabilire relazione tra origine e destinazione;
- Ridurre percezione di attesa;
- Non ostacolare input rapidi in palestra;
- Rispettare `Reduce Motion`.

Non devono:

- Essere decorative senza scopo;
- Ritardare la registrazione di una serie;
- Usare bounce eccessivo;
- Trasformare dati importanti in elementi instabili;
- Distrarre durante workout.

***

### 6.2 Timing tokens

| Token | Durata | Curva | Uso |
| :-- | --: | :-- | :-- |
| `motion.instant` | 100 ms | Ease out | Press feedback, micro cambio stato |
| `motion.fast` | 180 ms | Ease in out | Toggle, badge, chip |
| `motion.standard` | 250 ms | Smooth spring | Card expansion, sheet content |
| `motion.emphasis` | 350 ms | Gentle spring | Hero transition, completion feedback |
| `motion.slow` | 500 ms | Ease in out | Grafici iniziali, solo se utile |
| `motion.loadingPulse` | 1.2 s | Repeating ease in out | Skeleton discreto |


***

### 6.3 Spring guidelines

| Scenario | Response | Damping | Note |
| :-- | --: | --: | :-- |
| Button press | Rapida | Alta | Nessun effetto giocoso |
| Card expand | Media | Media-alta | Mantiene leggibilità |
| Bottom sheet | Media | Media | Coerente con sistema |
| Workout completion | Media | Media-alta | Feedback soddisfacente ma sobrio |
| Progress ring | Lenta | Alta | Evitare rimbalzo sul dato |


***

### 6.4 Micro-interazioni

| Azione | Feedback |
| :-- | :-- |
| Serie completata | Haptic leggero, check state, aggiornamento volume |
| Nuovo PR | Haptic success, accento success breve, card celebrativa discreta |
| Timer avviato | Countdown transizione, haptic leggero |
| Timer concluso | Notifica locale e haptic appropriato |
| Insight salvato | Icona bookmark animata leggermente |
| Sync completata | Stato passa da pending a synced senza overlay invasivo |
| Errore input | Shake ridotto o bordo semantico, con testo esplicativo |
| Cambio periodo analytics | Crossfade o aggiornamento progressivo grafico |


***

### 6.5 Loading states

| Contesto | Pattern |
| :-- | :-- |
| Dashboard iniziale | Skeleton card per metriche |
| Grafici | Placeholder asse e shimmer molto leggero |
| AI Coach | Typing indicator o bubble skeleton |
| Import CSV | Progress state con percentuale o step |
| Sync | Indicatore discreto, mai bloccare workout |
| Salvataggio serie | Feedback istantaneo, nessun loader visibile salvo errore |


***

### 6.6 Reduce Motion

Con Reduce Motion attivo:

- Sostituire spring e scale con dissolve breve.
- Disabilitare parallax, blur animati e trasformazioni 3D.
- Mostrare aggiornamenti chart senza animazioni elaborate.
- Conservare solo feedback indispensabili: opacità, colore, testo e haptic appropriato.

***

## 7. Accessibility

### 7.1 Dynamic Type

- Usare stili testuali semantici di sistema.
- Non fissare dimensioni di testo per contenuto essenziale.
- Consentire alle card di aumentare in altezza.
- Evitare layout a due colonne per informazioni necessarie a dimensioni grandi.
- Le metriche grandi possono ridursi leggermente solo se il valore resta leggibile; non troncare numeri critici.
- Testare almeno dimensioni standard, extra large e accessibility extra extra extra large.

***

### 7.2 VoiceOver

Ogni componente deve esporre:

- Ruolo;
- Label;
- Valore;
- Stato;
- Azione disponibile;
- Contesto temporale, se rilevante.

Esempi:


| Componente | Label VoiceOver |
| :-- | :-- |
| MetricCard | “Volume questa settimana, 12.450 chilogrammi, aumento dell’8 percento” |
| ProgressRing | “Obiettivo allenamenti, 3 su 4 completati, 75 percento” |
| InsightCard | “Insight: volume petto aumentato. Periodo: ultimi 30 giorni. Doppio tocco per dettagli” |
| Serie workout | “Serie 2, 80 chilogrammi, 8 ripetizioni, completata” |
| ChartCard | “Progressione panca piana, ultimi 90 giorni. Trend in aumento da 75 a 82 chilogrammi” |
| AI message | “Coach. Dati osservati: …” |


***

### 7.3 Touch targets

- Target minimo: 44 × 44 pt.
- I controlli workout più frequenti devono preferire 48–56 pt.
- Non posizionare azioni destructive vicino ad azioni primary senza separazione.
- Le icone isolate devono avere area tappabile più grande dell’icona visiva.
- Le righe tappabili devono mostrare affordance coerente.

***

### 7.4 Contrasto e colore

- Non comunicare progresso, errore o completamento solo tramite colore.
- Usare icona, testo, pattern o forma aggiuntiva.
- Verificare contrasto in Light e Dark Mode.
- Verificare contrasto sopra materiali Liquid Glass.
- Evitare testo piccolo su gradienti o immagini.
- Non usare placeholder troppo chiari da risultare invisibili.

***

### 7.5 Grafici accessibili

- Ogni grafico deve avere riepilogo testuale.
- Le serie devono usare differenze oltre il colore: tratteggio, simbolo punto, spessore o label.
- Tooltip devono essere navigabili.
- I filtri devono esporre valore selezionato.
- La heatmap deve offrire una vista alternativa elenco/bar chart.

***

## 8. Design Tokens

### 8.1 Color tokens

```text
color.primary
color.primaryStrong
color.primarySoft
color.primaryOn

color.secondary
color.secondarySoft
color.accentWarm
color.accentViolet

color.background
color.backgroundElevated
color.backgroundGrouped
color.backgroundWorkout

color.surface
color.surfaceSubtle
color.surfaceSelected
color.separator

color.success
color.successSoft
color.warning
color.warningSoft
color.error
color.errorSoft
color.info
```


***

### 8.2 Typography tokens

```text
type.heroMetric
type.largeTitle
type.title1
type.title2
type.title3
type.headline
type.body
type.bodyEmphasis
type.callout
type.subheadline
type.footnote
type.caption
type.metricSmall
type.metricMedium
```


***

### 8.3 Spacing tokens

```text
space.1 = 4
space.2 = 8
space.3 = 12
space.4 = 16
space.5 = 20
space.6 = 24
space.7 = 32
space.8 = 40
space.9 = 48
space.10 = 64
```


***

### 8.4 Radius tokens

```text
radius.xs = 8
radius.sm = 12
radius.md = 16
radius.lg = 20
radius.xl = 24
radius.pill = 999
```


***

### 8.5 Shadow tokens

| Token | Opacità | Blur | Offset | Utilizzo |
| :-- | --: | --: | --: | :-- |
| `shadow.none` | 0 | 0 | 0 | Superfici flat |
| `shadow.subtle` | 0.06 | 8 | 2 | Card standard Light Mode |
| `shadow.card` | 0.10 | 16 | 6 | Card elevate e metriche hero |
| `shadow.floating` | 0.16 | 28 | 12 | Floating panel, timer, modal custom |
| `shadow.glass` | 0.08 | 20 | 8 | GlassCard e layer traslucidi |

In Dark Mode le ombre devono essere meno pronunciate; preferire bordi sottili e differenze di elevazione tonale.

***

### 8.6 Motion tokens

```text
motion.instant = 100ms
motion.fast = 180ms
motion.standard = 250ms
motion.emphasis = 350ms
motion.slow = 500ms
motion.loadingPulse = 1200ms
```


***

### 8.7 Icon tokens

| Contesto | Regola |
| :-- | :-- |
| Navigazione | SF Symbols filled per tab selezionata, regular per tab inattiva |
| Azioni | Preferire simboli Apple standard e semanticamente noti |
| Success | `checkmark.circle.fill` |
| Warning | `exclamationmark.triangle.fill` |
| Error | `xmark.octagon.fill` o `exclamationmark.circle.fill` |
| AI Coach | `sparkles` |
| Workout | `figure.strengthtraining.traditional` |
| Progressione | `chart.line.uptrend.xyaxis` |
| Analytics | `chart.xyaxis.line` |
| Profile | `person.crop.circle` |


***

## 9. Quality Checklist

Prima di considerare una schermata pronta, verificare:

- [ ] L’azione primaria è evidente.
- [ ] La gerarchia può essere compresa in pochi secondi.
- [ ] Il contenuto resta leggibile in Light e Dark Mode.
- [ ] I target touch rispettano la dimensione minima.
- [ ] Dynamic Type non tronca informazioni essenziali.
- [ ] VoiceOver legge valore, stato e azione.
- [ ] Il colore non è l’unico indicatore semantico.
- [ ] I grafici hanno una descrizione alternativa.
- [ ] Glass e blur sono funzionali e non decorativi.
- [ ] Le animazioni migliorano comprensione, non rallentano l’utente.
- [ ] Gli stati empty, loading, error e offline sono progettati.
- [ ] Le superfici usano token, non valori visivi arbitrari.
- [ ] Il componente è coerente con componenti analoghi nell’app.
- [ ] Il contenuto AI distingue dati, interpretazione e suggerimento.