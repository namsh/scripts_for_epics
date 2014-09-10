;; emacs el : epicsdb_mode.el
;; Author   : Jeong Han Lee
;; email    : jhlee@ibs.re.kr
;; Date     : Friday, September  5 13:17:02 KST 2014
;; version  : 0.0.2
;;
;; 0.0.1    : Friday, September  5 13:17:37 KST 2014
;;            created
;; 0.0.2    : Wednesday, September 10 23:47:39 KST 2014
;;            - based mode : sh mode, because of the default
;;              indent.
;;            - re-order keyword, type, and so on...
;;            - add more constants...
;;
;;  

;; The references for writing this codes are 
;; 1) http://ergoemacs.org/emacs/elisp_syntax_coloring.html
;; 2) http://www.emacswiki.org/emacs/SampleMode


;; I intend to develop this emacs mode file for EPICS db, vdb, and dbd files,
;; because I cannot find any syntax highlighting feature in the EPICS community.
;;
;; 1) put this file in ${HOME}/.emacs.d/
;; 2) add the following lines in ${HOME}/.emacs 
;;    (load-file "$HOME/.emacs.d/epicsdb-mode.el")
;;    (require 'epicsdb-mode)

;; keyward : purple
;; type    : green
;; comment : red
;; event   : pink
;; function : blue
;; constant : blue green
;;

;; define several class of keywords
 (setq epicsdb-keyword 
       '(
 	"path"
 	"addpath"
 	"include"
 	"menu"
;; 	"choice"
 	"recordtype"
;; 	"field"
 	"device"
;; 	"driver"
 	"registrar"
;; 	"function"
 	"variable"
;; 	"breaktable"
 	"record"
;; 	"grecord"
;; 	"info"
 	"alias"
	)
       )

;;
;; EPICS Record Type https://wiki-ext.aps.anl.gov/epics/index.php/RRM_3-14
;;
(setq epicsdb-types 
      '(
	"aai"
	"aao"
	"ai" 
	"ao"
	"aSub"
	"bi" 
	"bo" 
	"calc"
	"calcout"
	"compress"
	"dfanout"
	"event"
	"fanout"
	"histogram"
	"longin"
	"longout"
	"mbbi"
	"mbbiDirect"
	"mbbo"
	"mbboDirect"
	"permissive"
	"sel"
	"seq"
	"state"
	"stringin"
	"stringout"
	"subArray"
	"sub"
	"waveform"
	)
      )

