6502 assembly source (will compile with 64tass) to use Supermon+ for C64 on a small SBC with a TTY-only interface.
The main change I made from Andrew Taylor's adaptation for the KIM-1 was fix/add the auto-advance code in the simple assembler.

 display registers [R]
 
 exit monitor [X]	to eWoz
 
 display memory [M]	aaaa bbbb   (if no B, display 1 pg; just M for next pg)
 
 alter registers [;]	print with R, then mimic #s. RET when done
 
 alter memory [>]	>aaaa hh hh hh hh...  8 bytes max (buffer limits)
 
 goto (JMP) [G]	aaaa
 
 jump (JSR) [J]	aaaa
 
 compare memory [C]	aaaa bbbb zzzz   look bet adrs A&B, start compare at Z
 
 transfer memory [T]	aaaa bbbb zzzz   copy from A thru B, store at Z
 
 hunt memory [H]	aaaa bbbb 'TEXT...  or  hh hh hh...   30 bytes max
 
 fill memory [F]	aaaa bbbb hh   one byte only
 
 assemble [A]		aaaa ooo nn|bbbb   auto adv.; RET alone when done
 
 disassemble [D]	aaaa bbbb   (if no B, disamb 22 bytes-worth; another D gives 22 more bytes)

Key locations, etc., for adaptation and reassembly
==================================================
Set up to be assembled with ca65 by Andrew Taylor; 64TASS will not like
some of the pseudo ops, like .bss and .code, etc.  Just comment them out.

The ORG can be anywhere, but not in ROM, and I haven't figured out why...
$7654 is at the top of my RAM and easy to remember.

BREAK routine should point to appropriate locations in the
system for which this is being adapted.

The variables GETCH and OUTCH should point to your monitor/OS single-
character input (no echo) and output, with the I/O via the ACC.

At label SUPER, the "display # bytes/line" varaibles are set for an 80-column
screen/serial terminal emulator; they can be changed back to 8 and 3 for a
40-column screen.

At the end of the source are adaptations for KIM-1 output, mostly to preserve
the YR. While it doesn't hurt anything for them to be there, some bits could
be removed. Also, you may wish to change the text in MSG4 to something more
suitable for you.
