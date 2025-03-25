#Requires AutoHotkey 2.0+

; Bind Super+Q to open the terminal
#q::
{
    Run "wt.exe"  ; Opens Windows Terminal
}

; Bind AltGr+Shift+Z to send "<"
<^>!+z::
{
    Send "<"
}

; Bind AltGr+Shift+X to send ">"
<^>!+x::
{
    Send ">"
}
