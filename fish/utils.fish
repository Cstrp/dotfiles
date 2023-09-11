# Aliases
alias sniff "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump "sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias myip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ and print $1'"
alias whois "whois -h whois-servers.net"
alias fs="stat -f \"%z bytes\""
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Functions 
function digga --description "All the dig info"
    dig +nocmd $argv[1] any +multiline +noall +answer
end

function randpw --description "generate a random password"
    dd if=/dev/urandom bs=1 count=16 2>/dev/null | base64 | rev | cut -b 2- | rev
end

function cd --description "auto ls for each cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        and ls -al
    else
        builtin cd ~
        and ls -al
    end
end

function rename --description "Rename a symbol recursively in a folder"
    rg -l "$argv[1]" | xargs -I\{\} perl -i -pe "s/$argv[1]/$argv[2]/g" \{\}
end

function extract --description "Expand or extract bundled & compressed files"
    set --local ext (echo $argv[1] | awk -F. '{print $NF}')
    switch $ext
        case tar # non-compressed, just bundled
            tar -xvf $argv[1]
        case gz
            if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar # tar bundle compressed with gzip
                tar -zxvf $argv[1]
            else # single gzip
                gunzip $argv[1]
            end
        case tgz # same as tar.gz
            tar -zxvf $argv[1]
        case bz2 # tar compressed with bzip2
            tar -jxvf $argv[1]
        case rar
            unrar x $argv[1]
        case zip
            unzip $argv[1]
        case '*'
            echo "unknown extension"
    end
end
