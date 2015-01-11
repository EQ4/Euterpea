-- This code was automatically generated by lhs2tex --code, from the file 
-- HSoM/Music.lhs.  (See HSoM/MakeCode.bat.)

module Euterpea.Music.Note.Music where
infixr 5 :+:, :=:
 
type Octave = Int
type Pitch = (PitchClass, Octave)
type Dur   = Rational
data PitchClass  =  Cff | Cf | C | Dff | Cs | Df | Css | D | Eff | Ds 
                 |  Ef | Fff | Dss | E | Ff | Es | F | Gff | Ess | Fs
                 |  Gf | Fss | G | Aff | Gs | Af | Gss | A | Bff | As 
                 |  Bf | Ass | B | Bs | Bss
     deriving (Show, Eq, Ord, Read, Enum, Bounded)
data Primitive a  =  Note Dur a        
                  |  Rest Dur          
     deriving (Show, Eq, Ord)
data Music a  = 
       Prim (Primitive a)               -- primitive value 
    |  Music a :+: Music a              -- sequential composition
    |  Music a :=: Music a              -- parallel composition
    |  Modify Control (Music a)         -- modifier
  deriving (Show, Eq, Ord)
data Control =
          Tempo       Rational           -- scale the tempo
       |  Transpose   AbsPitch           -- transposition
       |  Instrument  InstrumentName     -- instrument label
       |  Phrase      [PhraseAttribute]  -- phrase attributes
       |  Player      PlayerName         -- player label
       |  KeySig      PitchClass Mode    -- key signature and mode
  deriving (Show, Eq, Ord)

type PlayerName  = String
data Mode        = Major | Minor
  deriving (Show, Eq, Ord)
data InstrumentName =
     AcousticGrandPiano     | BrightAcousticPiano    | ElectricGrandPiano
  |  HonkyTonkPiano         | RhodesPiano            | ChorusedPiano
  |  Harpsichord            | Clavinet               | Celesta 
  |  Glockenspiel           | MusicBox               | Vibraphone  
  |  Marimba                | Xylophone              | TubularBells
  |  Dulcimer               | HammondOrgan           | PercussiveOrgan 
  |  RockOrgan              | ChurchOrgan            | ReedOrgan
  |  Accordion              | Harmonica              | TangoAccordion
  |  AcousticGuitarNylon    | AcousticGuitarSteel    | ElectricGuitarJazz
  |  ElectricGuitarClean    | ElectricGuitarMuted    | OverdrivenGuitar
  |  DistortionGuitar       | GuitarHarmonics        | AcousticBass
  |  ElectricBassFingered   | ElectricBassPicked     | FretlessBass
  |  SlapBass1              | SlapBass2              | SynthBass1   
  |  SynthBass2             | Violin                 | Viola  
  |  Cello                  | Contrabass             | TremoloStrings
  |  PizzicatoStrings       | OrchestralHarp         | Timpani
  |  StringEnsemble1        | StringEnsemble2        | SynthStrings1
  |  SynthStrings2          | ChoirAahs              | VoiceOohs
  |  SynthVoice             | OrchestraHit           | Trumpet
  |  Trombone               | Tuba                   | MutedTrumpet
  |  FrenchHorn             | BrassSection           | SynthBrass1
  |  SynthBrass2            | SopranoSax             | AltoSax 
  |  TenorSax               | BaritoneSax            | Oboe  
  |  Bassoon                | EnglishHorn            | Clarinet
  |  Piccolo                | Flute                  | Recorder
  |  PanFlute               | BlownBottle            | Shakuhachi
  |  Whistle                | Ocarina                | Lead1Square
  |  Lead2Sawtooth          | Lead3Calliope          | Lead4Chiff
  |  Lead5Charang           | Lead6Voice             | Lead7Fifths
  |  Lead8BassLead          | Pad1NewAge             | Pad2Warm
  |  Pad3Polysynth          | Pad4Choir              | Pad5Bowed
  |  Pad6Metallic           | Pad7Halo               | Pad8Sweep
  |  FX1Train               | FX2Soundtrack          | FX3Crystal
  |  FX4Atmosphere          | FX5Brightness          | FX6Goblins
  |  FX7Echoes              | FX8SciFi               | Sitar
  |  Banjo                  | Shamisen               | Koto
  |  Kalimba                | Bagpipe                | Fiddle 
  |  Shanai                 | TinkleBell             | Agogo  
  |  SteelDrums             | Woodblock              | TaikoDrum
  |  MelodicDrum            | SynthDrum              | ReverseCymbal
  |  GuitarFretNoise        | BreathNoise            | Seashore
  |  BirdTweet              | TelephoneRing          | Helicopter
  |  Applause               | Gunshot                | Percussion
  |  Custom String
  deriving (Show, Eq, Ord)
