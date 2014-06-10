set mol [molinfo top] 

set out [open 2LMN-32-dE22-rg.dat w] 

set sel [atomselect top "protein"] 
set frames [molinfo $mol get numframes]
puts "Frames: $frames"

for {set i 0} {$i < $frames} {incr i} { 
    $sel frame $i 
	#puts "Frame $i"
   	puts $out "$i [measure rgyr $sel]" 
#    puts "$i [measure rgyr $sel]" 
	
} 

close $out
