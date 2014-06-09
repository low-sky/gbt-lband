pro ByScanCalibrator, scanlist, _extra = extra, output = str, calibration = calstr

;+
; ByScanCalibrator -- calibrate a set of scans returning the subscan
;                     integrations as an array of structures carrying
;                     zee data.
; 
;-

 
  
  nchan = 1024
  nan = !values.d_nan

  Template = {ra:nan,$
              dec:nan,$
              parangle:nan,$
              Iflux:nan,$
              spectrumYY:fltarr(nchan),$
              spectrumXX:fltarr(nchan),$
              spectrumXY:fltarr(nchan),$
              spectrumYX:fltarr(nchan),$
              cal:0b}

  ;; Template = {ra:nan,$
  ;;             dec:nan,$
  ;;             parangle:nan,$
  ;;             Iflux:nan}

  for jj = 0,n_elements(scanlist)-1 do begin
     scan = fix(scanlist[jj])
     message,/con,"Now processing scan "+string(scan)

;  plyx = getchunk(scan=scan,_extra = extra,plnum=0)
;  plxy = getchunk(scan=scan,_extra = extra,plnum=1)

      ResultVecYY = getchunk(scan=scan,_extra = extra,plnum=2)

;     plyy = reform(plyy,2,n_elements(plyy)/2) 
;     NInts=n_elements(plyy)/2
;     calonidx = where(plyy[*,0].cal_state eq 1)
;     caloffidx = 1b-calonidx
     
;     for intnum = 0,NInts-1 do begin
;        dosigref,result,plyy[calonidx,intnum],plyy[caloffidx,intnum]
;        ResultVecYY = (intnum eq 0) ? result : [ResultVecYY,result]
;        result=1
;     endfor

     flag = where((ResultVecYY.Longitude_axis eq 0) or $
                  (ResultVecYY.Latitude_axis eq 0),ct,comp=keep)
     ResultVecYY=ResultVecYY[keep]

     ResultVecXX = getchunk(scan=scan,_extra = extra,plnum=3)
;     plxx = reform(plxx,2,n_elements(plxx)/2) 
;     NInts=n_elements(plxx)/2
;     calonidx = where(plxx[*,1].cal_state eq 0)
;     caloffidx = 1b-calonidx
     
;     for intnum = 0,NInts-1 do begin
;        dosigref,result,plxx[calonidx,intnum],plxx[caloffidx,intnum]
;        data_copy,plxx[calonidx,intnum],result
;        ResultVecXX = (intnum eq 0) ? result : [ResultVecXX,result]
;        result=1;
;     endfor
;     data_free,plxx
;     plxx = NaN


     flag = where((ResultVecXX.Longitude_axis eq 0) or $
                  (ResultVecXX.Latitude_axis eq 0),ct,comp=keep)
     ResultVecXX=ResultVecXX[keep]
     
     for ii = 0, n_elements(ResultVecXX)-1  do begin
        s = Template
        s.ra = ResultVecYY[ii].longitude_axis
        s.dec = ResultVecYY[ii].latitude_axis
        s.parangle = parangle(s.ra/15-ResultvecYY[ii].lst/3.6d3,$
                              s.dec,$
                              ResultVecYY[ii].site_location[1])
        s.spectrumYY = (*ResultVecYY[ii].data_ptr)/ResultVecYY[ii].duration
        s.spectrumXX = (*ResultVecXX[ii].data_ptr)/ResultVecXX[ii].duration
        s.cal = ResultVecXX[ii].cal_state
        spec = sqrt(s.spectrumYY^2+s.spectrumXX^2)
        s.Iflux = median(spec[200:350]) 
        scanarr = (ii eq 0) ? s : [scanarr,s]
     endfor
     str = (jj eq 0) ? scanarr : [str,scanarr]
  endfor  

  return
end
