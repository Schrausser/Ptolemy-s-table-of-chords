! //////////////////////////////////////////////////////////////////////////////////////////////
! // Ptolemy's Chord Lengths                                                                  //
! // Dietmar Schrausser, 2023                                                                 //
! //
_name$="CHORD"
_ver$="v3.0.0"
! //
INCLUDE strg_.inc
GR.OPEN 255,255,255,255,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2
CONSOLE.TITLE _name$
mode$="Calculate"
m_sw=1                                                                % // Mode switch        //
d=120                                                                 % // Initial value d    //
arc=90                                                                % // Initial value arc  //
st::st1=0
GOSUB dialog
r=d/2                                                                 % // Radius r           //
tx=mx+mx*(COS(arc/180*PI()))                                          % // initial x position //
ty=my-mx*(SIN(arc/180*PI()))                                          % // initial y position //
DO                                                                    % // Main               //
 GR.CLS
 GOSUB textout
 GR.COLOR 255,0,0,0,0
 GR.SET.STROKE 5
 GR.LINE ln, mx,my,tx,ty                                              % // 1 Radius d/2       //
 GR.SET.STROKE 4
 GR.LINE ln, mx,my+3,sx,my+3                                          % // 2 Radius d/2       //
 GR.COLOR 255,150,150,150,0 
 GR.SET.STROKE 1
 GR.RECT rc, mx,my,tx,ty                                              % //
 GR.CIRCLE cl, mx,my,mx                                               % // Modelcircle        //
 GR.LINE ln, 0,my,sx,my                                               % // x axis             //
 GR.LINE ln, mx,my-mx,mx,my+mx                                        % // y axis             //
 GR.COLOR 255,255,150,0,0
 GR.LINE ln, tx,my-1,sx,my-1                                          % // a                  //
 GR.LINE ln, tx,ty,tx,my                                              % // b                  //
 GR.COLOR 255,255,0,0,0
 GR.SET.STROKE 2
 GR.LINE ln, tx,ty,sx,my                                              % // Chord l            //
 GR.ROTATE.START -arc/2,mx,my
 GR.COLOR 255,0,200,0,1
 GR.LINE ln, mx,my,mx+mx*sl,my                                        % // Distance s         //
 GR.ROTATE.END 
 GR.COLOR 255,0,0,255,0
 GR.SET.STROKE 5
 GR.ARC ac,mx-50,my-50,mx+50,my+50,0,-arc,0                           % // Arcus arc          //
 IF m_sw=-1 THEN GR.TOUCH tc, tx,ty
 GOSUB freerotcalc
 GR.RENDER
 GR.TOUCH2 tc2, tx2, ty2
 IF tc2
  GOTO st
 ENDIF
UNTIL 0                                                               % // Main end           //
ONERROR: 
GOSUB fin: END
ONBACKKEY: 
GOSUB fin
END
! //
dialog:
DO
 s_=(d/2)*SIN(arc*PI()/360)                                       % // Distance s calculation //
 s_=SQR((d/2)^2-s_^2)                                             %
 IF m_sw=1                                                        % // Calculate mode         //
  DIM dlg$[6]
  dlg$[1]=smq$+" Mode: "+mode$
  dlg$[2]=smq$+" d="+STR$(ROUND(d,3))
  dlg$[3]=smq$+" arc "+_ga$+"="+STR$(ROUND(arc,3))+"°"
  dlg$[4]=smq$+" s="+STR$(ROUND(s_,3))
  dlg$[5]="Ok"
  dlg$[6]=_ex$+" Exit"
 ENDIF
 IF m_sw=-1                                                       % // Free rotate mode       //
  DIM dlg$[3]
  dlg$[1]=smq$+" Mode: "+mode$
  dlg$[2]="Ok"
  dlg$[3]=_ex$+" Exit"
 ENDIF
 DIALOG.SELECT dlg, dlg$[],_name$+" Ptolemy's Chord Lengths "+_ver$+" - Options:"
 IF dlg=1
  m_sw=m_sw*-1
  IF m_sw=1: mode$="Calculate"
 ELSE:mode$="Free Rotation":ENDIF
 ENDIF
 IF m_sw=1
  IF dlg=2
   INPUT "Modelparameter d=...",d,120
   IF d=0 THEN d=120
   d=ABS(d):IF d>9999999 THEN d=9999999
  ENDIF
  IF dlg=3
   INPUT "Angle arc "+_ga$+"=...°",arc,90
   arc=ABS(arc):IF arc>180 THEN arc=180
  ENDIF
  IF dlg=5: st1=1:ENDIF
  IF dlg=6: GOSUB fin:END:ENDIF
 ENDIF
 IF m_sw=-1
  IF dlg=2: st1=1:ENDIF
  IF dlg=3: GOSUB fin:END:ENDIF
 ENDIF
