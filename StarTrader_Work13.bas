
1 CLEAR 1000:GOTO 30:REM CLEAR ONLY NEEDED FOR ALTAIR BASIC
2 REM FROM 'COMMODORE 16 GAMES BOOK', MELBOURNE HOUSE, AUS., 1984
3 REM BY RICHARD WOOLCOCK AND CAMERON DUFFY.  MODIFIED, REVISED, AND
4 REM EXPANDED FOR ALTAIR 680 BASIC/ANSI BY DAVE HASSLER, '26
5 REM * RND SEEDING IN LINE 65 READS A 6522 VIA TIMER; FIX AS NEEDED
6 REM * SND CAN BE RESTORED AT REMS MARKED +++

9 REM FN DS(D) FROM C-16 VERS., BROKEN DOWN FOR 72-CHAR LN.:
10 X7=ABS(P(D,0)-P(L,0))^2:X8=ABS(P(D,1)-P(L,1))^2
12 X9=ABS(P(D,2)-P(L,2))^2:X9=X7+X8+X9:X9=INT(SQR(X9))
15 RETURN

30 E$=CHR$(27)+CHR$(91):CL$=E$+"2J":RV$=E$+"7m":RO$=E$+"m"
35 L$="------------------"
37 L1$="+----------+-----------+---------------+"
40 ? CL$:? TAB(12);RV$;"  S T A R   T R A D E R   S O L O  ";RO$
45 PRINT
47 PRINT"Original, multi-player HP-BASIC game by Dave Kaufman, 1973"
50 PRINT:INPUT"Instructions (Y/N)";A$:A$=LEFT$(A$,1)
55 IF A$="Y" OR A$="y" THEN GOSUB 3000
60 INPUT"What is the name of your ship";S$
61 PRINT:PRINT"Now, please ensure CAPS LOCK is on, and then"
62 PRINT"press any key and then <ENTER> to start."
63 INPUT A$:PRINT"Please wait..."
65 I=PEEK(32808):I=I*PEEK(32809):I=RND(-I)
70 DIM P(9,6),PL$(9),PF(9,3),GD(8,1),TP(8),R$(7)
80 PD=0:DF=0:SS=100:L=0:Q=.1:QT=.01
90 DEFFNX(D)=INT(RND(1)*D*8-D*3):R$(0)="Ensign"
100 A$="Captain":R$(1)="Lieutenant":R$(2)=A$+" j.g."
105 R$(3)="Vice "+A$:R$(4)=A$:R$(5)=A$+"-Major"
110 R$(6)="Master "+A$:R$(7)="Grand-Master "+A$

120 DATA Proxima,Rigel,Barnard,Sirius,Ross,Tauceti,Cygni,Procyon
130 DATA Teegard,Luyten,Kapteyn,Lacaile,Wolf,Altair,Eridani,Ursae
140 DATA Gliese,Pavonis
150 FOR I=1TO9:IF RND(1)<.5 THEN READ PL$(I):READ D$:GOTO180
170 READ D$:READ PL$(I)
180 P(I,0)=FNX(I):P(I,1)=FNX(I):P(I,2)=FNX(I)
190 P(I,3)=91-10*I+INT(RND(1)*15)+INT(RND(1)*15)
200 P(I,4)=21-2*I-INT(RND(1)*3):P(I,5)=INT(2000/(P(I,3)*P(I,4))+1)
210 D=I:GOSUB 10:P(I,6)=X9
220 NEXT I:PL$(0)="Sol":P(0,3)=110+INT(RND(1)*20):P(0,4)=20:P(0,5)=1
230 DIM T$(9):T$(0)="0-Food    ":T$(1)="1-Metals  "
240 T$(6)="6-Gems    "
250 T$(2)="2-Weapons ":T$(3)="3-Cyborgs "
260 T$(4)="4-Uranium ":T$(5)="5-Drugs   "
270 T$(7)="7-Fuel    ":T$(8)="8-Repairs "

