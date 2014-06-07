pro SimpleMap, s

;+
; SimpleMap -- Uses IDL Griddata to make a map using the compiled
;              code.  Inputs is an array of structures for the
;              different points.  
;-

  M33 = galaxies('M33')
  hdr = headfits('/home/astro-util/projects/14A258/m33_hi_mom0.fits')
  nx = sxpar(hdr,'NAXIS1')
  ny = sxpar(hdr,'NAXIS2')
  sxaddpar,hdr,'CDELT1',sxpar(hdr,'CDELT1')*2
  sxaddpar,hdr,'CDELT2',sxpar(hdr,'CDELT2')*2

  x = findgen(nx)#replicate(1,ny)
  y = replicate(1,nx)#findgen(ny)
  xyad,hdr,x,y,MapRAVals,MapDecVals

;  MapRAVec = (dindgen(120)/60-1)/cos(M33.dec*!dtor)+M33.ra
;  MapDecVec = (dindgen(120)/60-1)+M33.dec

;  MapRAVals = MapRAVec#(fltarr(n_elements(MapDecVec))+1)
;  MapDecVals = (fltarr(n_elements(MapRAVec))+1)#MapDecVec 

  triangulate,RAOnRun,DecOnRun,tr

  OnMap = griddata(RAOnRun,DecOnRun,TPOnRun,$
                   method='NearestNeighbor',$
                   xout=MapRAVals,yout=MapDecVals,triangles=tr)
  OffMap = griddata(RAOffRun,DecOffRun,TPOffRun,$
                    method='NearestNeighbor',$
                    xout=MapRAVals,yout=MapDecVals,triangles=tr)
  OnMap = reform(OnMap,nx,ny)
  OffMap = reform(OffMap,nx,ny)

  stop


  return
end
