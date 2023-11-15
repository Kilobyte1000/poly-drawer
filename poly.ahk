#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#SingleInstance, ignore
; #Warn  ; Enable warnings to assist with detecting common errors
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory

PI := 3.141592653589793

;!6 = Alt+6
;!^6 = Alt+Ctrl+6
!3::Draw(3, 0)
!4::Draw(4, PI / 4)
!5::Draw(5, 0)
!6::Draw(6, 0)
!^6::Draw(6, PI / 6)

Draw(sides, initialAngle) {
    ; Check if OneNote is active
    WinGetActiveTitle, title
    a := InStr(title, "OneNote")
    If (a == 0) {
        Return
    }

    global PI
    ; radius of circle around which polygon is constructed
    RADIUS = 60

    ;current position of mouse
    MouseGetPos, x0, y0
    ;coordinates of center around which polygon is drawn
    anchorX := x0
    anchorY := y0 + RADIUS * Cos(initialAngle)
    
    ;angle between consecutive vertices
    theta := 2 * PI/sides
    ;angle for first vertice
    angle := PI/2 + initialAngle

    ; "from" vertex
    x1 := RADIUS * Cos(angle)
    y1 := RADIUS * Sin(angle)
    x2 := 0, y2 := 0
    
    ;run the code in brackets n times (n = no. of sides)
    Loop, %sides%
    {
        angle += theta
        
        ; "to" vertex
        x2 := RADIUS * Cos(angle)
        y2 := RADIUS * Sin(angle)

        ;Drag Left Mouse button from |  and |      to       |     and     | at speed 2 (small no = fast)
        ;                            v      v               v             v
        MouseClickDrag, L, anchorX + x1, anchorY - y1, anchorX + x2, anchorY - y2, 2
      
        ; (x2,y2) should be initial vertex for next side
        x1 := x2, y1 := y2
    }

    ; teleport mouse to its initial position
    MouseMove, x0, y0, 0 

}