300 GD(7,1)=10:CS=5000:CR=-95000
305 SD=5+INT(RND(1)*200)/100:OD=INT(SD):GOSUB2200:B=2*CS+500
310 PRINT CL$:GOTO 430
320 INPUT"CMD";A$:A$=LEFT$(A$,1)
330 IF A$="Q" THEN530
340 IF A$="I" THEN GOSUB690:GOTO320
350 IF A$="M" THEN GOSUB870:GOTO320
360 IF A$="J" THEN GOSUB990:GOTO320
370 IF A$="B" AND P(L,4)>15 AND B>0 THENGOSUB2400:GOTO320
380 IF A$="D" AND P(L,4)>15 AND CS>0 THENGOSUB2480:GOTO320
390 IF A$="T" THEN GOSUB1270:GOTO320
400 IF A$="U" AND L=0 THENGOSUB570:GOTO320
410 IF A$="L" AND L=0 THENGOSUB630:GOTO320
420 REM
430 PRINT:?RV$;"VALID COMMANDS ARE:";RO$:?
435 PRINT"I-Cargo and Ship status"
440 PRINT"J-Hyper jump chart":PRINT"T-Trade table"
450 PRINT"M-System library"
460 PRINT"Q-Quit game"
470 PRINT"U-Unload ship to warehouse"
480 PRINT"L-Load ship from warehouse"
490 PRINT"B-Borrow/withdraw cash from bank"
500 PRINT"D-Deposit cash in bank"
510 PRINT:GOTO 320

530 INPUT"QUIT: Are you sure (Y/N)";A$:A$=LEFT$(A$,1)
550 IF A$="Y"THEN2860
560 GOSUB690:GOTO320

570 IN=-1:I$=""
580 PRINT"Unload what";
590 GOSUB1620:IF IN>6 THEN 590:REM +++
600 PRINT RIGHT$(T$(IN),8);:INPUT"- how much";N
605 IF INT(N)>GD(IN,1) OR N<0THEN 570:REM +++
610 GD(IN,0)=GD(IN,0)+INT(N):GD(IN,1)=GD(IN,1)-INT(N)
620 PRINT:GOSUB690:RETURN
630 IN=-1:I$=""
640 PRINT"Load what";
650 GOSUB1620:IF IN>6THEN 650:REM +++
660 PRINT RIGHT$(T$(IN),8);:INPUT"- how much)";N
666 IFINT(N)>GD(IN,0) OR N<0 THEN 630:REM +++
670 GD(IN,1)=GD(IN,1)+INT(N):GD(IN,0)=GD(IN,0)-INT(N)
680 GOSUB 690:RETURN

690 IF INT(SD)>OD THEN GOSUB 2000:REM ADJ ECON CONDX
695 PRINT CL$:PRINT"+";L$;"+";L$;"+"
700 PRINT"   WAREHOUSE (Sol)    ";S$
710 PRINT"+";L$;"+";L$;"+"
720 FOR I=0TO6
730 ?" ";T$(I);TAB(11);GD(I,0);TAB(20);T$(I);TAB(30);GD(I,1)
735 NEXT
740 PRINT"+";L$;"+";L$;"+"
750 ?"Docked at ";PL$(L);".  Stardate";:N=(INT(SD*100))/100
755 ?N+2200:GOSUB2460
760 PRINT "    SHIP DATA FOR ";S$:GOSUB850
770 PRINT"Tonnage";SS;TAB(20);"Damage";DM
800 PRINT"Fuel";GD(7,1);TAB(20);"Deflectors";DF
810 GOSUB 2900:IF N=7 THEN 3100
820 PRINT"Rank: ";R$(N)
830 RETURN

850 CC=SS:FOR I=0TO6:CC=CC-GD(I,1):NEXT
855 CC=CC-INT(GD(7,1))-10*DF:CC=CC-DM
860 ?"Cargo capacity:";CC:RETURN

