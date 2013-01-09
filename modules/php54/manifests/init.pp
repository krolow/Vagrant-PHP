class php54 {
    
    include pear

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
        "php5-curl"
    ]

    package { 
        $phpPackages:
            ensure => "installed",
            require => Exec["/usr/bin/apt-get update"],
            notify => Service[""]
    }

    pear::package { "PEAR": 
        package => "PEAR",
        require => Package["php5"]
    }

    # PHPUnit
    pear::package { "PHPUnit":
        package => "PHPUnit",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["PEAR"],
    }

    # Pdepend
    pear::package { "PHP_Depend":
        package => "PHP_Depend",
        version => "beta",
        repository => "pear.pdepend.org",
        require => Pear::Package["PEAR"],
    }

    # PHPMD
    pear::package { "PHP_PMD":
        package => "PHP_PMD",
        version => "latest",
        repository => "pear.phpmd.org",
        require => Pear::Package["PHP_Depend"],
    }

    # PHP CPD
    pear::package { "Base":
        package => "Base",
        version => "latest",
        repository => "components.ez.no",
        require => Pear::Package["PEAR"],
    }

    pear::package { "ConsoleTools":
        package => "ConsoleTools",
        version => "latest",
        repository => "components.ez.no",
        require => Pear::Package["Base"],
    }

    pear::package { "File_Iterator":
        package => "File_Iterator",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["PEAR"],
    }

    pear::package { "phpcpd":
        package => "phpcpd",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["Base"],
    }

    # PHPLOC
    pear::package { "phploc":
        package => "phploc",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["Base"],
    }

    # PHPDCD
    pear::package { "phpdcd":
        package => "phpdcd",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["Base"],
    }

    # PHP_CodeSniffer
    pear::package { "PHP_CodeSniffer":
        package => "PHP_CodeSniffer",
        version => "latest",
        repository => "pear.php.net",
        require => Pear::Package["PEAR"],
    }

    # Bytekit
    pear::package { "bytekit":
        package => "bytekit",
        version => "latest",
        repository => "pear.phpunit.de",
        require => Pear::Package["File_Iterator"],
    }

    # Phing
    pear::package { "Phing":
        package => "Phing",
        version => "latest",
        repository => "pear.phing.info",
        require => Pear::Package["PEAR"],
    }

    pear::package { "phpDox":
        package => "phpDox",
        version => 'latest',
        repository => "pear.netpirates.net"
    }

    pear::package { "DocBlox":
        package => "DocBlox",
        version => 'latest',
        repository => "pear.docblox-project.org"
    }    

}