data PhraseAttribute  =  Dyn Dynamic
                      |  Tmp Tempo
                      |  Art Articulation
                      |  Orn Ornament
     deriving (Show, Eq, Ord)

data Dynamic  =  Accent Rational | Crescendo Rational | Diminuendo Rational
              |  StdLoudness StdLoudness | Loudness Rational
     deriving (Show, Eq, Ord)

data StdLoudness = PPP | PP | P | MP | SF | MF | NF | FF | FFF
     deriving (Show, Eq, Ord, Enum)

data Tempo = Ritardando Rational | Accelerando Rational
     deriving (Show, Eq, Ord)

data Articulation  =  Staccato Rational | Legato Rational | Slurred Rational
                   |  Tenuto | Marcato | Pedal | Fermata | FermataDown | Breath
                   |  DownBow | UpBow | Harmonic | Pizzicato | LeftPizz
                   |  BartokPizz | Swell | Wedge | Thumb | Stopped
     deriving (Show, Eq, Ord)

data Ornament  =  Trill | Mordent | InvMordent | DoubleMordent
               |  Turn | TrilledTurn | ShortTrill
               |  Arpeggio | ArpeggioUp | ArpeggioDown
               |  Instruction String | Head NoteHead
               |  DiatonicTrans Int
     deriving (Show, Eq, Ord)

data NoteHead  =  DiamondHead | SquareHead | XHead | TriangleHead
               |  TremoloHead | SlashHead | ArtHarmonic | NoHead
     deriving (Show, Eq, Ord)

note            :: Dur -> a -> Music a
note d p        = Prim (Note d p)

rest            :: Dur -> Music a
rest d          = Prim (Rest d)

tempo           :: Dur -> Music a -> Music a
tempo r m       = Modify (Tempo r) m

transpose       :: AbsPitch -> Music a -> Music a
transpose i m   = Modify (Transpose i) m

instrument      :: InstrumentName -> Music a -> Music a
instrument i m  = Modify (Instrument i) m

phrase          :: [PhraseAttribute] -> Music a -> Music a
phrase pa m     = Modify (Phrase pa) m

player          :: PlayerName -> Music a -> Music a
player pn m     = Modify (Player pn) m

keysig          :: PitchClass -> Mode -> Music a -> Music a
keysig pc mo m  = Modify (KeySig pc mo) m
cff,cf,c,cs,css,dff,df,d,ds,dss,eff,ef,e,es,ess,fff,ff,f,
  fs,fss,gff,gf,g,gs,gss,aff,af,a,as,ass,bff,bf,b,bs,bss :: 
    Octave -> Dur -> Music Pitch

cff  o d = note d (Cff,  o);  cf   o d = note d (Cf,   o)
c    o d = note d (C,    o);  cs   o d = note d (Cs,   o)
css  o d = note d (Css,  o);  dff  o d = note d (Dff,  o)
df   o d = note d (Df,   o);  d    o d = note d (D,    o)
ds   o d = note d (Ds,   o);  dss  o d = note d (Dss,  o)
eff  o d = note d (Eff,  o);  ef   o d = note d (Ef,   o)
e    o d = note d (E,    o);  es   o d = note d (Es,   o)
ess  o d = note d (Ess,  o);  fff  o d = note d (Fff,  o)
ff   o d = note d (Ff,   o);  f    o d = note d (F,    o)
fs   o d = note d (Fs,   o);  fss  o d = note d (Fss,  o)
gff  o d = note d (Gff,  o);  gf   o d = note d (Gf,   o)
g    o d = note d (G,    o);  gs   o d = note d (Gs,   o)
gss  o d = note d (Gss,  o);  aff  o d = note d (Aff,  o)
af   o d = note d (Af,   o);  a    o d = note d (A,    o)
as   o d = note d (As,   o);  ass  o d = note d (Ass,  o)
bff  o d = note d (Bff,  o);  bf   o d = note d (Bf,   o)
b    o d = note d (B,    o);  bs   o d = note d (Bs,   o)
bss  o d = note d (Bss,  o)
bn, wn, hn, qn, en, sn, tn, sfn, dwn, dhn, 
    dqn, den, dsn, dtn, ddhn, ddqn, dden :: Dur

