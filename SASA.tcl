set protein [atomselect top "protein"]
set n [molinfo top get numframes]

set output [open "out.dat" w]

#set sel [atomselect top " "]
#set sel [atomselect top "resid 23 to 30"]
#set sel [atomselect top "resid 23 to 30 or resid 63 to 70 or resid 102 to 110 or resid 143 to 150 or resid 183 to 190 or resid 223 to 230 or resid 263 to 270 or resid 303 to 310 or resid 343 to 350 or resid 383 to 390 or resid 423 to 430 or resid 463 to 470 or resid 503 to 510 or resid 543 to 550 or resid 583 to 590 or resid 623 to 630 or resid 663 to 670 or resid 703 to 710 or resid 743 to 750"]
#set sel [atomselect top "resid 23 to 30 or resid 62 to 69 or resid 101 to 108 or resid 140 to 147 or resid 179 to 186 or resid 218 to 225 or resid 257 to 264 or resid 296 to 303 or resid 335 to 342 or resid 374 to 381 or resid 413 to 420 or resid 452 to 459 or resid 491 to 498 or resid 530 to 537 or resid 569 to 576 or resid 608 to 615 or resid 657 to 654 or resid 686 to 693 or resid 725 to 732"]


# sasa calculation loop
for {set i 0} {$i < $n} {incr i} {
    molinfo top set frame $i
    set sasa [measure sasa 1.4 $protein -restrict $sel]
#    set sasa [measure sasa 1.4 $protein]
#    puts "\t \t progress: $i/$n"
    puts $output "$sasa"
}

puts "\t \t progress: $n/$n"
puts "Done."

close $output