870 PRINT
875 PRINT"SYSTEM";TAB(10);" POPL.";TAB(20);" TECH.";TAB(30);" AG."
877 PRINT"------";TAB(10);" -----";TAB(20);" -----";TAB(30);" ---"
880 FOR I=0TO9:IF L=I THEN PRINT"*";
890 ? PL$(I);TAB(10);P(I,3);TAB(20);P(I,4);TAB(30);P(I,5);TAB(37);
895 GOSUB 2100:NEXT:PRINT
900 RETURN

910 PRINT:L1=L
920 PRINT"ORIGIN SYSTEM: ";PL$(L1):PRINT
925 PRINT" SYSTEM"," DIST."
926 PRINT"------------"," -----"
930 FOR I=0TO9:PRINT I;"- ";PL$(I),P(I,6):NEXT
970 PRINT:?"Enter 0-9 to select destination"
975 PRINT"then <ENTER> to launch. ('Q' to abort)"
980 RETURN

990 IF CC<0 OR GD(7,1)<=0 THEN RETURN:REM +++
1000 GOSUB910
1010 INPUT A$:A$=LEFT$(A$,1):IF A$="Q" THEN GOSUB690:RETURN
1012 IF ASC(A$)<48 OR ASC(A$)>57 THEN 1010
1015 L1=VAL(A$):IF L1=L THEN GOSUB 1110:GOSUB690:RETURN
1017 PRINT "En route to ";PL$(L1);"."

1020 CH=P(L1,6)/110:IF RND(1)>CH THEN 1040
1025 CH=INT(RND(1)*4)+1:ON CH GOSUB 1120,1150,1210,1245
1040 K=P(L1,6):L=L1:FOR Z=1 TO K
1045 GD(7,1)=GD(7,1)-Q
1050 IF GD(7,1)>=0 THEN 1060
1055 PRINT CL$;RV$;"OUT OF FUEL MID-FLIGHT!";RO$:GOTO2860
1060 SD=SD+QT:IF CR>0 THEN CR=CR+CR/500
1065 IF CR<0 THEN CR=CR+CR/150
1070 NEXT Z:Q=.1:QT=.01

1080 FORI=0TO9:D=I:GOSUB 10:P(I,6)=X9:NEXT:GOSUB2200:REM +++
1085 IF CR>=0 THEN 1095
1090 IF OD>6 THEN GOSUB 1700:REM DEBT (NOT 1ST YR-ISH)
1095 F7=0:GOSUB 2120:IF F7 THEN 2860:REM DRUGS CHECK
1100 B=2*CS+500:GOSUB2540:GOSUB690:RETURN

1110 ?:PRINT RV$;"ORIGIN AND DEST. THE SAME!";RO$
1115 FOR I=1TO2000:NEXT:RETURN

1120 ?:?RV$;"PORT AUTHORITY ALERT!";RO$
1125 ?:?"The P.A. says your ship does not pass inspection, so you"
1130 N=INT(RND(1)*11)+5:N=CS*(N/100):IF N>10000 THEN N=10000
1135 ?"give the boarding officer a 'donation':";N;"credits to dock."
1140 CS=CS-N:GOTO2175

1150 ?:?RV$;"AN OUTLAW SHIP CORRALS YOU!";RO$
1152 GOSUB 2900:N=N+1:M=INT(RND(1)*30)+20:M=M*SS*N^2
1155 ?:?"The outlaw captain quotes";M;"credits to 'ensure' safe"
1160 ?"passage through this area of space. Will you pay (Y/N)";
1165 INPUT A$:A$=LEFT$(A$,1):IF A$<>"Y" THEN 1175 
1170 IF N>CS THEN ?"Not enough cash!":GOTO 1175
1172 CS=CS-N:RETURN
1175 ?"After a brief exchange of fire, you manage to get away,"
1180 IF DF THEN ?"and thanks to your now-ruined deflector shield"
1185 IF DF THEN ?"you come away from the scuffle unscathed.":GOTO2175
1193 N=INT(RND(1)*36)+5:N=(SS-DM)*(N/100):DM=DM+N
1195 ?"but not before taking on";N;"units of damage to your ship and"
1197 ?"losing half of your cargo and a quarter of your fuel to the"
1198 ?"vacuum of space."
1200 FOR I=1TO6:IF GD(I,1)=0 THEN 1205
1202 GD(I,1)=INT(GD(I,1)/2)
1205 NEXT I:GD(7,1)=GD(7,1)*.75:GOTO2175

