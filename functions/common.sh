createmp3() {
    filename_orig = $(basename $1)
    filename = "${filename_orig%.*}"
    ffmpeg -i $filename_orig -codec:a libmp3lame -b:a 320k "$filename.mp3"
}

print-colors() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
