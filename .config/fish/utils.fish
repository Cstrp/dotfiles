# Aliases
alias myip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

# Functions 
function randpw --description "generate a random password"
    dd if=/dev/urandom bs=1 count=16 2>/dev/null | base64 | rev | cut -b 2- | rev
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
