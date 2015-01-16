'int pixel type
TYPE IntPixel
r AS INTEGER
g AS INTEGER
b AS INTEGER
END TYPE

'block type
TYPE Particle
x AS SINGLE
y AS SINGLE
xs AS SINGLE
ys AS SINGLE
sz AS SINGLE
clr AS INTEGER
END TYPE

'function declarations
DECLARE SUB animate ()
DECLARE SUB initDust ()
DECLARE SUB grpPalette ()
DECLARE SUB getPalette (pal() AS IntPixel)
DECLARE SUB setPalette (pal() AS IntPixel)


'config
OPTION BASE 0
COMMON SHARED dust(), camera


'init
RANDOMIZE TIMER
DIM dust(1000) AS Particle
DIM camera AS Particle


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

SUB getPalette (pal() AS IntPixel)

OUT &H3C7, 0
FOR i% = 0 TO 15
pal(i%).r = INP(&H3C9)
pal(i%).g = INP(&H3C9)
pal(i%).b = INP(&H3C9)
NEXT

END SUB

SUB grpPalette

OUT &H3C8, 0
FOR i% = 0 TO 15
OUT &H3C9, i% * 4
OUT &H3C9, i% * 4
OUT &H3C9, i% * 4
NEXT

END SUB

SUB initDust (blocks() AS BlockType)

FOR i% = 0 TO blockLen - 1
blocks(i%).x = RND * 640
blocks(i%).y = RND * 400
blocks(i%).xs = RND * 10 - 5
blocks(i%).ys = RND * 10 - 5
blocks(i%).sz = RND * 5
blocks(i%).clr = RND * 255
NEXT

END SUB

SUB setPalette (pal() AS IntPixel)

OUT &H3C8, 0
FOR i% = 0 TO 15
OUT &H3C9, pal(i%).r
OUT &H3C9, pal(i%).g
OUT &H3C9, pal(i%).b
NEXT

END SUB

