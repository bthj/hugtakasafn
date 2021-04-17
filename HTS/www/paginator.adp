<%
upvar offset offset
if { ![info exists offset] } {
  set offset 0
}
upvar max max
if { ![info exists max] } {
  set max 10
}
upvar blockSize blockSize
if { ![info exists blockSize] } {
  set blockSize 10
}
upvar count count
upvar path path

if { $max < $count } {
set outs ""

set pageCount [expr ceil($count / $max)]
set blockCount [expr ceil($pageCount / $blockSize)]

if { $offset >= $max } {
  append outs "<b><a href=\"$path&o=[expr $offset - $max]\">&#171;&#32;fyrri</a></b>&nbsp;"
}
append outs "&#91;"
if { $blockCount > 1 } {
  set blockNr [expr floor($offset / $max / $blockSize)]
  set blockFirstPage [expr int($blockNr) * $blockSize]
  if { $blockNr >= 1 } {
    append outs "<a href=\"$path&o=0\">fyrsta</a>&nbsp;"
    append outs "<a href=\"$path&o=[expr ($blockFirstPage * $max) - $max]\">&lt;&lt;</a>&nbsp;"
  }
  if { $blockCount == [expr $blockNr + 1] } {
    for {set i [expr $blockFirstPage + 1]} {$i <= [expr $pageCount + 1]} {incr i} {
      set nuOffset [expr ($i - 1) * $max]
      if { $offset == $nuOffset } {
        append outs "<b>$i</b>&nbsp;"
      } else {
        append outs "<a href=\"$path&o=$nuOffset\">$i</a>&nbsp;"
      }
    }
  } else {
    for {set i [expr $blockFirstPage + 1]} {$i <= [expr $blockFirstPage + $blockSize]} {incr i} {
      set nuOffset [expr ($i - 1) * $max]
      if { $offset == $nuOffset } {
        append outs "<b>$i</b>&nbsp;"
      } else {
        append outs "<a href=\"$path&o=$nuOffset\">$i</a>&nbsp;"
      }
    }
  }
  if { $blockCount != [expr $blockNr + 1] } {
    append outs "<a href=\"$path&o=[expr ($blockFirstPage + $blockSize) * $max]\">&gt;&gt;</a>&nbsp;"
    if { 0 == [expr $count % $max] } {
      append outs "<a href=\"$path&o=[expr int((floor($count / $max) * $max) - $max)]\">síðasta</a>"
    } else {
      append outs "<a href=\"$path&o=[expr int(floor($count / $max) * $max)]\">síðasta</a>"
    }
  }
} else {
  for {set i 1} {$i <= [expr $pageCount + 1]} {incr i} {
    set nuOffset [expr ($i - 1) * $max]
    if { $offset == $nuOffset } {
      append outs "<b>$i</b>&nbsp;"
    } else {
      append outs "<a href=\"$path&o=$nuOffset\">$i</a>&nbsp;"
    }
  }
}
append outs "&#93;"
if { $offset != [expr ($pageCount) * $max] } {
  append outs "&nbsp;<b><a href=\"$path&o=[expr $offset + $max]\">næsta&#32;&#187;</a></b>"
}

ns_adp_puts $outs
}
%>
