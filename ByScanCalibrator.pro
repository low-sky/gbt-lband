pro ByScanCalibrator, scanlist, _extra = extra, output = str, calibration = calstr


;+
; ByScanCalibrator -- calibrate a set of scans returning the subscan
;                     integrations as an array of structures carrying
;                     zee data.
; 
;-

 
  

  nan = !values.d_nan

  Template = {ra:nan,$
              dec:nan,$
              parangle:nan}

  nchan = 1024

  TPOnRun = [0]
  TPOffRun = [0]
  RAOnRun = [0]
  RAOffRun = [0]
  DecOnRun = [0]
  DecOffRun = [0]



  for jj = 0,n_elements(scanlist)-1 do begin
     scan = fix(scanlist[jj])
     print,scan

;  plyx = getchunk(scan=scan,_extra = extra,plnum=0)
;  plxy = getchunk(scan=scan,_extra = extra,plnum=1)

     plyy = getchunk(scan=scan,_extra = extra,plnum=2)
     plxx = getchunk(scan=scan,_extra = extra,plnum=3)

     nints=n_elements(plyy)/2
     
     speconyy = fltarr(nchan,nints)
     specoffyy = fltarr(nchan,nints)  
     speconxx = fltarr(nchan,nints)
     specoffxx = fltarr(nchan,nints)

;  speconyx = fltarr(nchan,nints)
;  specoffyx = fltarr(nchan,nints)  
;  speconxy = fltarr(nchan,nints)
;  specoffxy = fltarr(nchan,nints)

     RAOn = fltarr(nints)
     DecOn = fltarr(nints)
     RAOff = fltarr(nints)
     DecOff = fltarr(nints)
     
     for ii = 0, nints-1 do begin

        RAOn[ii] = plyy[2*ii].longitude_axis
        DecOn[ii] = plyy[2*ii].latitude_axis
        RAOff[ii] = plyy[2*ii].longitude_axis
        DecOff[ii] = plyy[2*ii].latitude_axis
        speconyy[*,ii] = *(plyy[2*ii].data_ptr)
        specoffyy[*,ii] = *(plyy[2*ii+1].data_ptr)
        speconxx[*,ii] = *(plxx[2*ii].data_ptr)
        specoffxx[*,ii] = *(plxx[2*ii+1].data_ptr)

;     speconyx[*,i] = *(plyx[2*i].data_ptr)
;     specoffyx[*,i] = *(plyx[2*i+1].data_ptr)
;     speconxy[*,i] = *(plxy[2*i].data_ptr)
;    specoffxy[*,i] = *(plxy[2*i+1].data_ptr)

     endfor

     tpoff = sqrt(specoffyy^2+specoffxx^2)
     median_vector = median(tpoff,dim=2)
     median_array = median_vector#(fltarr(nints)+1)
     tpoff = tpoff/median_array-1

     tpon = sqrt(speconyy^2+speconxx^2)
     median_vector = median(tpon,dim=2)
     median_array = median_vector#(fltarr(nints)+1)
     tpon = tpon/median_array-1
     
     P_on = median(tpon[200:350,*],dim=1)
     P_off = median(tpoff[200:350,*],dim=1)
     
     TPOnRun = [TPOnRun,P_on]
     TPOffRun = [TPOffRun,P_off]
     RAOnRun= [RAOnRun,RAOn]
     RAOffRun = [RAOffRun,RAOff]
     DecOnRun = [DecOnRun,DecOn]
     DecOffRun = [DecOffRun,DecOff]

;  data_free,plyx
;  data_free,plxy
     data_free,plxx
     data_free,plyy
  endfor  
  TPOnRun = TPOnRun[1:*]
  TPOffRun = TPOffRun[1:*]
  RAOnRun = RAOnRun[1:*]
  DecOnRun = DecOnRun[1:*]
  RAOffRun = RAOffRun[1:*]
  DecOffRun = DecOffRun[1:*]



  return
end
