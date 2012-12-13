class git($gitUser, $gitEmail) {
    
    package {
        "git":
            ensure => latest,
            require => Exec["apt-get update"]
    }

    package {
        "git-svn":
            ensure => latest,
            require => Exec["apt-get update"]
    }

    exec {
        "git-config":
            command => 
    }

    exec {
        "git-alias":
            command => "git config --global alias.st status && git config --global alias.ci commit && git config --global alias.co checkout && git config --global alias.br branch"
    }

    exec {
        "git-color":
            command => "git config --global color.branch auto && git config --global color.diff auto && git config --global color.interactive auto && git config --global color.status auto" 
    }

}