UNTIL st1
! //                                                                                          //
RETURN
textout:
GR.TEXT.SIZE sx/25
GR.COLOR 255,0,0,0,1
GR.TEXT.ALIGN 3
GR.TEXT.DRAW txt,sx-sx/20,sy/20,"d:  "+STR$(ROUND(r*2,3))
GR.COLOR 255,255,0,0,1
GR.TEXT.ALIGN 2
GR.TEXT.DRAW txt,mx,sy-sy/20,"Ptolemy's Chord Lengths"
GR.TEXT.SIZE sx/30
GR.COLOR 255,255,150,0,1
GR.TEXT.ALIGN 1
GR.TEXT.DRAW txt,sx/20,sy/20,"a: "+STR$(ROUND(a*r,3))+" b: "+STR$(ROUND(-b*r,3))
GR.COLOR 255,0,200,0,1
GR.TEXT.ALIGN 3
GR.TEXT.DRAW txt,sx-sx/20,sy/8,"s:  "+STR$(ROUND(ABS(sl*r),3)) % // s //
GR.COLOR 255,255,0,0,1
GR.TEXT.ALIGN 2
GR.TEXT.DRAW txt,mx,sy/8,"chord l:  "+STR$(ROUND(c*r,3))
GR.TEXT.SIZE sx/25
GR.TEXT.DRAW txt,mx,sy/8+sy/20,hex$
GR.TEXT.SIZE sx/30
GR.COLOR 255,0,0,255,1
GR.TEXT.DRAW txt,mx,sy-sy/5,"arc "+_ga$+":  "+STR$(ROUND(arc,3))+"°"
RETURN
! //                                                                                          //
freerotcalc:
c0=SQR((tx-mx)^2+(ty-my)^2)                                  % // Lengths                     //
c1=mx/c0                                                     % // Ratio to radius (mx length) //
tx=mx+(tx-mx)*c1                                             % // tx to length for radius     //
ty=my+(ty-my)*c1                                             % // ty to length for radius     //
a=mx-(tx-mx)
b=ty-my
a=a/mx
b=b/mx
!                                                              /////////////////////
c=SQR(a^2+b^2)                                               % // Chord length l   //
sl=SQR(r^2-((c*r)/2)^2)                                      % // Distance s       //   
sl=sl/r:IF arc>180 THEN sl=-sl                               % //                  //
ah=INT(c*r)                                                  % // Hex values       //
bh=60*(c*r-ah)                                               % //                  //
b1h=INT(bh)                                                  % //                  //
ch=60*(bh-b1h)                                               % //                  //            
!                                                              /////////////////////
hex$=INT$(ah)+"   "+INT$(bh)+"   "+STR$(ROUND(ch,1))
arc=TODEGREES(ASIN(-b))                                      % // Angle  arc       //
IF a>1: arc=(90-arc)+90:ENDIF                                % //
IF arc<0:arc=360+arc:ENDIF                                   % //
RETURN
! //
fin:
PRINT_name$+" Ptolemy's Chord Lengths "+_ver$
PRINT"Copyright "+_cr$+" 2023 by Dietmar Gerald Schrausser"
PRINT "https://github.com/Schrausser/Ptolemy-s-table-of-chords"
PRINT "DOI:10.5281/zenodo.7948117"
RETURN
! // END //
! //
