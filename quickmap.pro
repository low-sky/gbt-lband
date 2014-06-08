pro quickmap, s

  nx = 101
  ny = 101

  mkhdr,hdr,4,[nx,ny,1],/image
  sxaddpar,hdr,'TELESCOP','GBT-VEGAS'
  sxaddpar,hdr,'OBJECT','M33'
  sxaddpar,hdr,'BMAJ',7.4/60.,'At 1.7 GHz'
  sxaddpar,hdr,'BMIN',7.4/60.,'At 1.7 GHz'
  
  pixperbeam = 5
  pixsize = 7.4/60./pixperbeam
  g = galaxies('M33')
  
  sxaddpar,hdr,'CRVAL1',g.ra
  sxaddpar,hdr,'CRVAL2',g.dec
  sxaddpar,hdr,'CRVAL3',1.6e9 ; Fudge
  sxaddpar,hdr,'CRPIX1',nx/2.
  sxaddpar,hdr,'CRPIX2',ny/2.
  sxaddpar,hdr,'CRPIX3',1
  sxaddpar,hdr,'CUNIT1','deg'
  sxaddpar,hdr,'CUNIT2','deg'
  sxaddpar,hdr,'CUNIT3','Hz'
  sxaddpar,hdr,'CTYPE1','RA--TAN'
  sxaddpar,hdr,'CTYPE2','DEC-TAN'
  sxaddpar,hdr,'CTYPE3','FREQ   '
  sxaddpar,hdr,'CDELT1',-pixsize
  sxaddpar,hdr,'CDELT2', pixsize
  
  x = findgen(nx)#replicate(1,ny)
  y = replicate(1,nx)#findgen(1,ny)
  xyad,hdr,x,y,MapRAVals,MapDecVals

  triangulate,s.ra,s.dec,tr
  Map = griddata(s.ra,s.dec,s.Iflux,$
                 method='NearestNeighbor',$
                 xout=MapRAVals,yout=MapDecVals,triangles=tr)
  Map = reform(Map,nx,ny)

  stop
  return
end