1210 ?:?RV$;"THE CREW MAKES DEMANDS!";RO$
1215 ?:?"They say that unless you allow them a decent vacation on"
1220 ?"the pleasure planet Risa, they are going to all quit when the"
1225 ?"ship reaches the next system. Will you A)llow it or attempt"
1230 INPUT"to B)ribe them with a 5,000-credit bonus (A/B)";A$:
1235 A$=LEFT$(A$,1):IF A$="A" THEN Q=.3:QT=.03:RETURN
1240 IF CS>5000 THEN CS=CS-5000:RETURN
1242 ?"Not enough cash handy for the bribe. Off to Risa!"
1243 A$="A":GOTO1235

1245 ?:?RV$;"RADIATION STORM!";RO$
1250 ?:?"The detour costs time and additional fuel."
1252 IF DF THEN 1260
1255 N=INT(RND(1)*11)+5:DM=DM+N
1258 ?"The ship also incurs";N;"units of damage."
1260 Q=.2:QT=.02:GOTO2175

1270 PRINT CL$
1275 PRINT"TRADE PRICES for ";PL$(L);":"
1280 PRINT L1$
1290 PRINT" ITEM       PRICE        OWNED"
1300 PRINT L1$
1310 FORI=0TO6:PRINT" ";LEFT$(T$(I),2);:IF IX=I THEN PRINT RV$;
1320 PRINT RIGHT$(T$(I),8);RO$;TP(I);TAB(26);GD(I,1)
1330 NEXT
1340 PRINT L1$
1350 PRINT T$(7);" ";TP(7);TAB(24);GD(7,1)
1360 PRINT L1$
1370 PRINT T$(8);" ";TP(8);TAB(24);DM
1380 PRINT L1$
1390 PRINT"'B'uy  'S'ell  'Q'uit  'R'epair"
1400 IN=-1:I$="":GD(8,1)=0

1420 INPUT A$:A$=LEFT$(A$,1)
1430 IF A$="Q" THEN GOSUB690:RETURN
1440 IF A$<>"R" THEN 1480
1450 PRINT"Repairs";DM;:INPUT N:IF N>DM THEN N=DM
1460 IF INT(N)*TP(8)>CS THEN N=INT(CS/TP(8))
1470 DM=DM-INT(N):CS=CS-INT(N)*TP(8):GOTO1270
1480 IFA$<>"B"THEN1560
1490 PRINT"BUY #";
1500 IF IN<0 THEN GOSUB1620
1510 PRINT RIGHT$(I$,8);"...Amt. (";INT(CS/TP(IN));")";
1530 REM 
1540 INPUT N:IF TP(IN)*INT(N)>CS THEN N=INT(CS/TP(IN))
1550 CS=CS-TP(IN)*INT(N):GD(IN,1)=GD(IN,1)+N:IN=-1:GOTO1270
1560 IF A$<>"S" THEN 1270:REM +++
1570 PRINT"Sell #";:IF IN>=0 THEN 1600
1580 GOSUB1620:PRINT RIGHT$(I$,8);"...Amt.";
1585 IF IN>7 THEN IN=-1:GOTO1270:REM +++
1600 INPUT N:IF INT(N)>GD(IN,1) THEN N=GD(IN,1)
1610 CS=CS+TP(IN)*INT(N):GD(IN,1)=GD(IN,1)-N:IN=-1:GOTO1270
1620 INPUT A$:A$=LEFT$(A$,1)
1630 IF ASC(A$)>=48 AND ASC(A$)<=55THENIN=ASC(A$)-48:I$=T$(IN):RETURN
1640 GOTO1620:REM +++

