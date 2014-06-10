# Kipp <kippjohnson@uchicago.edu>
# for questions
#
# To run this file, from the TK console
# type "source RMSF.tcl" (without quotes)
# with a trajectory already loaded in VMD
#
# Script calculates RMSF of each 
# backbone CA in your molecule
#
# Set output name below (in quotes)
set outfile [open "sample-name.dat" w]
set sel [atomselect top all]
set sel0 [$sel num]

## Below are old selection used before; define your own selection
#set sel [atomselect top " "]

#set sel [atomselect top "segname P1 P6 and name CA"]
#set sel [atomselect top "segname P1 P6 P7 P12 P13 P18 and name CA"]
#set sel [atomselect top "(resid 9 to 40 or resid 49 to 80 or resid 89 to 120 or resid 129 to 160 or resid 169 to 200 or resid 209 to 240 or resid 249 to 280 or resid 289 to 320 or resid 329 to 360 or resid 369 to 400 or resid 409 to 440 or resid 449 to 480 or resid 489 to 520) and name CA"]
#set sel [atomselect top "(resid  9  to 40 or resid  49  to 80 or resid  89  to 120 or resid  129  to 160 or resid  169  to 200 or resid  209  to 240 or resid  249  to 280 or resid  289  to 320 or resid  329  to 360 or resid  369  to 400 or resid  409  to 440 or resid  449  to 480 or resid  489  to 520 or resid  529  to 560 or resid  569  to 600 or resid  609  to 640 or resid  649  to 680 or resid  689  to 720) and name CA"]

# Change the number below to change steps that are skipped 
# When calculating RMSF (suggest 5 or 10 for larger DCDs) {equiv. to "stride"}
set stepsize 1

set nframes [molinfo top get numframes]
set nframes2 [expr $nframes - 1]
set nframes3 [expr $nframes2 - 100]; #Otherwise set == 1; this calculates last 100 frames

# Comment out below line if you do not want a header in output
puts $outfile "Residue \t RMSF"

for {set i 0} {$i < [$sel num]} {incr i} { 
     set rmsf [measure rmsf $sel first $nframes3 last $nframes2 step $stepsize] 
     puts $outfile "[expr {$i+1}] \t [lindex $rmsf $i]" 
} 

close $outfile

# output will be file with two tab-seperated columns
# first column = residue number
# second column = RMSF
#
# the following R code will produce a quick plot
# Just input data file location
#
# par = mfrow(1,1)
# rmsf = read.table("<rmsf.dat-file-location>",header=TRUE, sep="\t")
# plot(rmsf$V1, rmsf$V2, type="l", col="RED", xlab="Residue Number", ylab="RMSF (Å)")
#