;;
;; EPICS Field Commons https://wiki-ext.aps.anl.gov/epics/index.php/RRM_3-14_dbCommon
;;
(setq epicsdb-constant 
      '(
	;; SCAN Fields
	"SCAN"
	"PINI"
	"PHAS"
	"EVNT"
	"PRIO"
	"DISV"
	"DISA"
	"SDIS"
	"PROC"
	"DISS"
	"LCNT"
	"PACT"
	"FLNK"
	"SPVT"
	;; ALAM Fields
	"STAT"
	"SEVR"
	"NSTA"
	"NSEV"
	"ACKS"
	"ACKT"
	"UDF"
	;; Device Fields
	"RSET"
	"DSET"
	"DPVT"
	;; Debugging Fields
	"TPRO"
	"BKPT"
	;; Miscellaneous Field
	"NAME"
	"DESC"
	"ASG"
	"TSE"
	"TSEL"
	"DTYP"
	"MLOK"
	"MLIS"
	"DISP"
	"PUTF"
	"RPRO"
	"ASP"
	"PPN"
	"PPNR"
	"RDES"
	"TIME"
	;; Input Records, Common Fields
	"INP"
	"DTYP"
	"RVAL"
	"VAL"
	"SIMM"
	"SIML"
	"SVAL"
	"SIOL"
	"SIMS"
	"OUT"
	"OVA"
	;; Output Records, Common Fields
	"OUT"
;;	"DTYP"
;;	"VAL"
	"OVAL"
	"RVAL"
	"RBV"
	"DOL"
	"OMSL"
	"OIF"
;;	"SIMM"
;;	"SIML"
;;	"SIOL"
;;	"SIMS"
	"IVOA"
	"IVOV"
	;; AI Records
;;	"VAL"
;;	"INP"
;;	"DTYP"
	"LINR"
;;	"RVAL"
	"ROFF"
	"EGUF"
;;	"EGUL"
	"AOFF"
	"ASLO"
	"ESLO"
	"EOFF"
	"SMOO"
	"EGU"
	"HOPR"
	"LOPR"
	"PREC"
;;	"NAME"
;;	"DESC"
	"HIHI"
	"LOLO"
	"HIGH"
	"LOW"
	"HSV"
	"HHSV"
	"LLSV"
	"LSV"
	"HYST"
	"ADEL"
	"MDEL"
	"ORAW"
	"LAIM"
	"ALST"
	"MLST"
	"INIT"
	"PBRK"
	"LBRK"
;;	"PACT"
	"DPVT"
	"UDF"
	"NSEV"
	"NSTA"
;;	"EGUF"
	"EGUL"
	"ESLO"
	"EOFF"
;;	"RVAL"
;; AO
	"OMSL"
	"DOL"
	"OIF"
	"DRVH"
	"DRVL"
	"OROC"
;;	"OVAL"
	"ORBV"
	"LALM"
	"ALST"
	"MLST"
	"PBRK"
	"LBRK"
	"OMOD"
;;	"PACT"
	"DPVT"
;;  aSub;; calcout /calc
	"LFLG"
	"EFLG"
	"SUBL"
	"INAM"
	"SNAM"
	"ONAM"
	"SADR"
	"BRSV"
	"PREC"
	"INPA"
	"INPB"
	"INPC"
	"INPD"
	"INPE"
	"INPF"
	"INPG"
	"INPH"
	"INPI"
	"INPJ"
	"INPK"
	"INPL"
	"INPN"
	"INPM"
	"INPO"
	"INPP"
	"INPQ"
	"INPR"
	"INPS"
	"INPT"
	"INPU"
	"CALC"
	"RPCL"
	"OCAL"
	"DOPT"
	"INAV"
	"INBV"
	"INCV"
	"INDV"
	"INEV"
	"INFV"
	"INGV"
	"INHV"
	"INIV"
	"INJV"
	"INLV"
	"OUTV"
	"CLCV"
	"OCLV"
	"DLYA"
	"HYST"
	"A"
	"B"
	"C"
	"D"
	"E"
	"F"
	"G"
	"H"
	"I"
	"J"
	"K"
	"L"
	"M"
	"N"
	"O"
	"P"
	"Q"
	"R"
	"S"
	"T"
	"U"
;;
	"LA"
	"LB"
	"LC"
	"LD"
	"LE"
	"LF"
	"LG"
	"LH"
	"LI"
	"LJ"
	"LK"
	"LL"
;;
	"FTA"
	"FTB"
	"FTC"
	"FTD"
	"FTE"
	"FTF"
	"FTG"
	"FTH"
	"FTI"
	"FTJ"
	"FTK"
	"FTL"
	"FTM"
	"FTN"
	"FTO"
	"FTP"
	"FTQ"
	"FTR"
	"FTS"
	"FTT"
	"FTU"
;;
	"NOA"
	"NOB"
	"NOC"
	"NOD"
	"NOE"
	"NOF"
	"NOG"
	"NOH"
	"NOI"
	"NOJ"
	"NOK"
	"NOL"
	"NOM"
	"NON"
	"NOO"
	"NOP"
	"NOQ"
	"NOR"
	"NOS"
	"NOT"
	"NOU"
;;
	"NEA"
	"NEB"
	"NEC"
	"NED"
	"NEE"
	"NEF"
	"NEG"
	"NEH"
	"NEI"
	"NEJ"
	"NEK"
	"NEL"
	"NEM"
	"NEN"
	"NEO"
	"NEP"
	"NEQ"
	"NER"
	"NES"
	"NET"
	"NEU"
;;
	"OUTA"
	"OUTB"
	"OUTC"
	"OUTD"
	"OUTE"
	"OUTF"
	"OUTG"
	"OUTH"
	"OUTI"
	"OUTJ"
	"OUTK"
	"OUTL"
	"OUTM"
	"OUTN"
	"OUTO"
	"OUTP"
	"OUTQ"
	"OUTR"
	"OUTS"
	"OUTT"
	"OUTU"
;;
	"ONVA"
	"ONVB"
	"ONVC"
	"ONVD"
	"ONVE"
	"ONVF"
	"ONVG"
	"ONVH"
	"ONVI"
	"ONVJ"
	"ONVK"
	"ONVL"
	"ONVM"
	"ONVN"
	"ONVO"
	"ONVP"
	"ONVQ"
	"ONVR"
	"ONVS"
	"ONVT"
	"ONVU"
;;
	"VALA"
	"VALB"
	"VALC"
	"VALD"
	"VALE"
	"VALF"
	"VALG"
	"VALH"
	"VALI"
	"VALJ"
	"VALK"
	"VALL"
	"VALM"
	"VALN"
	"VALO"
	"VALP"
	"VALQ"
	"VALR"
	"VALS"
	"VALT"
	"VALU"
;;
	"FTVA"
	"FTVB"
	"FTVC"
	"FTVD"
	"FTVE"
	"FTVF"
	"FTVG"
	"FTVH"
	"FTVI"
	"FTVJ"
	"FTVK"
	"FTVL"
	"FTVM"
	"FTVN"
	"FTVO"
	"FTVP"
	"FTVQ"
	"FTVR"
	"FTVS"
	"FTVT"
	"FTVU"
;;
	"NOVA"
	"NOVB"
	"NOVC"
	"NOVD"
	"NOVE"
	"NOVF"
	"NOVG"
	"NOVH"
	"NOVI"
	"NOVJ"
	"NOVK"
	"NOVL"
	"NOVM"
	"NOVN"
	"NOVO"
	"NOVP"
	"NOVQ"
	"NOVR"
	"NOVS"
	"NOVT"
	"NOVU"
;;
	"OVLA"
	"OVLB"
	"OVLC"
	"OVLD"
	"OVLE"
	"OVLF"
	"OVLG"
	"OVLH"
	"OVLI"
	"OVLJ"
	"OVLK"
	"OVLL"
	"OVLM"
	"OVLN"
	"OVLO"
	"OVLP"
	"OVLQ"
	"OVLR"
	"OVLS"
	"OVLT"
	"OVLU"
;;
	"NEVA"
	"NEVB"
	"NEVC"
	"NEVD"
	"NEVE"
	"NEVF"
	"NEVG"
	"NEVH"
	"NEVI"
	"NEVJ"
	"NEVK"
	"NEVL"
	"NEVM"
	"NEVN"
	"NEVO"
	"NEVP"
	"NEVQ"
	"NEVR"
	"NEVS"
	"NEVT"
	"NEVU"

	"LFLG"
	"EFLG"
	"SUBL"
	"INAM"
	"SNAM"
	"ONAM"
	"SADR"
	"BRSV"
	

	"OOPT"
	"DOPT"
	"OCAL"
	"OVAL"
	"OEVT"
	"ODLY"
	"IVOA"
	"IVOV"
	;; MBBO
	"MASK"
	"NOBT"
	"SHFT"
	"ZRVL"
	"ONVL"
	"TWVL"
	"THVL"
	"FRVL"
	"FVVL"
	"SXVL"
	"SVVL"
	"EIVL"
	"NIVL"
	"TEVL"
	"ELVL"
	"TVVL"
	"TTVL"
;;
;;	"FTVL"

	"FFVL"
	"ZRST"
	"ONST"
	"TWST"
	"THST"
	"FRST"
	"FVST"
	"SXST"
	"SVST"
	"EIST"
	"NIST"
	"TEST"
	"ELST"
	"TVST"
	"TTST"
	"FTST"
	"FFST"
	"UNSV"
	"COSV"
	"ZRSV"
	"ONSV"
	"TWSV"
	"THSV"
	"FRSV"
	"FVSV"
	"SXSV"
	"SVSV"
	"EISV"
	"NISV"
	"TESV"
	"ELSV"
	"TVSV"
	"FTSV"
	"FFSV"
	"ORAW"
	"LALM"
	"MLST"
	"SDEF"
;;	"PACT"
	"DPVT"
	"UDF"
	"NOBT"
	"MASK"
	"SHFT"
	;; seq
	"DOL1"
	"DOL2"
	"DOL3"
	"DOL4"
	"DOL5"
	"DOL6"
	"DOL7"
	"DOL8"
	"DOL9"
	"DOLA"
	"DO1"
	"DO2"
	"DO3"
	"DO4"
	"DO5"
	"DO6"
	"DO7"
	"DO8"
	"DO9"
	"DOA"
	"LNK1"
	"LNK2"	
	"LNK3"
	"LNK4"	
	"LNK5"
	"LNK6"	
	"LNK7"
	"LNK8"	
	"LNK9"
	"LNKA"	
	"DLY1"
	"DLY2"
	"DLY3"
	"DLY4"
	"DLY5"
	"DLY6"
	"DLY7"
	"DLY8"
	"DLY9"
	"DLYA"
	"SELM"
	"SELN"
	"SELL"

	"ZNAM"
	"ZSV"
	"MPST"
	"APST"
	"NELM"
	"OSV"
	"WDPT"
	"RPVT"
	"HASH"
	"NLST"
	"ALG"
	"NSAM"
	"LSET"
	"INDX"
	"BUSY"
	"NORD"
	"BPTR"
	"MALM"
	)
      )

