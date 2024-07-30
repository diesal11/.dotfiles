createmp3() {
    local filename_orig=$(basename $1)
    local filename="${filename_orig%.*}"
    ffmpeg -i $filename_orig -codec:a libmp3lame -b:a 320k "$filename.mp3"
}

print-colors() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# https://unix.stackexchange.com/a/81699/37512
alias wanip='dig @resolver4.opendns.com myip.opendns.com +short' 
alias wanip4='dig @resolver4.opendns.com myip.opendns.com +short -4'
alias wanip6='dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6'

