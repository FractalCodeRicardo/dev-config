Hide cursor
`ESC[?25l`

Show cursor
`ESC[?25h`

Move cursor to row and column
`ESC[row;columnH`

Transmit image (Kitty Graphics Protocol)
`ESC_Ga=t,s=WIDTH,v=HEIGHT,i=ID,p=2;BASE64_DATA ESC\`

Display previously transmitted image
`ESC_Ga=p,i=ID,p=1,C=1,X=X,Y=Y,q=2 ESC\`

Delete image
`ESC_Ga=d ESC\`

Kitty Graphics Protocol terminator
`ESC\`
