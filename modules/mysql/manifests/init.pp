class mysql {
    
    package {
        "mysql-server":
            ensure => present,
            require => Exec["/usr/bin/apt-get update"]
    }
    
    service { 
        "mysql":
            ensure => running,
            hasstatus => true,
            hasrestart => true,
            require => Package["mysql-server"],
    }

}