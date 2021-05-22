  ADR AEXP
AEXP
  CL '#!./aexp/aexp.py'
  NL
  CLL AS
  BE
L1
  CLL AS
  BT L1
  SET
  BE
L2
L3
  R
AS
  ID
  BF L4
  TB
  CL 'lea '
  CI
  NL
  TST ':='
  BE
  CLL EX1
  BE
  TB
  CL 'sto '
  NL
  TST ';'
  BE
L4
L5
  R
EX1
  CLL EX2
  BF L6
L7
  TST '+'
  BF L8
  CLL EX2
  BE
  TB
  CL 'add'
  NL
L8
  BT L9
  TST '-'
  BF L10
  CLL EX2
  BE
  TB
  CL 'sub'
  NL
L10
L9
  BT L7
  SET
  BE
L6
L11
  R
EX2
  CLL EX3
  BF L12
L13
  TST '*'
  BF L14
  CLL EX3
  BE
  TB
  CL 'mul'
  NL
L14
  BT L15
  TST '/'
  BF L16
  CLL EX3
  BE
  TB
  CL 'div'
  NL
L16
L15
  BT L13
  SET
  BE
L12
L17
  R
EX3
  CLL EX4
  BF L18
L19
  TST '^'
  BF L20
  CLL EX3
  BE
  TB
  CL 'exp'
  NL
L20
L21
  BT L19
  SET
  BE
L18
L22
  R
EX4
  TST '+'
  BF L23
  CLL EX5
  BE
L23
  BT L24
  TST '-'
  BF L25
  CLL EX5
  BE
  TB
  CL 'neg'
  NL
L25
  BT L24
  CLL EX5
  BF L26
L26
L24
  R
EX5
  ID
  BF L27
  TB
  CL 'lod '
  CI
  NL
L27
  BT L28
  NUM
  BF L29
  TB
  CL 'psh '
  CI
  NL
L29
  BT L28
  TST '('
  BF L30
  CLL EX1
  BE
  TST ')'
  BE
L30
L28
  R
  END
