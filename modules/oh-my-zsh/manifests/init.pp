class oh-my-zsh {

    package {
        "zsh":
            ensure => "installed"
    }
    
    exec {
        "install":
            command => 'wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh'
    }

}