;;(setq epicsdb-events '("at_rot_target" "at_target" "attach"))
(setq epicsdb-variable
;;(setq epicsdb-functions 
      '(
	"PP"
	"NPP"
	"MS"
	"NMS"
	"CP"
	"CPP"
	"CA"
	"NO_ALARM"
	"MINOR"
	"MAJOR"
	"INVALID"
	"DBF_STRING"
	"DBF_INT"
	"DBF_SHORT"
	"DBF_FLOAT"
	"DBF_ENUM"
	"DBF_CHAR"
	"DBF_LONG"
	"DBF_DOUBLE"
	"DBF_NO_ACCESS"
	"DBF_UCHAR"
	"DBF_USHORT"
	"DBF_ULONG"
	"DBF_MENU"
	"DBF_INLINK"
	"DBF_DEVICE"
	"DBF_NOACCESS"
	"DBF_FWDLINK"
	"DBF_OUTLINK"

	;; Hardware Link Types
	"VME_IO"
	"INST_IO"
	"CAMAC_IO"
	"AB_IO"
	"GPIB_IO"
	"BITBUS_IO"
	"BBGPIB_IO"
	"RF_IO"
	"VXI_IO"
	"CONSTANT"

	"TRUE"
	"ASL0"
	"GUI_ALARMS"
	"GUI_DISPLAY"
	"GUI_INPUTS"
	"GUI_OUTPUT"
	"GUI_SELECT"
	"GUI_SUB"
	"GUI_WAVE"
	"GUI_CALC"
	"GUI_MBB"
	"GUI_BITS1"
	"GUI_BITS2"
	"GUI_COMMON"
	"GUI_CLOCK"
	"GUI_COMPRESS"
	"GUI_CONVERT"
	"GUI_SEQ1"
	"GUI_SEQ2"
	"GUI_SEQ3"
	"GUI_SCAN"

	"SPC_CALC"

	"SPC_MOD"
	"SPC_NOMOD"
	"SPC_DBADDR"
	)
      )


(setq epicsdb-function 

      '(
;;	"menu"
	"prompt"
	"promptgroup"
	"special"
	"size"
	"interest"
	"pp"
	"initial"
	"extra"
	"asl"
;;	"recordtype"
 	"field"
	"choice"
;;	"registrar"
;;	"variable"
	"breaktable"
	)
      )

