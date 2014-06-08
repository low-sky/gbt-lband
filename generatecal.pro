pro GenerateCal, scan, calibration = calstr

;+
; Parse a flux calibration set and generate 
;-

  if n_elements(calstr) eq 0 then begin 
     calstr = {tcal:5.0}
  endif
  
  return
end
