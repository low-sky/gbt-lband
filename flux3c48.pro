function Flux3C48, nuGHz

; +
; NRAO flux density model for 3C48 near Lband
; -

  lognu = alog10(nuGHz)+3
  flux = 2.345+0.071*lognu-0.138*lognu^2


  return,flux
end
