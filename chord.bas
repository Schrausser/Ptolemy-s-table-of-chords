! //////////////////////////////////////////////////////////////////////////////////////////////
! // Ptolemy's Chord Lengths                                                                  //
! // Dietmar Schrausser, 2023                                                                 //
! //
_name$="CHORDs"
_ver$="v1.5
! //
INCLUDE strg.inc
GR.OPEN 255,255,255,255,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2
CONSOLE.TITLE _name$
st:
INPUT "d=...",d,120
r=d/2
tx=mx+mx*(0/4)                      % // initial x position //
ty=my-mx*(4/4)                      % // initial y position //
DO
 GR.CLS
 GR.COLOR 255,0,0,0,1
 GR.TEXT.SIZE sx/25
 GR.TEXT.ALIGN 3
 GR.TEXT.DRAW txt,sx-sx/20,sy/20,"d:"+FORMAT$("###.#",r*2)+"
 GR.COLOR 255,255,0,0,1
 GR.TEXT.DRAW txt,sx-sx/20,sy-sy/20,"Ptolemy's Chord Lengths"
 GR.TEXT.SIZE sx/30
 GR.TEXT.ALIGN 1
 GR.COLOR 255,0,0,0,1
 GR.TEXT.DRAW txt,sx/20,sy-sy/20,"x:"+INT$(tx-mx)+" y:"+INT$(-(ty-my))
 GR.COLOR 255,255,150,0,1
 GR.TEXT.DRAW txt,sx/20,sy/20,"a:"+FORMAT$("###.###",a*r)+" b:"+FORMAT$("###.###",-b*r)
 GR.COLOR 255,255,0,0,1
 GR.TEXT.ALIGN 2
 GR.TEXT.DRAW txt,mx,sy/8,"chord:"+FORMAT$("###.###",c*r)
 GR.TEXT.SIZE sx/25
 GR.TEXT.DRAW txt,mx,sy/8+sy/20,hex$
 GR.TEXT.SIZE sx/30
 GR.COLOR 255,0,0,255,1
 GR.TEXT.DRAW txt,mx,sy-sy/5,"arc:"+FORMAT$("###.###",arc)+"°"
 GR.COLOR 255,0,0,0,0
 GR.SET.STROKE 5
 GR.LINE ln, mx,my,tx,ty % //
 GR.SET.STROKE 4
 GR.LINE ln, mx,my+3,sx,my+3
 GR.COLOR 255,150,150,150,0
 GR.SET.STROKE 1
 GR.RECT rc, mx,my,tx,ty
 GR.CIRCLE cl, mx,my,mx
 GR.LINE ln, 0,my,sx,my          % // x axis            //
 GR.LINE ln, mx,my-mx,mx,my+mx   % // y axis            //
 GR.COLOR 255,255,150,0,0
 GR.LINE ln, tx,my-1,sx,my-1
 GR.LINE ln, tx,ty,tx,my
 GR.COLOR 255,255,0,0,0
 GR.SET.STROKE 2
 GR.LINE ln, tx,ty,sx,my         % // chord             //
 GR.COLOR 255,0,0,255,0
 GR.SET.STROKE 5
 GR.ARC ac,mx-50,my-50,mx+50,my+50,0,-arc,0
 GR.TOUCH tc, tx,ty
 c0=SQR((tx-mx)^2+(ty-my)^2)     % // lengths           //
 c1=mx/c0               % // ratio to radius (mx length) //
 tx=mx+(tx-mx)*c1       % // tx to length for radius     //
 ty=my+(ty-my)*c1       % // ty to length for radius     //
 a=mx-(tx-mx)
 b=ty-my
 a=a/mx
 b=b/mx
 c=SQR((a)^2+(b)^2)             % // chord length        //
 arc=TODEGREES(ASIN(-b))        % // angle               //
 ah=INT(c*r)                    % // hex values          //
 bh=60*(c*r-ah)
 b1h=INT(bh)
 ch=60*(bh-b1h)
 hex$=FORMAT$("###",ah)+" "+FORMAT$("##",ROUND(bh,2))+" "+FORMAT$("##",ROUND(ch,2))
 IF a>1: arc=(90-arc)+90:ENDIF
 IF arc<0:arc=360+arc:ENDIF
 GR.RENDER
 GR.TOUCH2 tc2, tx2, ty2
 IF tc2
  GOTO st
 ENDIF
UNTIL 0
ONERROR: 
GOSUB fin: END
ONBACKKEY: 
GOSUB fin
END
fin:
PRINT_name$+" Ptolemy's Chord Lengths "+_ver$
PRINT"Copyright "+_cr$+" 2023 by Dietmar Gerald Schrausser"
PRINT "https://github.com/Schrausser/Ptolemy-s-table-of-chords"
RETURN
! // END //
! //