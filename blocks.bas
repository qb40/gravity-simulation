'int pixel type
TYPE IntPixel
r AS INTEGER
G AS INTEGER
b AS INTEGER
END TYPE

'particle type
TYPE Particle
m AS SINGLE
x AS SINGLE
y AS SINGLE
vx AS SINGLE
vy AS SINGLE
ax AS SINGLE
ay AS SINGLE
sz AS SINGLE
END TYPE

'function declarations
DECLARE SUB grpPalette ()
DECLARE SUB getPalette (pal() AS IntPixel)
DECLARE SUB setPalette (pal() AS IntPixel)
DECLARE SUB mergeDust (i%, j%)
DECLARE SUB dualProcess ()
DECLARE SUB monoProcess ()
DECLARE SUB drawDust ()
DECLARE SUB initDust ()


'config
OPTION BASE 0
COMMON SHARED dustCount%, collide%, gravity!, deltaT!
COMMON SHARED density!, maxVel!, maxPos!, maxMass!


'init
RANDOMIZE TIMER
DIM SHARED dust(1000) AS Particle
DIM SHARED cam AS Particle
DIM SHARED pal(16) AS IntPixel
dustCount% = 1000
collide% = 1
gravity! = 10
deltaT! = .1
density! = 1
maxVel! = 3
maxPos! = 100
maxMass! = 1
cam.x = 10
cam.y = 0
cam.sz = .5


'start
SCREEN 12
getPalette pal()
grpPalette
initDust
DO

'exit if esc
k$ = LCASE$(INKEY$)
IF k$ = CHR$(27) THEN EXIT DO
SELECT CASE k$
CASE "q"
CLS
cam.sz = cam.sz + .1 * cam.sz
CASE "e"
CLS
cam.sz = cam.sz - .1 * cam.sz
CASE ELSE
END SELECT

monoProcess
dualProcess
'CLS
drawDust


LOOP
setPalette pal()
COLOR 7
SCREEN 1
SYSTEM

SUB drawDust
SHARED dust() AS Particle, dustCount%, collide%, cam AS Particle
SHARED gravity!, deltaT!, density!, maxVel!, maxPos!, maxMass!

FOR i% = 0 TO dustCount% - 1
'not exists?
IF dust(i%).m = 0 THEN GOTO nextdrawi

'position processing
x! = 320 + (dust(i%).x - cam.x) * cam.sz
y! = 240 + (dust(i%).y - cam.y) * cam.sz
sz! = .5 * dust(i%).sz * cam.sz

'color processing
vel! = ABS(dust(i%).vx) + ABS(dust(i%).vy)
clr% = INT(1 + (vel! / maxVel!) * 15)

'draw
LINE (x! - sz!, y! - sz!)-(x + sz!, y + sz!), clr%, BF

nextdrawi:
NEXT

END SUB

SUB dualProcess
SHARED dust() AS Particle, dustCount%, collide%, cam AS Particle
SHARED gravity!, deltaT!, density!, maxVel!, maxPos!, maxMass!

FOR i% = 0 TO dustCount% - 2
'not exists?
IF dust(i%).m = 0 THEN GOTO nextduali

FOR j% = i% + 1 TO dustCount% - 1
'not exists?
IF dust(j%).m = 0 THEN GOTO nextdualj

'gravity processing
dx! = dust(j%).x - dust(i%).x
dy! = dust(j%).y - dust(i%).y
dist! = SQR(dx! * dx! + dy! * dy!)
fld! = dist! ^ -3
fi! = fld! * dust(j%).m
fj! = fld! * dust(i%).m
dust(i%).ax = dust(i%).ax + (fi! * dx!)
dust(i%).ay = dust(i%).ay + (fi! * dy!)
dust(j%).ax = dust(j%).ax - (fj! * dx!)
dust(j%).ay = dust(j%).ay - (fj! * dy!)

'collision processing
IF collide% = 0 THEN GOTO nextdualj
IF dist! <= (dust(i%).sz + dust(j%).sz) THEN mergeDust i%, j%

nextdualj:
NEXT
nextduali:
NEXT

END SUB

SUB getPalette (pal() AS IntPixel)

OUT &H3C7, 0
FOR i% = 0 TO 15
pal(i%).r = INP(&H3C9)
pal(i%).G = INP(&H3C9)
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

SUB initDust
SHARED dust() AS Particle, dustCount%, collide%, cam AS Particle
SHARED gravity!, deltaT!, density!, maxVel!, maxPos!, maxMass!

FOR i% = 0 TO dustCount% - 1
dust(i%).m = maxMass! * RND
dust(i%).x = 2 * maxPos! * (RND - .5)
dust(i%).y = 2 * maxPos! * (RND - .5)
dust(i%).vx = 2 * maxVel! * (RND - .5)
dust(i%).vy = 2 * maxVel! * (RND - .5)
NEXT

END SUB

SUB mergeDust (i%, j%)
SHARED dust() AS Particle, dustCount%, collide%, cam AS Particle
SHARED gravity!, deltaT!, density!, maxVel!, maxPos!, maxMass!

mass! = dust(i%).m + dust(j%).m
dust(i%).x = (dust(i%).m * dust(i%).x + dust(j%).m * dust(j%).x) / mass!
dust(i%).y = (dust(i%).m * dust(i%).y + dust(j%).m * dust(j%).y) / mass!
dust(i%).vx = (dust(i%).m * dust(i%).vx + dust(j%).m * dust(j%).vx) / mass!
dust(i%).vy = (dust(i%).m * dust(i%).vy + dust(j%).m * dust(j%).vy) / mass!
dust(i%).ax = (dust(i%).m * dust(i%).ax + dust(j%).m * dust(j%).ax) / mass!
dust(i%).ay = (dust(i%).m * dust(i%).ay + dust(j%).m * dust(j%).ay) / mass!
dust(i%).m = mass!
dust(j%).m = 0

END SUB

SUB monoProcess
SHARED dust() AS Particle, dustCount%, collide%, cam AS Particle
SHARED gravity!, deltaT!, density!, maxVel!, maxPos!, maxMass!

maxVel! = 0
FOR i% = 0 TO dustCount% - 1

'movement processing
ax! = dust(i%).ax * gravity! * deltaT!
ay! = dust(i%).ay * gravity! * deltaT!
dust(i%).x = dust(i%).x + (dust(i%).vx + .5 * ax!) * deltaT!
dust(i%).y = dust(i%).y + (dust(i%).vy + .5 * ay!) * deltaT!
dust(i%).vx = dust(i%).vx + ax!
dust(i%).vy = dust(i%).vy + ay!
dust(i%).ax = 0
dust(i%).ay = 0

'max-velocity processing
vel! = ABS(dust(i%).vx) + ABS(dust(i%).vy)
IF vel! > maxVel! THEN maxVel! = vel!

'size processing
dust(i%).sz = SQR(dust(i%).m / density!)

nextmonoi:
NEXT

END SUB

SUB setPalette (pal() AS IntPixel)

OUT &H3C8, 0
FOR i% = 0 TO 15
OUT &H3C9, pal(i%).r
OUT &H3C9, pal(i%).G
OUT &H3C9, pal(i%).b
NEXT

END SUB

