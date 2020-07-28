; Configuration file for Duet WiFi (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Mon Jul 27 2020 16:21:37 GMT-0700 (Pacific Daylight Time)

M80     ; ATX PS_ON on

; General preferences
G90                                            ; send absolute coordinates...
M83                                            ; ...but relative extruder moves
M550 P"CoreXY3"                                ; set printer name
M669 K1                                        ; select CoreXY mode

; Network
M552 S1                                        ; enable network
M586 P0 S1                                     ; enable HTTP
M586 P1 S1                                     ; enable FTP
M586 P2 S0                                     ; disable Telnet

; Drives
M569 P0 S1                                     ; physical drive 0 goes forwards
M569 P1 S1                                     ; physical drive 1 goes forwards
M569 P2 S1                                     ; physical drive 2 goes forwards
M569 P3 S1                                     ; physical drive 3 goes forwards
M584 X0 Y1 Z2 E3                               ; set drive mapping
M350 E16 I0                                    ; configure microstepping without interpolation
M350 X16 Y16 Z16 I1                            ; configure microstepping with interpolation
M92 X200.00 Y200.00 Z400.00 E830.00            ; set steps per mm
M566 X900.00 Y900.00 Z12.00 E120.00            ; set maximum instantaneous speed changes (mm/min)
M203 X6000.00 Y6000.00 Z180.00 E1200.00        ; set maximum speeds (mm/min)
M201 X500.00 Y500.00 Z20.00 E250.00            ; set accelerations (mm/s^2)
M906 X1500 Y1500 Z1500 E1200 I30               ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                        ; Set idle timeout

; Axis Limits
M208 X-2 Y-5 Z-3 S1                            ; set axis minima
M208 X277 Y300 Z285 S0                         ; set axis maxima

; Endstops
M574 X1 S3                                     ; configure sensorless endstop for low end on X
M574 Y1 S3                                     ; configure sensorless endstop for low end on Y
M574 Z1 S2                                     ; configure Z-probe endstop for low end on Z

; Z-Probe
M950 S0 C"exp.heater3"                         ; create servo pin 0 for BLTouch
M558 P9 C"^zprobe.in" H5 F120 T6000            ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X30 Y0 Z2.5                           ; set Z probe trigger value, offset and trigger height
M557 X13:215 Y10:195 S20                       ; define mesh grid

; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B4138 ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0                          ; create bed heater output on bedheat and map it to sensor 0
M140 H0                                        ; map heated bed to heater 0
M143 H0 S80                                    ; set temperature limit for heater 0 to 80C
; M307 H0 B0 S1.00                               ; disable bang-bang mode for the bed heater and set PWM limit
; Bed temp pid autotune
; To autotune send [M303 H0 P1.0 S60]. Check progress with [M303]. when stage 4 done,
; send [M307 H0] and enter results below.
;
; Heater 0 model: gain 237.3, time constant 1430.3, dead time 1.7,
;     max PWM 1.00, calibration voltage 24.2, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P629.0, I12.718, D753.1
; Computed PID parameters for load change:
M307 H0 A237.3 C1430.3 D1.7 V24.2 B0

M308 S1 P"e0temp" Y"thermistor" T100000 B4138  ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                           ; create nozzle heater output on e0heat and map it to sensor 1
M143 H1 S260                                   ; Set temperature limit for heater 1 to 260
;M307 H1 B0 S1.00                              ; disable bang-bang mode for heater  and set PWM limit
; Hotend temp pid autotune
; To autotune send [M303 H1 P1.0 S230]. Check progress with [M303]. when stage 4 done,
; send [M307 H1] and enter results below.
;
;Heater 1 model: gain 503.6, time constant 235.7, dead time 4.9, max PWM 1.00, calibration voltage 24.1, mode PID, inverted no, frequency default
;Computed PID parameters for setpoint change: P16.9, I0.494, D58.5
;Computed PID parameters for load change: P16.
;
M307 H1 A503.6 C235.7 D4.9 V24.1 B0

; Fans
M950 F0 C"fan0" Q500                           ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1                                 ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan1" Q500                           ; create fan 1 on pin fan1 and set its frequency
M106 P1 S1 H1 T45                              ; set fan 1 value. Thermostatic control is turned on

; Tools
M563 P0 D0 H1 F0                               ; define tool 0
G10 P0 X0 Y0 Z0                                ; set tool 0 axis offsets
G10 P0 R0 S0                                   ; set initial tool 0 active and standby temperatures to 0C

; Custom settings are not defined

; Miscellaneous
M575 P1 S1 B57600                              ; enable support for PanelDue
T0                                             ; select first tool

; PS_ON relay triggers
M570 H0 P20 T10 S0    ; Allow a heat bed anomaly to persist for 10 seconds (P10)
                      ; on the before raising a heater fault. Allow a 10C
                      ; deviation from set point (T10) After 0 minutes of heater
                      ; fault cancel the build (S0).

M570 H1 P20 T10 S0    ; Allow a hot end anomaly to persist for 10 seconds (P10)
                      ; on the before raising a heater fault. Allow a
                      ; 10C deviation from set point (T10) After 0
                      ; minute of heater fault cancel the build (S0).