1699 REM REPOSSESION & LOAN PYMT
1700 IF P(L,4)<16 THEN RETURN:REM NO BANK HERE
1702 IF PD=10 THEN 1900:REM SHIP PAID OFF
1705 IF OD>10 THEN 1950
1707 N=ABS(INT(CR*.1))
1710 ?:?"The loan payment on the ship is due. The interest-only"
1720 ?"amount is";N;"credits. You have";CS;"credits."
1730 IF CS<N THEN 1800:REM 50% CHANCE REPO
1740 ?"How much do you pay";:INPUT M:IF M>CS THEN M=CS
1750 CS=CS-M:CR=CR+M:PD=PD+1:IF CR=>0 THEN PD=10:RETURN
1760 IF PD=10 AND CR<0 THEN 1840
1770 RETURN
1800 ?"Sadly, you don't have that much.":FOR I=1TO1200:NEXT
1810 IF RND(1)>.5 THEN 1840
1820 ?"Happily, the bank will accept what little cash you have..."
1825 ?"this time..."
1830 CR=CR+CS:CS=0:RETURN
1840 ?:?RV$;"DEFAULT! SHIP REPOSESSED!";RO$:GOTO2860
1900 N=ABS(INT(CR*.1)):IF N>CS THEN N=CS
1910 ?:?"A payment on your debt is due;"
1920 ?"the minimum amount is";N;"credits."
1930 INPUT"Your payment";M
1935 IF M<=CS AND M=>N THEN CS=CS-N:CR=CR+N:RETURN
1940 ?"Try again. ";:GOTO 1930
1950 ?"The term of your loan has ended, and you did not pay it off"
1955 ?"before 2211.":?:GOTO 1840

2000 OD=INT(SD)
2005 ?:?RV$;" TRADE MINISTRY REPORT FOR STAR YEAR";2200+OD;RO$
2010 PRINT:?"Sol    ","Stasis"
2012 FOR I=1TO9:N=INT(RND(1)*6)+1:PRINT PL$(I),
2015 ON N GOTO 2020,2040,2080,2080,2080,2060
2020 P(I,3)=INT(P(I,3)*1.1+.5)
2025 P(I,4)=INT(P(I,4)*1.1+.5):IF P(I,4)=20 THEN P(I,4)=19:GOTO2035
2030 P(I,5)=INT(P(I,5)*.9)+1
2035 PRINT"Mod. Growth":GOTO2090
2040 P(I,3)=INT(P(I,3)*1.05+.5)
2045 P(I,4)=INT(P(I,4)*1.05+.5):IF P(I,4)=20 THEN P(I,4)=19:GOTO2055
2050 P(I,5)=INT(P(I,5)*.95)+1
2055 PRINT"Light Growth":GOTO2090
2060 P(I,3)=INT(P(I,3)*.8):IF P(I,3)=0 THEN P(I,3)=1
2065 P(I,4)=INT(P(I,4)*.8):IF P(I,4)=0 THEN P(I,4)=1:GOTO2075
2070 P(I,5)=INT(P(I,5)*1.1)+1
2075 PRINT"Recession":GOTO2090
2080 PRINT"Stasis"
2090 NEXT I:?:?"Press any key then <ENTER> to continue."
2095 INPUT A$:RETURN

2100 IF P(I,4)=20 THEN PRINT"Capitol":RETURN
2105 IF P(I,4)>15 THEN PRINT"Advanced":RETURN
2110 IF P(I,4)>9 THEN PRINT"Emerging":RETURN
2115 PRINT"Frontier":RETURN

2119 REM CARRYING DRUGS?
2120 IF GD(5,1)<=0 THEN RETURN
2125 CH=(P(L,3)+P(L,4))*.45:CH=CH/100:IF RND(1)>CH THEN RETURN
2130 ?:?RV$;" IT'S THE SPACE PATROL! ";RO$
2135 ?:?"'This is the federation space patrol. We have learned that"
2140 ?"you have illegal cargo aboard your ship. Prepare for boarding"
2145 ?"and arrest!' When they arrive, do you offer a bribe (Y/N)";
2150 INPUT A$:A$=LEFT$(A$,1):IF A$<>"Y" THEN 2161
2155 IF RND(1)<=.1 THEN 2165
2160 ?"'...and now you can add attempted bribary to your charges!'"
2161 ?RV$;" NEXT STOP: PENAL COLONY! ";RO$:F7=1:RETURN
2165 GD(5,1)=0:CS=CS/2
2170 ?"The crooked officer takes the drugs and half of your cash."
2175 FOR I=1TO1800:NEXT:RETURN

