sdfits_to_rhstk,'AGBT14A_367_02.raw.vegas.A.fits',outpath='../'

;ENTER IDL WITH GBTIDL

;------------------- DEFINE PATHS for input and output -----------------
;Define the subdirrectory that contains the spider-scan input data. Example:
; gbtdatapath= getenv('GBTPATH') + '/documentation/muellergen/polcal/stg1/sav/'
;the following defines the currrent subdirectory:
        pwd, pwdout
        gbtdatapath= pwdout[ n_elements( pwdout)-1] + '/'

;DEFINE THE OUTPUT SUBDIRECTORY. 
; The pgm will write a sav file into this subdirectory. 
; It MUST be a */sav subdirectory and its path MUST be absolute, not relative.
;    example:  outpath= $GBTIDLPATH + 'rhstk/rhstk_examples/spider/nativelinear/sav'
;it MUST exist before unning this program.
;the following defines the output path as the current subdirectory + '/sav'
        outpath= gbtdatapath + '/sav'

;The pgm will also write ps plots into a subdir with the above name except
;that the suffix is ps instead of sav, i.e. 
;   getenv('GBTPATH') + '/calib_example/polcal/stg2/ps'
;This subdir MUST exist before running this pgm

;------------------- DEFINE THE SPIDER PATTERN DATA FILE name ------------
;Define the filename that contains the spider scans.. Example:
;gbtdatafile= '3C286_sp_Rcvr1_2_5_2_03Aug03_14:53:16+test.sav'
        gbtdatafile='3C286_sp_Rcvr1_2_1500_0_14Jun09_00:12:42.sav'
;------------- DEFINE NATIVE POLARIZATION of the feed ----------------
;Define the native polarization. For 1 to 6 GHz at GBT, it's linear:
        nominal_linear=1

;For native circular (>6 GHz at the GBT), you'd set
;       nominal_linear=-1       

;For neither native linear nor circular (e.g., a turnstile at
;       Arecibo being operated off-center frequency.), you'd set
;       nominal_linear=-0

;NTERMS is the nr of Fourier coefficients used in calculating and
;displaying the sidelobe. It has no effect on the derived sidelobe
;properties. GBT sidelobes are so weak that nterms=2 is all you can do.
        nterms=2


;The following defines input parameters for running the program. 
@cal01.idl

;FOR THE PURPOSE OF THIS EXAMPLE, inhibit writing sav files containing
;the results. These parameters were set to unity immediately above in 
;cal01.idl.pro; we set them to zero and override the previous settings.
;        saveit=0
;        ps1yes=0

@doit.idl
