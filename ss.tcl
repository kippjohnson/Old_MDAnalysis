
set outfile [open 2LMN-40-hex-ss.dat w] 

set sel [atomselect top "protein and name CA"] 
set nf [molinfo top get numframes]

for { set i 0 } { $i < $nf } { incr i } { 
    animate goto $i 
    display update ui 
    $sel frame $i 
    mol ssrecalc top 
    set secstruct [$sel get structure] 
    puts $outfile "$i \t $secstruct" 
} 