2200 TP(0)=20/SQR(P(L,5))
2210 TP(1)=2000/(5*P(L,4)+P(L,5)/5)
2220 TP(2)=40000/(10*P(L,4)+P(L,3))
2230 TP(3)=(12000+INT(RND(1)*2000))/SQR(10*P(L,4))
2240 TP(4)=100000/SQR(4*P(L,4))
2250 TP(5)=10000/SQR(P(L,5)/3)
2260 TP(6)=15000*P(L,3)/(5*P(L,4))
2270 TP(7)=100/SQR(2*P(L,4))
2280 TP(8)=500-P(L,4)*22
2290 FOR I=0TO7
2295 IF RND(1)<.4 THEN TP(I)=TP(I)-RND(1)*(TP(I)/(7+L/2)):GOTO2310
2300 TP(I)=TP(I)+RND(1)*TP(I)/(10+2*L)
2310 NEXT:IX=INT(RND(1)*7)
2315 IF INT(RND(1)*10)<>L OR RND(1)<50/(SD*10) THEN IX=-1:RETURN
2320 NS=(RND(1)*P(L,3)+8)/4:G$="shortage":N=(INT(NS*100))/100
2325 IF RND(1)<.5 THEN G$="glut":NS=4/NS:N=(INT(NS*100))/100
2330 PRINT:?"There has been a ";G$;" of ";RIGHT$(T$(IX),8)
2340 PRINT"Prices are ";RV$;N;RO$;
2345 PRINT" times normal!"
2350 FOR I=1TO2500:NEXT:TP(IX)=TP(IX)*NS:RETURN
2360 FORI=0TO6:PRINT:?GD(I,0),GD(I,1)
2390 PRINT:NEXT:RETURN

2400 GOSUB2460
2410 PRINT"Borrow/Withdraw";
2420 INPUT N:IF INT(N)>B THEN N=B
2430 CS=CS+INT(N):CR=CR-INT(N):B=B-INT(N):GOSUB2460
2440 PRINT
2450 RETURN

2460 F7=0:?"Cash:";:N=CS:IF CS<1000000 THEN 2468
2465 N=CS/1000000:N=INT(N*100)/100:F7=1
2468 ?N;:IF F7 THEN ?"M";:F7=0
2470 ?TAB(20);"Credit:";:N=CR:IF CR<1000000 THEN 2475
2472 N=CR/1000000:N=(INT(N*100))/100:F7=1
2475 ?N;:IF F7 THEN ?"M";:F7=0
2478 PRINT:RETURN

2480 GOSUB2460
2490 INPUT"Deposit";N
2500 IF INT(N)>CS THEN N=CS
2510 CS=CS-INT(N):CR=CR+INT(N):B=B+INT(N):GOSUB2460
2520 PRINT
2530 RETURN

2540 IF RND(1)>P(L,4)/40 THEN RETURN
2550 IF RND(1)>.3 THEN2680
2560 CT=P(L,4)*100+1000*RND(1)+RND(1)*(CS/1000)+CS/1000
2570 GOSUB 2740:IF CT>CS THEN RETURN
2580 PRINT:?"You are offered a bigger spaceship"
2590 PRINT"from a company on ";PL$(L);"."
2600 PRINT"It costs";CT;"cash credits with a trade-in."
2610 GOSUB2820:IF A$<>"Y" THEN RETURN
2620 SS=SS+(100*M):RETURN

