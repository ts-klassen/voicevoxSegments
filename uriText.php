<?php
$texts = file("input.utf8");
for($i=0;$i<count($texts);$i++)
  echo urlencode($texts[$i]) . "\n";
