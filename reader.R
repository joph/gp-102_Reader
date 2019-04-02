library(tidyverse)


parse_coord <-function(str, index) {
  str = unpack('V', substr(str, index, 4))[1]
  return(substr(str, 0, 2).'.'.substr(str, 2))
}


if (count($argv) < 2) {
  echo "Usage: ./program.php <file1> [<file2> ...]\n";
  exit(1);
}
$typeNames = ['star', 'home', 'checkpoint', 'car',
              'cafe', 'train', 'gas', 'office', 'airport'];
$stderr = fopen('php://stderr', 'w');
array_shift($argv);
foreach ($argv as $file) {
  if (is_file($file)) {
    if (is_readable($file)) {
      if (filesize($file) == 128) {
        $content = file_get_contents($file);
        $type = $typeNames[ord($content[1])];
        $name = substr($content, 12, 9);
        $latitude = parse_coord($content, 76);
        $longitude = parse_coord($content, 80);
        echo "$name $latitude $longitude $type\n";
      } else {
        fwrite($stderr, "ERROR: '$file' is not a valid POI file.\n");
      }
    } else {
      fwrite($stderr, "ERROR: '$file' is not readable.\n");
    }
  } else {
    fwrite($stderr, "ERROR: '$file' is not a file.\n");
  }
}
fclose($stderr);