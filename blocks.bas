'function declarations
DECLARE SUB animate ()
DECLARE SUB initBlocks (blocks() AS BlockType)

'config
OPTION BASE 1
COMMON SHARED yslope, zslope, speed, deviate

'block type
TYPE BlockType
x AS SINGLE
y AS SINGLE
xs AS SINGLE
ys AS SINGLE
sz AS SINGLE
clr AS INTEGER
END TYPE

'init
RANDOMIZE TIMER
CONST blockLen = 100
DIM blocks(100) AS BlockType
initBlocks blocks()


'start
SCREEN 12
DO

'exit if esc
k$ = INKEY$
IF k$ = CHR$(27) THEN EXIT DO



LOOP
COLOR 7
SCREEN 1
SYSTEM

FOR i& = 1 TO 1000000
IF INKEY$ = CHR$(27) THEN SYSTEM
particles(INT(i& / 10) + 1, 5) = 1
particles(INT(i& / 10) + 1, 4) = i& MOD 16
'RANDOMIZE TIMER
yslope = yslope + (RND(1) * .1 - .05)
zslope = zslope + (RND(2) * .1 - .05)
animate
'SOUND 21000, .5
NEXT

SUB animate
SHARED particles(), yslope, zslope
SHARED centre(), originate()
SHARED speed, deviate

CLS
FOR i% = 1 TO maxparticles
'erase particles
'LINE (particles(i%, 1) - particles(i%, 3), particles(i%, 2) - particles(i%, 3))-(particles(i%, 1) + particles(i%, 3), particles(i%, 2) + particles(i%, 3)), 0, BF
'move particles
IF (particles(i%, 5) <> 0) THEN
particles(i%, 1) = particles(i%, 1) + speed
particles(i%, 3) = zslope * particles(i%, 1)
IF (particles(i%, 2) < centre(2)) THEN particles(i%, 2) = (yslope * particles(i%, 1)) - ((centre(3) - particles(i%, 3)) * deviate)
END IF
'draw particles
LINE (particles(i%, 1) - particles(i%, 3), particles(i%, 2) - particles(i%, 3))-(particles(i%, 1) + particles(i%, 3), particles(i%, 2) + particles(i%, 3)), particles(i%, 4), BF
NEXT

END SUB

SUB initBlocks (blocks() AS BlockType)

FOR i% = 0 TO blockLen - 1
blocks(i%).x = RND * 640
blocks(i%).y = RND * 400
blocks(i%).xs = 0
blocks(i%).ys = 0
blocks(i%).sz = 0
blocks(i%).clr = RND * 255
NEXT

END SUB