;; create the regex string for each class of keywords
;;(setq epicsdb-comments-regexp  (regexp-opt epicsdb-comments  'words))

(setq epicsdb-keyword-regexp  (regexp-opt epicsdb-keyword  'words))
(setq epicsdb-type-regexp      (regexp-opt epicsdb-types     'words))
(setq epicsdb-constant-regexp (regexp-opt epicsdb-constant 'words))
(setq epicsdb-variable-regexp    (regexp-opt epicsdb-variable    'words))
(setq epicsdb-function-regexp  (regexp-opt epicsdb-function  'words))


;; clear memory
;;(setq epicsdb-comments nil)
(setq epicsdb-keyword nil)
(setq epicsdb-types nil)
(setq epicsdb-constant nil)
(setq epicsdb-variable nil)
(setq epicsdb-function nil)



(defvar epicsdb-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; bash style comment: “# …” 
    (modify-syntax-entry ?# "< b" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for `epicsdb-mode'."
  )


;;
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Faces-for-Font-Lock.html
;;
;; - font-lock-keyword-face            "purple"
;; - font-lock-type-face                "ForestGreen"
;; - font-lock-constant-face               "dark cyan"
;; - font-lock-variable-name-face      "sienna"
;; - font-lock-function-name-face      "blue"
;; - font-lock-comment-face            "FireBrick"
;; - font-lock-string-face                 "VioletRed4"
;; - font-lock-doc-face                    "VioletRed4"  "" is treated as String or Doc


;; font-lock-warning-face                "Red1"
;; font-lock-builtin-face                "MediumOrchid4"
;; font-lock-preprocessor-face           "MediumOrchid4"

;; font-lock-negation-char-face


(setq epicsdb-font-lock-keywords
  `(
    (,epicsdb-keyword-regexp   . font-lock-keyword-face)
    (,epicsdb-type-regexp      . font-lock-type-face)
    (,epicsdb-constant-regexp  . font-lock-constant-face)
    (,epicsdb-variable-regexp  . font-lock-variable-name-face)
    (,epicsdb-function-regexp  . font-lock-function-name-face)
   
  
))

;;
;; vdb, db, dbd
;; http://www.emacswiki.org/emacs/AutoModeAlist

(add-to-list 'auto-mode-alist '("\\.?db?\\'" . epicsdb-mode))
;;(add-to-list 'auto-mode-alist '("\\.db\\'" . epicsdb-mode))
;;(add-to-list 'auto-mode-alist '("\\.dbd\\'" . epicsdb-mode))




;; (defvar epicsdb-indent-offset 4
;;   "*Indentation offset for `epicsdb-mode'.")

;; (defun epicsdb-indent-line ()
;;   "Indent current line for `epicsdb-mode'."
;;   (interactive)
;;   (let ((indent-col 0))
;;     (save-excursion
;;       (beginning-of-line)
;;       (condition-case nil
;;           (while t
;;             (backward-up-list 1)
;;             (when (looking-at "[[{]")
;;               (setq indent-col (+ indent-col epicsdb-indent-offset))))
;;         (error nil)
;; 	)
;;       )
;;     (save-excursion
;;       (back-to-indentation)
;;       (when (and (looking-at "[[}]") (>= indent-col epicsdb-indent-offset))
;;         (setq indent-col (- indent-col epicsdb-indent-offset))
;; 	)
;;       )
;;     (indent-line-to indent-col)
;;     )
;;   )



;; define the mode
(define-derived-mode epicsdb-mode sh-mode
  "epicsdb mode"
  "Major mode for editing EPICS DB, DBD, and VDB files …"
  :syntax-table epicsdb-mode-syntax-table
  (setq font-lock-defaults '((epicsdb-font-lock-keywords)))

  (setq comment-start "#")
  (setq comment-start-skip "#+\\s-*")

  ;; clear memory
  (setq epicsdb-keyword nil)
  (setq epicsdb-types nil)
  (setq epicsdb-constant nil)
  (setq epicsdb-variable nil)
  (setq epicsdb-function nil)

  ;; (make-local-variable 'epicsdb-indent-offset)
  ;; (setq (make-local-variable 'indent-line-function) 'epicsdb-indent-line)


)


(provide 'epicsdb-mode)