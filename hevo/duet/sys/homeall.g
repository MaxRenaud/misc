; homeall.g
;

; Make sure we don't have leftover changes.
M98 P"/sys/mode_normal.g"

G29 S2            ; disable bed mesh compensation 

G91               ; relative positioning
M400
M913 Z20          ; Z motors to 20% current
G1 Z5 F1000 S2    ; drop bed Z relative to current position
M400
M913 Z100         ; Z motors to 100% current
M280 P3 S160 I1   ; Reset bltouch in case it didn't have vertical clearance for self test.

; Reduce accelleration for the stall detection to be more reliable.
; We restore it later via configstd.g

M98 P"/sys/mode_stall.g"

; Home X
M400
M913 X30 Y30      ; XY motors to 50% current
G1 S1 X-320 F2600 ; move until motors hit X min and stall
G1 X10 F6000      ; go back a few mm on X
M400
M913 X100 Y100    ; XY motors to 100% current

; Home Y
M400
M913 X30 Y30      ; XY motors to 30% current
G1 S1 Y-320 F2600 ; move until motors hit Y min and stall
G1 Y10 F6000      ; go back a few mm on Y
M400
M913 X100 Y100    ; XY motors to 100% current

; Restore standard config
M98 P"/sys/mode_normal.g"

; Home Z
M400
G90               ; absolute positioning
;G1 X140 Y140 F6000   ; go to probing point (close to edge, for better support if bltouch fails)
;G1 X160 Y100 F6000   ; go to probing point (close to edge, for better support if bltouch fails)
G1 X150 Y172 F6000   ; go to probing point (between two Z rods)
M400
M913 Z60          ; Z motors to 60% current, in case something goes wrong with bltouch
M558 A1 F800      ; Set for probing at fast speed, single probe
G30               ; Probe and home Z (pass 1)
M400
M913 Z100         ; Z motors to 100% current
M558 A5 F100	  ; Set for probing at slow speed, allow multiple trys
G30               ; Probe and home Z

G1 X0 Y-5 Z30 F3000   ; Move end to rest position
;;G1 Z40 F700       ; Move Z   to rest position