bnr, wnr, hnr, qnr, enr, snr, tnr, sfnr, dwnr, dhnr, 
     dqnr, denr, dsnr, dtnr, ddhnr, ddqnr, ddenr :: Music Pitch

bn    = 2;     bnr    = rest bn    -- brevis rest
wn    = 1;     wnr    = rest wn    -- whole note rest
hn    = 1/2;   hnr    = rest hn    -- half note rest
qn    = 1/4;   qnr    = rest qn    -- quarter note rest
en    = 1/8;   enr    = rest en    -- eighth note rest
sn    = 1/16;  snr    = rest sn    -- sixteenth note rest
tn    = 1/32;  tnr    = rest tn    -- thirty-second note rest
sfn   = 1/64;  sfnr   = rest sfn   -- sixty-fourth note rest

dwn   = 3/2;   dwnr   = rest dwn   -- dotted whole note rest
dhn   = 3/4;   dhnr   = rest dhn   -- dotted half note rest
dqn   = 3/8;   dqnr   = rest dqn   -- dotted quarter note rest
den   = 3/16;  denr   = rest den   -- dotted eighth note rest
dsn   = 3/32;  dsnr   = rest dsn   -- dotted sixteenth note rest
dtn   = 3/64;  dtnr   = rest dtn   -- dotted thirty-second note rest

ddhn  = 7/8;   ddhnr  = rest ddhn  -- double-dotted half note rest
ddqn  = 7/16;  ddqnr  = rest ddqn  -- double-dotted quarter note rest
dden  = 7/32;  ddenr  = rest dden  -- double-dotted eighth note restt251  :: Music Pitch
t251  =  let  dMinor  = d 4 wn  :=: f 4 wn  :=: a 4 wn
              gMajor  = g 4 wn  :=: b 4 wn  :=: d 5 wn
              cMajor  = c 4 bn  :=: e 4 bn  :=: g 4 bn
         in dMinor :+: gMajor :+: cMajor
type AbsPitch = Int
absPitch           :: Pitch -> AbsPitch
absPitch (pc,oct)  = 12*oct + pcToInt pc
pcToInt     :: PitchClass -> Int
pcToInt pc  = case pc of
  Cff  -> -2;  Cf  -> -1;  C  -> 0;   Cs  -> 1;   Css  -> 2; 
  Dff  -> 0;   Df  -> 1;   D  -> 2;   Ds  -> 3;   Dss  -> 4; 
  Eff  -> 2;   Ef  -> 3;   E  -> 4;   Es  -> 5;   Ess  -> 6; 
  Fff  -> 3;   Ff  -> 4;   F  -> 5;   Fs  -> 6;   Fss  -> 7; 
  Gff  -> 5;   Gf  -> 6;   G  -> 7;   Gs  -> 8;   Gss  -> 9; 
  Aff  -> 7;   Af  -> 8;   A  -> 9;   As  -> 10;  Ass  -> 11;
  Bff  -> 9;   Bf  -> 10;  B  -> 11;  Bs  -> 12;  Bss  -> 13
pitch     :: AbsPitch -> Pitch
pitch ap  = 
    let (oct, n) = divMod ap 12
    in  ([C,Cs,D,Ds,E,F,Fs,G,Gs,A,As,B] !! n, oct)
trans      :: Int -> Pitch -> Pitch
trans i p  = pitch (absPitch p + i)