2680 IF RND(1)>.3 THEN RETURN
2690 CT=200*(25-P(L,4))+RND(1)*(CS/800)+CS/800
2700 GOSUB 2740:IF CT>CS THEN RETURN
2710 PRINT:?"There is a deflector shield available here,"
2720 PRINT"which costs just";CT;"cash credits."
2730 GOSUB2820:DF=DF+1:RETURN

2739 REM ADJ PRICE BY EXPER.
2740 GOSUB 2900:REM GET RANK #, CT*FACTOR
2750 IF N<4 THEN CT=CT*100:M=1:RETURN
2755 IF N<6 THEN CT=CT*1000:M=2:RETURN
2760 CT=CT*10000:M=3:RETURN

2820 PRINT:INPUT"Will you make the purchase (Y/N)";A$
2830 A$=LEFT$(A$,1)
2840 IF A$="Y" THEN CS=CS-CT
2850 PRINT:RETURN

2860 PRINT:PRINT"In Star Year";2200+OD:PRINT"Cash possessed:";CS
2865 PRINT"Bank balance:";CR:PRINT "Ship's tonnage:";SS
2870 PRINT"Goods possessed:"
2880 FORI=0TO6:PRINT T$(I);GD(I,0)+GD(I,1):NEXT
2885 PRINT"Final rank: ";:GOSUB 2900:PRINT R$(N):END

2900 N=INT((CS+CR)/1000000):N=N+((SS-100)/100):N=N+INT(OD/5)
2905 REM ?N;
2910 IF N<1 THEN N=0:RETURN
2920 IF N<3 THEN N=1:RETURN
2930 IF N<5 THEN N=2:RETURN
2940 IF N<12 THEN N=3:RETURN
2950 IF N<22 THEN N=4:RETURN
2960 IF N<35 THEN N=5:RETURN
2970 IF N<53 THEN N=6:RETURN
2990 IF N=>53 THEN N=7:RETURN

3000 PRINT CL$;
3002 ?"  In the 22nd century CE, humanity spreads outward to the"
3004 ?"stars, colonizing nine systems by 2191. Some are 'frontier
3006 ?"systems,' others more developed. Interstellar trade is vital,"
3008 ?"and growth, while sometimes slow, seems inevitable."
3010 ?"  Using all of your charm and intelligence, you secure a"
3015 ?"four-year loan from the Interstellar Bank (Sol branch) to"
3020 ?"purchase a small, beat-up, second-hand merchant ship. With"
3025 ?"the little cash left over, you begin your journey in the"
3030 ?"hazardous world of interstellar speculation."
3035 ?"  Use your cash to purchase various items at cheap prices,"
3040 ?"then travel to worlds where the demand for these items is"
3045 ?"great and sell them at a profit. You must repay your massive"
3050 ?"loan from the bank or risk repossession, but you can also"
3052 ?"earn interest if you maintain a positive balance. Deposits"
3054 ?"and withdrawls/loans can be made at any SIB branch, found on"
3056 ?"more technically advanced systems. There is also a warehouse"
3058 ?"in the Sol system to store items for later sale. Finally,"
3060 ?"beware of racketeers, crooked cops, and space storms."
3065 ?:?"May you bank a gigabuck or two and become a Grand-Master!"
3067 ?:?"Press any key and then <ENTER> to start."
3070 INPUT A$:? CL$:RETURN

3100 ?CL$
3105 ?"  By Star Year";2200+OD;"you have achieved everything any"
3110 ?"merchant captain of any era could hope to achieve. With your"
3115 N=INT((CR+CS)/1000000)
3120 ?"fabulous wealth of over";N;"million credits, you pilot the"
3125 ? S$;" one last time, its heading: Risa."
3130 ?"  There, on your palatial estate, you want for nothing, and"
3135 ?"hold court over a new, young crop of eager captains who"
3140 ?"dream of following in your footsteps. You get a chuckle from"
3145 ?"the young pups who come to seek your advice and favor, when"
3150 ?"they bow deeply and call you..."
3155 ?TAB(11);RV$;" Grand Master Captain, Lord of Trade! ";RO$
3160 END
