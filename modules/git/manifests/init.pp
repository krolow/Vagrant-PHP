class git {
    
    exec {
        "/usr/bin/apt-get update":
            command => "/usr/bin/apt-get update" 
    }

    package {
        "git":
            ensure => present,
            require => Exec["/usr/bin/apt-get update"]
    }
    
    package {
        "git-svn":
            ensure => present,
            require => [Package["git"], Exec["/usr/bin/apt-get update"]]
    }

    $gitConfig = [
        "/usr/bin/git config --global user.name \"${params::gitUser}\"",
        "/usr/bin/git config --global user.email ${params::gitEmail}",
        "/usr/bin/git config --global alias.st status",
        "/usr/bin/git config --global alias.ci commit",
        "/usr/bin/git config --global alias.co checkout",
        "/usr/bin/git config --global alias.br branch",
        "/usr/bin/git config --global color.branch auto",
        "/usr/bin/git config --global color.diff auto",
        "/usr/bin/git config --global color.interactive auto",
        "/usr/bin/git config --global color.status auto"
    ]

    exec {
        $gitConfig:
        require => Package['git']
    }

}