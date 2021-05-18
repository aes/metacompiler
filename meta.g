#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID { .TB 'ADR ' * .NL }
    $ ST
    '.END' { .TB 'END' .NL }
  ;

ST
  = .ID { * .NL } '=' EX1 ';' { .TB 'R' .NL }
  ;

EX1
  = EX2 $ ( '/' { .TB 'BT ' # .NL } EX2 ) { # .NL }
  ;

EX2
  = ( EX3 { .TB 'BF ' # .NL } / OUTPUT )
    $ ( EX3 { .TB 'BE' .NL } / OUTPUT )
    { # .NL }
  ;

EX3
  = .ID       { .TB 'CLL ' * .NL }
  / .STRING   { .TB 'TST ' * .NL }
  / '.ID'     { .TB 'ID' .NL }
  / '.NUMBER' { .TB 'NUM' .NL }
  / '.STRING' { .TB 'SR' .NL }
  / '(' EX1 ')'
  / '.EMPTY'  { .TB 'SET' .NL }
  / '$'
    { # .NL }
    EX3
    { .TB 'BT ' # .NL }
    { .TB 'SET' .NL }
  ;

OUTPUT
  = '.OUT' '(' $ OUT1 ')'
  / '{' $ OUT1 '}'
  ;

OUT1
  = '*'     { .TB 'CI' .NL }
  / .STRING { .TB 'CL ' * .NL }
  / '#'     { .TB 'GN1' .NL }
  / '.NL'   { .TB 'NL' .NL }
  / '.LB'   { .TB 'LB' .NL }
  / '.TB'   { .TB 'TB' .NL }
  / '.LM+'  { .TB 'LMI' .NL }
  / '.LM-'  { .TB 'LMD' .NL }
  ;

.END
