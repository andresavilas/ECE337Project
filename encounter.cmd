#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Wed Apr 29 21:45:55 2015                #
#                                                     #
#######################################################

#@(#)CDS: Encounter v09.11-s084_1 (64bit) 04/26/2010 12:41 (Linux 2.6)
#@(#)CDS: NanoRoute v09.11-s008 NR100226-1806/USR63-UB (database version 2.30, 93.1.1) {superthreading v1.14}
#@(#)CDS: CeltIC v09.11-s011_1 (64bit) 03/04/2010 14:24:46 (Linux 2.6.9-78.0.25.ELsmp)
#@(#)CDS: CTE 09.11-s016_1 (64bit) Apr  8 2010 03:29:23 (Linux 2.6.9-78.0.25.ELlargesmp)
#@(#)CDS: CPE v09.11-s023

loadConfig ./encounter.conf
floorPlan -r 1.0 0.6 50 50 50 50
addRing -spacing_bottom 9.9 -width_left 9.9 -width_bottom 9.9 -width_top 9.9 -spacing_top 9.9 -layer_bottom metal1 -width_right 9.9 -around core -center 1 -layer_top metal1 -spacing_right 9.9 -spacing_left 9.9 -layer_right metal2 -layer_left metal2 -offset_top 9.9 -offset_bottom 9.9 -offset_left 9.9 -offset_right 9.9 -nets { gnd vdd }
setPlaceMode -congEffort medium
placeDesign -inPlaceOpt
checkPlace
sroute -noBlockPins -noPadRings
trialRoute
timeDesign -preCTS
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -preCTS -drv
createClockTreeSpec -output encounter.cts
specifyClockTree -file encounter.cts
ckSynthesis -rguide cts.rguide -report report.ctsrpt -macromodel report.ctsmdl -fix_added_buffers
trialRoute
timeDesign -postCTS
setExtractRCMode -default -assumeMetFill
extractRC -outfile encounter.cap
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -postCTS -hold
optDesign -postCTS -drv
