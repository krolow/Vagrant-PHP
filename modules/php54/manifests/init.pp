class php54 {

    include composer

    file { "/etc/apt/sources.list":
        ensure => file,
        owner => root,
        group => root,
        source => "puppet:///modules/php54/sources.list",
    }

    exec { "import-gpg":
        command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -"
    }

    package { "php5":
        ensure => latest,
        require => Exec["/usr/bin/apt-get update"]
    }

    $phpPackages =  [
        "php5-cli", 
        "php5-common", 
        "php5-apc", 
        "php5-intl", 
        "php5-xdebug", 
        "php5-sqlite", 
        "php5-dev",
        "php5-fpm",
        "php5-gd",
        "php5-curl",
        "php5-mysql"
    ]

    package { 
        $phpPackages:
            ensure => "installed",
            require => Exec["/usr/bin/apt-get update"],
            notify => Service[""]
    }

    package { "php-pear":
        ensure => latest,
        require => [Package["php5"], Exec["/usr/bin/apt-get update"]]
    }

    exec { "pear upgrade":
        require => Package["php-pear"]
    }

    exec { "pear config-set auto_discover 1":
        require => Exec["pear upgrade"]
    }

    exec { "pear install pear.phpqatools.org/phpqatools; true":
        require => [Exec["pear config-set auto_discover 1"]],
        timeout => 0
    }

}
